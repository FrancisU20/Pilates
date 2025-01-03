import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pilates/common/logger.dart';
import 'package:pilates/controllers/file-asset/file_asset_controller.dart';
import 'package:pilates/controllers/user-plan/user_plan_controller.dart';
import 'package:pilates/models/common/standard_response.dart';
import 'package:pilates/models/file-asset/file_asset_model.dart';
import 'package:pilates/models/plan/plan_model.dart';
import 'package:pilates/models/user-plan/user_plan_create_model.dart';
import 'package:pilates/models/user-plan/user_plan_model.dart';
import 'package:pilates/providers/login/login_provider.dart';
import 'package:pilates/theme/widgets/custom_snack_bar.dart';
import 'package:provider/provider.dart';

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

  //****************************************/
  //? Objetos
  PlanModel? selectedPlan;

  //? Setters Objetos
  void setSelectedPlan(PlanModel plan) {
    selectedPlan = plan;
    notifyListeners();
  }

  //****************************************/
  //? Listas

  //? Setters Listas

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
      final targetPath = file.path.replaceAll('.jpg', '_compressed.jpg');

      var result = await FlutterImageCompress.compressAndGetFile(
        file.path,
        targetPath,
        quality: 60,
        minHeight: 1280,
        minWidth: 720,
      );

      return XFile(result!.path);
    } catch (e) {
      Logger.logAppError('Error al comprimir la imagen:$e');
      throw Exception('Error al comprimir la imagen');
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
      throw Exception('Error al convertir la imagen a archivo');
    }
  }

  //? Capturar Imagen
  Future<void> pickImage(BuildContext context, ImageSource source, String dni) async {
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

      if (!context.mounted) return;
      CustomSnackBar.show(
        context,
        fileAssetResponse.message,
        SnackBarType.success,
      );
    } catch (e) {
      CustomSnackBar.show(
        context,
        e.toString(),
        SnackBarType.error,
      );
    } finally {
      hideLoading();
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
      showLoading();
      // Leer el provider del Login para obtener la data del usuario
      LoginProvider loginProvider =
          Provider.of<LoginProvider>(context, listen: false);
      UserPlanCreateModel newUserPlan =
          UserPlanCreateModel(userId: loginProvider.user!.id!, planId: '');

      StandardResponse<UserPlanModel> createUserPlanResponse =
          await userPlanController.createUserPlan(newUserPlan);

      if (!context.mounted) return;

      CustomSnackBar.show(
        context,
        createUserPlanResponse.message,
        SnackBarType.success,
      );
    } catch (e) {
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
