import 'package:flutter/widgets.dart';
import 'package:pilates/common/logger.dart';
import 'package:pilates/controllers/user-class/user_class_controller.dart';
import 'package:pilates/controllers/user-plan/user_plan_controller.dart';
import 'package:pilates/models/common/standard_response.dart';
import 'package:pilates/models/common/update_status_model.dart';
import 'package:pilates/models/plan/plan_model.dart';
import 'package:pilates/models/user-class/user_class_model.dart';
import 'package:pilates/models/user-plan/user_plan_model.dart';
import 'package:pilates/theme/widgets/custom_snack_bar.dart';
import 'package:provider/provider.dart';

class AdminProvider extends ChangeNotifier {
  //****************************************/
  //? Controllers
  final UserPlanController userPlanController = UserPlanController();
  final UserClassController userClassController = UserClassController();

  //? Packages

  //****************************************/
  //? Variables
  bool isHistory = false;
  String selectedUserId = '';
  DateTime selectedMonth =
      DateTime(DateTime.now().year, DateTime.now().month, 1);
  

  //? Setters Variables
  void setIsHistory(bool isHistory) {
    this.isHistory = isHistory;
    notifyListeners();
  }

  void setSelectedUserId(String selectedUserId) {
    this.selectedUserId = selectedUserId;
    notifyListeners();
  }

  void setSelectedMonth(DateTime selectedMonth) {
    this.selectedMonth = selectedMonth;
    notifyListeners();
  }

  //? Clean Variables
  void cleanIsHistory() {
    isHistory = false;
    notifyListeners();
  }

  void cleanSelectedUserId() {
    selectedUserId = '';
    notifyListeners();
  }

  void cleanSelectedMonth() {
    selectedMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
    notifyListeners();
  }

  //****************************************/
  //? Objetos

  //? Setters Objetos

  //? Clean Objetos

  //****************************************/
  //? Listas
  List<DateTime> listMonth = [];
  List<UserPlanModel> listUserPlans = [];

  List<UserClassModel> listUserClass = [];
  List<UserClassModel> listUserClassHistory = [];

  //! Nueva lista de clases filtrada
  List<UserClassModel> listUserClassFiltered = [];

  //? Setters Listas
  void setListMonth(List<DateTime> listMonth) {
    this.listMonth = listMonth;
    notifyListeners();
  }

  void setListUserPlans(List<UserPlanModel> listUserPlans) {
    this.listUserPlans = listUserPlans;
    notifyListeners();
  }

  void setListClass(List<UserClassModel> listUserClass) {
    this.listUserClass = listUserClass;
    notifyListeners();
  }

  void setListClassHistory(List<UserClassModel> listUserClassHistory) {
    this.listUserClassHistory = listUserClassHistory;
    notifyListeners();
  }

  //! Nueva lista de clases filtrada
  void setListClassFiltered(List<UserClassModel> listUserClassFiltered) {
    this.listUserClassFiltered = listUserClassFiltered;
    notifyListeners();
  }

  //? Clean Listas
  void cleanListMonth() {
    listMonth = [];
    notifyListeners();
  }

  void cleanListUserPlans() {
    listUserPlans = [];
    notifyListeners();
  }

  void cleanListClass() {
    listUserClass = [];
    notifyListeners();
  }

  void cleanListClassHistory() {
    listUserClassHistory = [];
    notifyListeners();
  }

  //! Nueva lista de clases filtrada
  void cleanListClassFiltered() {
    listUserClassFiltered = [];
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
  void reset() {
    cleanSelectedMonth();
    cleanListUserPlans();
    cleanListMonth();
  }

  //****************************************/
  //***************FUNCIONES****************/
  //****************************************/
  //? Funcion para obtener las sigals del mes
  String getStringMonth(DateTime classDate) {
    try {
      String month = '';
      switch (classDate.month) {
        case 1:
          month = 'Enero';
          break;
        case 2:
          month = 'Febrero';
          break;
        case 3:
          month = 'Marzo';
          break;
        case 4:
          month = 'Abril';
          break;
        case 5:
          month = 'Mayo';
          break;
        case 6:
          month = 'Junio';
          break;
        case 7:
          month = 'Julio';
          break;
        case 8:
          month = 'Agosto';
          break;
        case 9:
          month = 'Septiempre';
          break;
        case 10:
          month = 'Octubre';
          break;
        case 11:
          month = 'Noviembre';
          break;
        case 12:
          month = 'Diciembre';
          break;
      }
      return month;
    } catch (e) {
      Logger.logAppError('Error al obtener las siglas del mes: $e');
      throw Exception('Error al obtener las siglas del mes');
    }
  }

  //? Funcion que obtiene los meses del año actual
  void getMonths() {
    try {
      final DateTime now = DateTime.now();
      List<DateTime> listMonth = [];
      for (int i = 1; i <= 12; i++) {
        listMonth.add(DateTime(now.year, i));
      }
      //? Lista de meses en formato DateTime
      setListMonth(listMonth);
    } catch (e) {
      Logger.logAppError('Error al obtener los meses del año: $e');
      throw Exception('Error al obtener los meses del año');
    }
  }

  //? Funcion que convierte la hora si es es AM o PM
  String getAMFM(String hour) {
    try {
      String initialHour = hour.substring(0, 2);
      int hourInt = int.parse(initialHour);
      if (hourInt < 12) {
        return 'AM';
      } else {
        return 'PM';
      }
    } catch (e) {
      Logger.logAppError('Error al convertir la hora: $e');
      throw Exception('Error al convertir la hora');
    }
  }

  //? Actualizar Plan del Usuario
  Future<void> updateStatusUserPlan(BuildContext context,
      UserPlanModel userPlan, UpdateStatusModel updateStatus) async {
    try {
      StandardResponse<UserPlanModel> updateStatusUserPlanResponse =
          await userPlanController.updateStatusUserPlan(userPlan, updateStatus);

      if (!context.mounted) return;
      CustomSnackBar.show(
        context,
        updateStatusUserPlanResponse.message,
        updateStatusUserPlanResponse.data!.status == 'A' ||
                updateStatusUserPlanResponse.data!.status == 'C'
            ? SnackBarType.success
            : updateStatusUserPlanResponse.data!.status == 'I'
                ? SnackBarType.informative
                : SnackBarType.error,
      );
    } catch (e) {
      CustomSnackBar.show(
        context,
        e.toString(),
        SnackBarType.error,
      );
    }
  }

  //? Obtener Planes de los Usuarios
  Future<void> getUsersPlans(BuildContext context, {String? status}) async {
    try {
      showLoading();
      DateTime startDate = DateTime(selectedMonth.year, selectedMonth.month);
      DateTime endDate =
          DateTime(selectedMonth.year, selectedMonth.month + 1, 0);

      StandardResponse<List<UserPlanModel>> userPlansResponse =
          await userPlanController.getUserPlans(
              userId: null,
              status: status,
              startDate: startDate,
              endDate: endDate);

      //? Filtrar todos los planes que no sean completados status (C) y expirados status (E)
      List<UserPlanModel> listUserPlans = userPlansResponse.data!;

      //? Guardar en la lista de planes de los usuarios
      setListUserPlans(listUserPlans);
    } catch (e) {
      setListUserPlans([]);
      if (!context.mounted) return;
      CustomSnackBar.show(
        context,
        e.toString(),
        SnackBarType.error,
      );
    } finally {
      hideLoading();
    }
  }

  //? Función que obtiene el plan mas usado por los usuarios
  PlanModel getMostUsedPlan() {
    try {
      //? Lista de planes
      List<PlanModel> listPlans = [];
      //? Lista de planes de los usuarios
      for (var userPlan in listUserPlans) {
        listPlans.add(userPlan.plan);
      }

      //? Contar los planes
      Map<PlanModel, int> countPlans = {};
      for (var plan in listPlans) {
        countPlans.update(plan, (value) => value + 1, ifAbsent: () => 1);
      }

      //? Ordenar los planes
      countPlans = Map.fromEntries(countPlans.entries.toList()
        ..sort((e1, e2) => e2.value.compareTo(e1.value)));

      //? Plan mas usado
      PlanModel mostUsedPlan = countPlans.entries.first.key;

      return mostUsedPlan;
    } catch (e) {
      Logger.logAppError('Error al obtener el plan mas usado: $e');
      throw Exception('Error al obtener el plan mas usado');
    }
  }

  Future<void> getUsersClass(BuildContext context, {String? userId}) async {
    try {
      showLoading();

      String statusFilter = isHistory ? '' : 'A';
      String startAt = isHistory
          ? DateTime(selectedMonth.year, selectedMonth.month - 3, 0).toString().substring(0,10)
          : selectedMonth.toString().substring(0,10);

      StandardResponse<List<UserClassModel>> response =
          await userClassController.getUserClass(
        userId ?? '', // Si no se proporciona un userId, envía un string vacío
        statusFilter,
        startAt,
      );

      List<UserClassModel> listUserClass = response.data!;

      // Filtrar clases completadas si su fecha/hora ya pasó
      DateTime now = DateTime.now().toUtc();
      DateTime ecuadorCurrentDate = now.add(const Duration(hours: -5));
      int ecuadorCurrentHour = ecuadorCurrentDate.hour;
      int ecuadorCurrentMinute = ecuadorCurrentDate.minute;

      for (int i = 0; i < listUserClass.length; i++) {
        if (listUserClass[i].status == 'A') {
          DateTime classDate =
              DateTime.parse(listUserClass[i].classModel.classDate);
          int classEndHour = int.parse(
              listUserClass[i].classModel.schedule!.endHour.split(':')[0]);

          if (classDate.isBefore(ecuadorCurrentDate) ||
              (classDate.isAtSameMomentAs(ecuadorCurrentDate) &&
                  (ecuadorCurrentHour > classEndHour ||
                      (ecuadorCurrentHour == classEndHour &&
                          ecuadorCurrentMinute >= 0)))) {
            listUserClass[i].status = 'C';
            if (!context.mounted) return;
            await updateUserClassStatus(context, listUserClass[i].id!, 'C');
          }
        }
      }

      // Aplicar filtro para historial
      if (isHistory) {
        listUserClass =
            listUserClass.where((element) => element.status != 'A').toList();
      }

      // Filtrar por userId si se proporciona
      if (userId != null && userId.isNotEmpty) {
        listUserClass = listUserClass
            .where((element) => element.user.id == userId)
            .toList();
      }

      if (isHistory) {
        setListClassHistory(listUserClass);
        setListClassFiltered(listUserClass);
      } else {
        setListClass(listUserClass);
        setListClassFiltered(listUserClass);
      }
    } catch (e) {
      if (!context.mounted) return;
      Logger.logAppError('Error al obtener las clases: $e');
      CustomSnackBar.show(context, e.toString(), SnackBarType.error);
    } finally {
      hideLoading();
    }
  }

  //? Funcion para buscar por usuario
  void onUserSelected(BuildContext context, String? selectedUserId) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);

    setSelectedUserId(selectedUserId ?? '');

    // Llama a getUsersClass con el userId seleccionado o sin userId
    adminProvider.getUsersClass(context, userId: selectedUserId);
  }

  //? Funciona para actualizar es estado de una clase
  Future<void> updateUserClassStatus(
      BuildContext context, String userClassId, String status) async {
    try {
      showLoading();

      UpdateStatusModel updateStatusModel = UpdateStatusModel(status: status);

      StandardResponse<UserClassModel> updateUserClassResponse =
          await userClassController.updateUserClass(
        userClassId,
        updateStatusModel,
      );

      Logger.logCustomMessage(
          'Clase ${updateUserClassResponse.data!.status} cambio al estado: ',
          updateUserClassResponse.data!.status);

      if (!context.mounted) return;
      await getUsersClass(context);
    } catch (e) {
      if (!context.mounted) return;
      Logger.logAppError('Error al actualizar el estado de la clase: $e');
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    } finally {
      hideLoading();
    }
  }
}
