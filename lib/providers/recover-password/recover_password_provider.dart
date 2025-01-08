import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pilates/common/logger.dart';
import 'package:pilates/controllers/recover-password/recover_password_controller.dart';
import 'package:pilates/controllers/user/user_controller.dart';
import 'package:pilates/models/common/standard_response.dart';
import 'package:pilates/models/recover-password/recover_password_create_model.dart';
import 'package:pilates/models/recover-password/recover_password_model.dart';
import 'package:pilates/models/user/user_model.dart';
import 'package:pilates/models/user/user_password_put_model.dart';
import 'package:pilates/theme/widgets/custom_snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecoverPasswordProvider extends ChangeNotifier {
  //****************************************/
  //? Controllers
  final UserController userController = UserController();
  final RecoverPasswordController recoverPasswordController =
      RecoverPasswordController();

  //? Packages

  //****************************************/
  //? Variables
  String email = '';
  String code = '';
  String password = '';
  String repeatPassword = '';

  //? Setters Variables
  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setCode(String code) {
    this.code = code;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  void setRepeatPassword(String repeatPassword) {
    this.repeatPassword = repeatPassword;
    notifyListeners();
  }

  //? Clean Variables
  void cleanEmail() {
    email = '';
    notifyListeners();
  }

  void cleanCode() {
    code = '';
    notifyListeners();
  }

  void cleanPassword() {
    password = '';
    notifyListeners();
  }

  void cleanRepeatPassword() {
    repeatPassword = '';
    notifyListeners();
  }

  //****************************************/
  //? Objetos
  RecoverPasswordModel? recoverPasswordModel;

  //? Setters Objetos
  void setRecoverPasswordModel(RecoverPasswordModel recoverPasswordModel) {
    this.recoverPasswordModel = recoverPasswordModel;
    notifyListeners();
  }

  //? Clean Objetos
  void cleanRecoverPasswordModel() {
    recoverPasswordModel = null;
    notifyListeners();
  }

  //****************************************/
  //? Listas

  //? Setters Listas

  //****************************************/
  //? Reutilizables
  bool isLoading = false;
  bool isStep1Completed = false;
  bool isStep2Completed = false;
  bool isStep3Completed = false;

  //? Setters Reutilizables
  void showLoading() {
    isLoading = true;
    notifyListeners();
  }

  void hideLoading() {
    isLoading = false;
    notifyListeners();
  }

  void setStep1Completed(bool isStep1Completed) {
    this.isStep1Completed = isStep1Completed;
    notifyListeners();
  }

  void setStep2Completed(bool isStep2Completed) {
    this.isStep2Completed = isStep2Completed;
    notifyListeners();
  }

  void setStep3Completed(bool isStep3Completed) {
    this.isStep3Completed = isStep3Completed;
    notifyListeners();
  }

  //? Clean reutilizables
  void cleanSteps() {
    isStep1Completed = false;
    isStep2Completed = false;
    isStep3Completed = false;
    notifyListeners();
  }

  //? Eliminar toda la data
  void cleanData() {
    cleanRecoverPasswordModel();
    cleanSteps();
    cleanEmail();
    cleanCode();
    cleanPassword();
    cleanRepeatPassword();
  }

  //****************************************/
  //**************VALIDADORES***************/
  //****************************************/
  //? Validar Primer Paso
  Future<bool> validatePassword(String password, String repeatPassword) async {
    try {
      if (password.isEmpty) {
        throw Exception('La contraseña es requerida');
      }
      if (password.length < 6) {
        throw Exception('La contraseña debe tener al menos 6 caracteres');
      }
      if (password == email) {
        throw Exception('La contraseña no puede ser igual a su correo');
      }
      // Debe tener Una mayuscula, numero y caracter especial
      if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,15}$')
          .hasMatch(password)) {
        throw Exception(
            'La contraseña debe tener al menos una mayúscula, un número y un caracter especial');
      }
      if (repeatPassword.isEmpty) {
        throw Exception('La confirmación de la contraseña es requerida');
      }
      if (password != repeatPassword) {
        throw Exception('Las contraseñas no coinciden');
      }
      return true;
    } catch (e) {
      Logger.logAppError('Error al validar la contraseña:$e');
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<void> validateStep1() async {
    try {
      //? Validar email
      if (email.isEmpty) {
        throw Exception('El email es requerido');
      }
    } catch (e) {
      Logger.logAppError('Error al validar el primer paso:$e');
      throw Exception(e.toString());
    }
  }

  Future<void> validateStep2(String inputCode) async {
    try {
      if (code.isEmpty) {
        throw Exception('El código es requerido');
      }
      String responseCode = recoverPasswordModel!.code;

      if (inputCode != responseCode) {
        throw Exception('El ingresado no coincide con el enviado');
      }
    } catch (e) {
      Logger.logAppError('Error al validar el segundo paso:$e');
      throw Exception(e.toString());
    }
  }

  Future<void> validateStep3() async {
    try {
      await validatePassword(password, repeatPassword);
    } catch (e) {
      Logger.logAppError('Error al validar el tercer paso:$e');
      throw Exception(e.toString());
    }
  }

  //****************************************/
  //***************FUNCIONES****************/
  //****************************************/
  //? Crear Codigo
  Future<void> createCode(BuildContext context) async {
    try {
      showLoading();

      await validateStep1();

      RecoverPasswordCreateModel recoverPasswordCreateModel =
          RecoverPasswordCreateModel(email: email);

      StandardResponse<RecoverPasswordModel> createCodeResponse =
          await recoverPasswordController
              .createCode(recoverPasswordCreateModel);

      setRecoverPasswordModel(createCodeResponse.data!);
      setStep1Completed(true);
      if (!context.mounted) return;
      CustomSnackBar.show(
        context,
        createCodeResponse.message,
        SnackBarType.success,
      );
    } catch (e) {
      setStep1Completed(false);
      Logger.logAppError('Error al crear el código:$e');
      CustomSnackBar.show(
        context,
        e.toString(),
        SnackBarType.error,
      );
    } finally {
      hideLoading();
    }
  }

  //? Validar Codigo
  Future<void> validateCode(BuildContext context, String inputCode) async {
    try {
      showLoading();
      await validateStep2(inputCode);

      if (!context.mounted) return;
      setStep2Completed(true);
      CustomSnackBar.show(
        context,
        'Código validado con éxito!',
        SnackBarType.success,
      );
    } catch (e) {
      setStep2Completed(false);
      Logger.logAppError('Error al validar el código:$e');
      CustomSnackBar.show(
        context,
        e.toString(),
        SnackBarType.error,
      );
    } finally {
      hideLoading();
    }
  }

  //? Actualizar Contraseña
  Future<void> updatePassword(BuildContext context) async {
    try {
      showLoading();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (!context.mounted) return;
      await validateStep3();

      UserPasswordPutModel userPasswordPutModel =
          UserPasswordPutModel(password: password, email: email);

      StandardResponse<UserModel> updatePasswordResponse =
          await recoverPasswordController.updatePassword(userPasswordPutModel);

      if (!context.mounted) return;
      setStep3Completed(true);
      //! Eliminar todos los datos de memoria 
      prefs.remove('email');
      prefs.remove('password');

      cleanData();
      Logger.logCustomMessage('Atencion:', 'Se ha eliminado todos los datos de memoria');

      context.go('/login');
      CustomSnackBar.show(
        context,
        updatePasswordResponse.message,
        SnackBarType.success,
      );
    } catch (e) {
      setStep3Completed(false);
      Logger.logAppError('Error al actualizar la contraseña:$e');
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
