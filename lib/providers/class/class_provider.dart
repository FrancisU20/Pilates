import 'package:flutter/material.dart';
import 'package:pilates/common/logger.dart';
import 'package:pilates/controllers/class/class_controller.dart';
import 'package:pilates/controllers/user-class/user_class_controller.dart';
import 'package:pilates/middleware/app_middleware.dart';
import 'package:pilates/models/common/standard_response.dart';
import 'package:pilates/models/class/class_model.dart';
import 'package:pilates/models/user-class/user_class_create_model.dart';
import 'package:pilates/models/user-class/user_class_model.dart';
import 'package:pilates/providers/login/login_provider.dart';
import 'package:pilates/theme/widgets/custom_snack_bar.dart';
import 'package:provider/provider.dart';

class ClassProvider extends ChangeNotifier {
  //****************************************/
  //? Controllers
  ClassController classController = ClassController();
  UserClassController userClassController = UserClassController();

  //? Packages

  //****************************************/
  //? Variables
  int? selectedHourIndex;
  int availableSlots = 0;

  //? Setters Variables
  void setSelectedHourIndex(int selectedHourIndex) {
    this.selectedHourIndex = selectedHourIndex;
    notifyListeners();
  }

  void setAvailableSlots(int availableSlots) {
    this.availableSlots = availableSlots;
    notifyListeners();
  }

  //? Clean Variables
  void cleanSelectedHourIndex() {
    selectedHourIndex = null;
    notifyListeners();
  }

  void cleanAvailableSlots() {
    availableSlots = 0;
    notifyListeners();
  }

  //****************************************/
  //? Objetos
  ClassModel? selectedClass;

  //? Setters Objetos
  void setSelectedClass(ClassModel selectedClass) {
    this.selectedClass = selectedClass;
    notifyListeners();
  }

  //? Clean Objetos
  void cleanSelectedClass() {
    selectedClass = null;
    notifyListeners();
  }

  //****************************************/
  //? Listas
  List<ClassModel> listClass = [];
  List<ClassModel> listClassFilter = [];

  //? Setters Listas
  void setListClass(List<ClassModel> listClass) {
    this.listClass = listClass;
    notifyListeners();
  }

  void setListClassFilter(List<ClassModel> listClassFilter) {
    this.listClassFilter = listClassFilter;
    notifyListeners();
  }

  //? Clean Listas
  void cleanListClass() {
    listClass = [];
    notifyListeners();
  }

  void cleanListClassFilter() {
    listClassFilter = [];
    notifyListeners();
  }

  //****************************************/
  //? Reutilizables
  bool isLoading = false;

  //? Setters Reutilizables
  void showLoading() {
    isLoading = true;
    notifyListeners();
  }

  void hideLoading() {
    isLoading = false;
    notifyListeners();
  }

  //! Eliminar toda la data
  void reset() {
    cleanSelectedHourIndex();
    cleanAvailableSlots();
    cleanSelectedClass();
    cleanListClass();
    cleanListClassFilter();
  }

  //****************************************/
  //**************VALIDADORES***************/
  //****************************************/
  //?

  //****************************************/
  //***************FUNCIONES****************/
  //****************************************/
  //? Obtener Clases y Horarios
  Future<void> getClassList(BuildContext context) async {
    try {
      showLoading();

      StandardResponse<List<ClassModel>> response =
          await classController.getClassList();

      //? Filtrar solo las clases que tiene availableClasses > 0
      List<ClassModel> availableClasses = response.data!
          .where((element) => element.availableClasses > 0)
          .toList();

      setListClass(availableClasses);

      if (!context.mounted) return;
      if (availableClasses.isEmpty) {
        CustomSnackBar.show(
          context,
          'Lo sentimos, nuestros horarios están completos 😓',
          SnackBarType.error,
        );
      }
    } catch (e) {
      Logger.logAppError('Error en getClasses $e');
      CustomSnackBar.show(context, e.toString(), SnackBarType.error);
    } finally {
      hideLoading();
    }
  }

  //? Obtener Clases y Horarios
  Future<int> checkAvailableSlots(BuildContext context, String classId) async {
    try {
      showLoading();

      StandardResponse<ClassModel> response =
          await classController.getClass(classId);
      ClassModel availableSlots = response.data!;

      if (availableSlots.availableClasses == 0) {
        if (context.mounted) {
          CustomSnackBar.show(
            context,
            'Los cupos para esta clase ya están completos',
            SnackBarType.error,
          );
        }
      }

      return availableSlots.availableClasses;
    } catch (e) {
      Logger.logAppError('Error en getClasses $e');
      if (context.mounted) {
        CustomSnackBar.show(context, e.toString(), SnackBarType.error);
      }
      return 0; // Ensure an integer is returned even in case of an error
    } finally {
      hideLoading();
    }
  }

  //? Filtar las clases por fecha seleccionada
  Future<void> filterClassByDate(
      BuildContext context, DateTime selectedDate) async {
    try {
      showLoading();
      //? Eliminar la clase seleccionada
      cleanSelectedClass();

      List<ClassModel> userClassFilter = listClass
          .where((element) =>
              element.classDate.substring(0, 10) ==
              selectedDate.toString().substring(0, 10))
          .toList();

      DateTime now = DateTime.now().toUtc().subtract(const Duration(hours: 5));

      List<ClassModel>  filterByHour = userClassFilter.where((element) {
        int year = int.parse(element.classDate.substring(0, 4));
        int month = int.parse(element.classDate.substring(5, 7));
        int day = int.parse(element.classDate.substring(8, 10));
        int hour = int.parse(element.schedule!.startHour.substring(0, 2));
        int minute = int.parse(element.schedule!.startHour.substring(3, 5));

        DateTime classDate = DateTime(year, month, day, hour, minute);

        if (classDate.isAfter(now.subtract(const Duration(hours: 3)))) {
          return true;
        } 
        return false;
      }).toList();

      //? Ordenar las clases por hora
      filterByHour.sort(
          (a, b) => a.schedule!.startHour.compareTo(b.schedule!.startHour));

      setListClassFilter(filterByHour);
    } catch (e) {
      Logger.logAppError('Error en filterClassByDate $e');
    } finally {
      hideLoading();
    }
  }

  //? Crear una clase
  Future<void> createClass(BuildContext context) async {
    try {
      showLoading();
      LoginProvider loginProvider =
          Provider.of<LoginProvider>(context, listen: false);

      UserClassCreateModel userClassCreateModel = UserClassCreateModel(
        userId: loginProvider.user!.id!,
        classId: selectedClass!.id!,
      );

      StandardResponse<UserClassModel> response =
          await userClassController.createUserClass(userClassCreateModel);

      //? Redirigir a la pantalla al login
      if (!context.mounted) return;
      await AppMiddleware.updateClientData(context, '/dashboard');

      if (!context.mounted) return;
      CustomSnackBar.show(
        context,
        response.message,
        SnackBarType.success,
      );
    } catch (e) {
      CustomSnackBar.show(context, e.toString(), SnackBarType.error);
    } finally {
      hideLoading();
    }
  }
}
