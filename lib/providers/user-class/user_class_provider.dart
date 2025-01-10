import 'package:flutter/material.dart';
import 'package:pilates/common/logger.dart';
import 'package:pilates/controllers/user-class/user_class_controller.dart';
import 'package:pilates/models/common/standard_response.dart';
import 'package:pilates/models/common/update_status_model.dart';
import 'package:pilates/models/user-class/user_class_model.dart';
import 'package:pilates/providers/login/login_provider.dart';
import 'package:pilates/theme/widgets/custom_snack_bar.dart';
import 'package:provider/provider.dart';

class UserClassProvider extends ChangeNotifier {
  //****************************************/
  //? Controllers
  UserClassController userClassController = UserClassController();

  //? Packages

  //****************************************/
  //? Variables
  bool isHistory = false;

  //? Setters Variables
  void setIsHistory(bool isHistory) {
    this.isHistory = isHistory;
    notifyListeners();
  }

  //? Clean Variables
  void cleanIsHistory() {
    isHistory = false;
    notifyListeners();
  }

  //****************************************/
  //? Objetos

  //? Setters Objetos

  //? Clean Objetos

  //****************************************/
  //? Listas
  List<UserClassModel> listUserClass = [];
  List<UserClassModel> listUserClassHistory = [];

  //? Setters Listas
  void setListClass(List<UserClassModel> listUserClass) {
    this.listUserClass = listUserClass;
    notifyListeners();
  }

  void setListClassFilter(List<UserClassModel> listUserClassHistory) {
    this.listUserClassHistory = listUserClassHistory;
    notifyListeners();
  }

  //? Clean Listas
  void cleanlistUserClass() {
    listUserClass = [];
    notifyListeners();
  }

  void cleanListUserClassHistory() {
    listUserClassHistory = [];
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
    cleanIsHistory();
    cleanlistUserClass();
    cleanListUserClassHistory();
  }

  //****************************************/
  //**************VALIDADORES***************/
  //****************************************/
  //?

  //****************************************/
  //***************FUNCIONES****************/
  //****************************************/
  //? Funcion que convierrte la fecha de la clase a un formato legible
  //? Convertir fecha a formato legible
  String convertDate(String date) {
    try {
      // Validar longitud de la fecha para evitar errores al usar substring
      if (date.length < 10) {
        throw const FormatException(
            'La fecha proporcionada no tiene el formato esperado.');
      }

      String year = date.substring(0, 4);
      String month = date.substring(5, 7);
      String day = date.substring(8, 10);

      // Determinar el nombre del mes
      String monthName = '';
      switch (month) {
        case '01':
          monthName = 'Enero';
          break;
        case '02':
          monthName = 'Febrero';
          break;
        case '03':
          monthName = 'Marzo';
          break;
        case '04':
          monthName = 'Abril';
          break;
        case '05':
          monthName = 'Mayo';
          break;
        case '06':
          monthName = 'Junio';
          break;
        case '07':
          monthName = 'Julio';
          break;
        case '08':
          monthName = 'Agosto';
          break;
        case '09':
          monthName = 'Septiembre';
          break;
        case '10':
          monthName = 'Octubre';
          break;
        case '11':
          monthName = 'Noviembre';
          break;
        case '12':
          monthName = 'Diciembre';
          break;
        default:
          throw Exception('El mes proporcionado no es válido.');
      }

      // Devolver la fecha en el formato esperado
      return '$day de $monthName de $year';
    } catch (e) {
      Logger.logAppError('Error al convertir la fecha: $e');
      throw Exception('Error al convertir la fecha');
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

  //? Funcion para obtener las sigals del mes
  String getStringMonth(DateTime classDate) {
    try {
      String month = '';
      switch (classDate.month) {
        case 1:
          month = 'ENE';
          break;
        case 2:
          month = 'FEB';
          break;
        case 3:
          month = 'MAR';
          break;
        case 4:
          month = 'ABR';
          break;
        case 5:
          month = 'MAY';
          break;
        case 6:
          month = 'JUN';
          break;
        case 7:
          month = 'JUL';
          break;
        case 8:
          month = 'AGO';
          break;
        case 9:
          month = 'SEP';
          break;
        case 10:
          month = 'OCT';
          break;
        case 11:
          month = 'NOV';
          break;
        case 12:
          month = 'DIC';
          break;
      }
      return month;
    } catch (e) {
      Logger.logAppError('Error al obtener las siglas del mes: $e');
      throw Exception('Error al obtener las siglas del mes');
    }
  }

  //? Funcion para consultar las clases del cliente
  Future<void> getUserClass(BuildContext context) async {
    try {
      showLoading();
      LoginProvider loginProvider =
          Provider.of<LoginProvider>(context, listen: false);

      String userId = loginProvider.user!.id!;

      String statusFilter = isHistory ? '' : 'A';
      String startAt = isHistory
          ? ''
          : DateTime(DateTime.now().year, DateTime.now().month + 1, 0)
              .toString();

      StandardResponse<List<UserClassModel>> response =
          await userClassController.getUserClass(
        userId,
        statusFilter,
        startAt,
      );

      List<UserClassModel> listUserClass = response.data!;

      //? Cambiar estado a Completadas a la citas cuyo estado sea A y su fecha de inicio sea menor a la fecha actual y tambien compara la hora actual es mayor a la hora de finalización de la clase
      //! Obtener la fecha actual en formato UTC (Universal)
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

      if (isHistory) {
        //? filtrar todas las que no esten en estado A
        listUserClass =
            listUserClass.where((element) => element.status != 'A').toList();
      }

      if (isHistory) {
        setListClassFilter(listUserClass);
      } else {
        setListClass(listUserClass);
      }
    } catch (e) {
      if (!context.mounted) return;
      Logger.logAppError('Error al obtener las clases: $e');
      CustomSnackBar.show(context, e.toString(), SnackBarType.error);
    } finally {
      hideLoading();
    }
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
      await getUserClass(context);
    } catch (e) {
      if (!context.mounted) return;
      Logger.logAppError('Error al actualizar el estado de la clase: $e');
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    } finally {
      hideLoading();
    }
  }
}
