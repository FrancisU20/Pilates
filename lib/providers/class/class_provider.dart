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

  //? Setters Variables
  void setSelectedHourIndex(int selectedHourIndex) {
    this.selectedHourIndex = selectedHourIndex;
    notifyListeners();
  }

  //? Clean Variables
  void cleanSelectedHourIndex() {
    selectedHourIndex = null;
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

  //? Eliminar toda la data
  void clearData() {
    cleanSelectedHourIndex();
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
      CustomSnackBar.show(
        context,
        availableClasses.isEmpty
            ? 'Lo sentimos, nuestro horario está completo 😓'
            : 'Clases cargadas correctamente 🎉',
        availableClasses.isEmpty ? SnackBarType.error : SnackBarType.success,
      );
    } catch (e) {
      Logger.logAppError('Error en getClasses $e');
      CustomSnackBar.show(context, e.toString(), SnackBarType.error);
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

      //? Ordenar las clases por hora
      userClassFilter.sort(
          (a, b) => a.schedule!.startHour.compareTo(b.schedule!.startHour));

      setListClassFilter(userClassFilter);
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
