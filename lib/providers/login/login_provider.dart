import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pilates/common/logger.dart';
import 'package:pilates/controllers/login/login_controller.dart';
import 'package:pilates/models/common/standard_response.dart';
import 'package:pilates/models/user/user_model.dart';
import 'package:pilates/providers/register/register_provider.dart';
import 'package:pilates/theme/widgets/custom_snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  //****************************************/
  //? Controllers
  final LoginController loginController = LoginController();

  //****************************************/
  //? Variables
  String email = '';
  String password = '';

  bool canCheckBiometric = false;

  //? Setters Variables
  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  void setCanCheckBiometric(bool canCheckBiometric) {
    this.canCheckBiometric = canCheckBiometric;
    notifyListeners();
  }

  //****************************************/
  //? Objetos
  UserModel? user;

  //? Setters Objetos
  void setUser(UserModel user) {
    this.user = user;
    notifyListeners();
  }

  //****************************************/
  //? Listas
  List<BiometricType> listBiometrics = [];

  //? Setters Listas
  void setListBiometrics(List<BiometricType> listBiometrics) {
    this.listBiometrics = listBiometrics;
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
  //****************************************/
  //***************FUNCIONES****************/
  //****************************************/
  //? SHARED PREFERENCES
  Future<void> getSharedPreferences(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';
    String password = prefs.getString('password') ?? '';

    setEmail(email);
    setPassword(password);
  }

  //? LOGIN
  Future<void> login(
      BuildContext context, String email, String password) async {
    RegisterProvider registerProvider = Provider.of<RegisterProvider>(
      context,
      listen: false,
    );
    registerProvider.clearData();
    try {
      showLoading();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      StandardResponse<UserModel> loginResponse = await loginController.login(email, password);

      UserModel loggingInUser = loginResponse.data!;

      setUser(loggingInUser);

      if (!context.mounted) return;

      prefs.setString('email', email);
      prefs.setString('password', password);

      Navigator.of(context).pushNamed('/dashboard');
      CustomSnackBar.show(
        context,
        loggingInUser.gender == 'F'
            ? 'Bienvenida nuevamente'
            : loggingInUser.gender == 'M'
                ? 'Bienvenido nuevamente'
                : 'Bienvenid@ nuevamente',
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

  //? Verificar si se puede realizar una autenticación biométrica.
  Future<void> canUseBiometrics(BuildContext context) async {
    try {
      final LocalAuthentication localAuth = LocalAuthentication();
      bool canCheckBiometrics = await localAuth.canCheckBiometrics;

      if (!context.mounted) return;
      setCanCheckBiometric(canCheckBiometrics);
    } catch (e) {
      setCanCheckBiometric(false);
    }
  }

  //? Lista de Biometricos
  Future<void> getAvailableBiometrics(BuildContext context) async {
    try {
      final LocalAuthentication localAuth = LocalAuthentication();
      List<BiometricType> availableBiometrics =
          await localAuth.getAvailableBiometrics();

      if (!context.mounted) return;

      setListBiometrics(availableBiometrics);
    } catch (e) {
      setListBiometrics([]);
    }
  }

  //? Login Biometrico
  Future<void> loginBiometric(BuildContext context) async {
    try {
      final LocalAuthentication localAuth = LocalAuthentication();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      bool biometricAuth = await localAuth.authenticate(
          localizedReason: 'Por favor, valide su biometría para continuar',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: false,
          ));

      String email = prefs.getString('email') ?? '';
      String password = prefs.getString('password') ?? '';

      if (!context.mounted) return;
      if (email.isEmpty || password.isEmpty) {
        CustomSnackBar.show(
          context,
          'No se encontraron credenciales almacenadas, por favor inicie sesión manualmente',
          SnackBarType.error,
        );
        return;
      }
      if (biometricAuth) {
        login(context, email, password);
      } else {
        CustomSnackBar.show(
          context,
          'Vuelve a intentarlo, no se pudo validar sus datos biometricos',
          SnackBarType.error,
        );
      }
    } on PlatformException catch (e) {
      Logger.logAppError(e.toString());
      CustomSnackBar.show(
        context,
        'Ha cancelado la autenticación biométrica',
        SnackBarType.error,
      );
    } catch (e) {
      CustomSnackBar.show(
        context,
        e.toString(),
        SnackBarType.error,
      );
    }
  }
}
