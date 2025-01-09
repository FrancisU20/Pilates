import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pilates/common/logger.dart';
import 'package:pilates/controllers/file-asset/file_asset_controller.dart';
import 'package:pilates/controllers/user-plan/user_plan_controller.dart';
import 'package:pilates/models/common/standard_response.dart';
import 'package:pilates/models/common/update_status_model.dart';
import 'package:pilates/models/file-asset/file_asset_model.dart';
import 'package:pilates/models/plan/plan_model.dart';
import 'package:pilates/models/user-plan/user_plan_create_model.dart';
import 'package:pilates/models/user-plan/user_plan_model.dart';
import 'package:pilates/providers/login/login_provider.dart';
import 'package:pilates/theme/widgets/custom_snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;

class UserPlanProvider extends ChangeNotifier {
  //****************************************/
  //? Controllers
  final FileAssetController fileAssetController = FileAssetController();
  final UserPlanController userPlanController = UserPlanController();

  //? Packages
  final ImagePicker imagePicker = ImagePicker();

  //****************************************/
  //? Variables
  String userPaymentImage = '';

  //? Setters Variables
  void setUserPaymentImage(String image) {
    userPaymentImage = image;
    notifyListeners();
  }

  //? Limpiar Variables
  void clearUserPaymentImage() {
    userPaymentImage = '';
    notifyListeners();
  }

  //****************************************/
  //? Objetos
  PlanModel? selectedPlan;
  UserPlanModel? activeUserPlan;
  UserPlanModel? inactiveUserPlan;

  //? Setters Objetos
  void setSelectedPlan(PlanModel plan) {
    selectedPlan = plan;
    notifyListeners();
  }

  void setActiveUserPlan(UserPlanModel userPlan) {
    activeUserPlan = userPlan;
    notifyListeners();
  }

  void setInactiveUserPlan(UserPlanModel userPlan) {
    inactiveUserPlan = userPlan;
    notifyListeners();
  }

  //? Limpiar Objetos
  void clearSelectedPlan() {
    selectedPlan = null;
    notifyListeners();
  }

  void clearActiveUserPlan() {
    activeUserPlan = null;
    notifyListeners();
  }

  void clearInactiveUserPlan() {
    inactiveUserPlan = null;
    notifyListeners();
  }

  //****************************************/
  //? Listas
  List<UserPlanModel> listUserPlans = [];

  //? Setters Listas
  void setListUserPlans(List<UserPlanModel> list) {
    listUserPlans = list;
    notifyListeners();
  }

  //? Limpiar Listas
  void clearListUserPlans() {
    listUserPlans = [];
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
    clearUserPaymentImage();
    clearSelectedPlan();
    clearActiveUserPlan();
    clearInactiveUserPlan();
    clearListUserPlans();
    notifyListeners();
  }

  //****************************************/
  //**************VALIDADORES***************/
  //****************************************/
  //?

  //****************************************/
  //***************FUNCIONES****************/
  //****************************************/
  //? Comprimir imagen
  Future<XFile> compressImage(XFile file) async {
    try {
      final String uuid = UniqueKey().toString();

      // Extraemos el directorio y generamos un nombre único con extensión .jpg
      final dir = p.dirname(file.path);
      final fileName = p.basenameWithoutExtension(file.path);

      // Aseguramos que el archivo de salida tenga extensión .jpg
      final uniqueTargetPath = p.join(dir, '${fileName}_compressed_$uuid.jpg');

      // Comprimimos la imagen y forzamos la conversión a JPEG
      var result = await FlutterImageCompress.compressAndGetFile(
        file.path,
        uniqueTargetPath,
        format: CompressFormat.jpeg, // Forzamos el formato JPEG
        quality: 60,
        minHeight: 1280,
        minWidth: 720,
      );

      if (result == null) {
        throw Exception('La compresión de la imagen falló.');
      }

      return XFile(result.path);
    } catch (e) {
      Logger.logAppError('Error al comprimir la imagen: $e');
      throw Exception(
          'Formato de imagen no soportado. Seleccione otra imagen e intente nuevamente.');
    }
  }

  //? Convertir imagen a archivo
  Future<MultipartFile> convertToFile(XFile file) async {
    try {
      MultipartFile multipartFiles = MultipartFile.fromBytes(
        'file',
        await file.readAsBytes(),
        filename: file.name,
      );
      return multipartFiles;
    } catch (e) {
      Logger.logAppError('Error al convertir el archivo a file:$e');
      throw Exception(
          'Formato de imagen no soportado. Seleccione otra imagen e intente nuevamente.');
    }
  }

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
      return 'Error al convertir la fecha';
    }
  }

  //? Crear Plan del Usuario
  Future<void> createUserPlan(BuildContext context) async {
    try {
      // Leer el provider del Login para obtener la data del usuario
      LoginProvider loginProvider =
          Provider.of<LoginProvider>(context, listen: false);
      UserPlanCreateModel newUserPlan = UserPlanCreateModel(
          userId: loginProvider.user!.id!,
          planId: selectedPlan!.id!,
          paymentPhoto: userPaymentImage);

      StandardResponse<UserPlanModel> createUserPlanResponse =
          await userPlanController.createUserPlan(newUserPlan);

      if (!context.mounted) return;

      CustomSnackBar.show(
        context,
        createUserPlanResponse.message,
        SnackBarType.success,
      );
    } catch (e) {
      setUserPaymentImage('');
      CustomSnackBar.show(
        context,
        e.toString(),
        SnackBarType.error,
      );
    }
  }

  //? Capturar Imagen (Tambien crea el plan del usuario)
  Future<void> pickImage(
      BuildContext context, ImageSource source, String dni) async {
    try {
      showLoading();
      final XFile? imageSelected = await imagePicker.pickImage(source: source);
      if (imageSelected == null) {
        return;
      }
      XFile compressedImage = await compressImage(imageSelected);
      MultipartFile multipartFile = await convertToFile(compressedImage);

      StandardResponse<FileAssetModel> fileAssetResponse =
          await fileAssetController.postS3File(
              multipartFile, 'clients-payments', dni);

      setUserPaymentImage(fileAssetResponse.data!.path);

      // Crear el plan del usuario
      if (!context.mounted) return;
      await createUserPlan(context);
    } catch (e) {
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

  //? Obtener Planes del Usuario (Activo e Inactivo)
  Future<void> getUserPlans(BuildContext context,
      {String? status, DateTime? startDate, DateTime? endDate}) async {
    try {
      showLoading();
      //? Se limpia los planes del usuario
      clearActiveUserPlan();
      clearInactiveUserPlan();

      LoginProvider loginProvider =
          Provider.of<LoginProvider>(context, listen: false);

      StandardResponse<List<UserPlanModel>> userPlansResponse =
          await userPlanController.getUserPlans(
              userId: loginProvider.user!.id,
              status: status,
              startDate: startDate,
              endDate: endDate);

      //? Filtrar todos los planes que no sean completados status (C) y expirados status (E)
      List<UserPlanModel> filteredUserPlans = userPlansResponse.data!
          .where((userPlan) => userPlan.status != 'C' && userPlan.status != 'E')
          .toList();

      if (!context.mounted) return;
      //? Verificar solo de los planes activos (A) si estan vencidos y actualizar su status
      for (UserPlanModel userPlan in filteredUserPlans) {
        if (userPlan.status == 'A') {
          DateTime planEnd = userPlan.planEnd;
          if (planEnd.isBefore(DateTime.now())) {
            UpdateStatusModel updateStatus = UpdateStatusModel(status: 'E');
            await updateStatusUserPlan(context, userPlan, updateStatus);
          } else if (userPlan.scheduledClasses == userPlan.plan.classesCount) {
            UpdateStatusModel updateStatus = UpdateStatusModel(status: 'C');
            await updateStatusUserPlan(context, userPlan, updateStatus);
          }
        }
      }

      //? Volver a consultar al servidor para obtener los planes actualizados
      userPlansResponse = await userPlanController.getUserPlans(
          userId: loginProvider.user!.id,
          status: status,
          startDate: startDate,
          endDate: endDate);

      //? Si el plan es (A) se asigna a la variable activeUserPlan, si es (I) se asigna a la variable inactiveUserPlan
      for (UserPlanModel userPlan in userPlansResponse.data!) {
        if (userPlan.status == 'A') {
          setActiveUserPlan(userPlan);
        } else if (userPlan.status == 'I') {
          setInactiveUserPlan(userPlan);
        }
      }
    } catch (e) {
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
}
