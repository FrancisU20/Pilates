import 'package:flutter/material.dart';
import 'package:pilates/controllers/login_controller.dart';
import 'package:pilates/models/user/user_model.dart';
import 'package:pilates/providers/register_provider.dart';
import 'package:pilates/theme/widgets/custom_snack_bar.dart';
import 'package:provider/provider.dart';

class ClientProvider extends ChangeNotifier {
  // * Variables en Memoria * //
  //? Objetos de la clase
  UserModel? user;

  //? Getters
  UserModel? get getUser => user;

  //? Setters
  void setUser(UserModel user) {
    this.user = user;
    notifyListeners();
  }

  //? Clean
  void clearUser() {
    user = null;
    notifyListeners();
  }

  //? Clean All
  void clearAll() {
    user = null;
    notifyListeners();
  }

  // * Funciones de la clase * //
  final LoginController loginController = LoginController();

  //? Variables
  bool isLoading = false;

  //? Métodos
  Future<void> signIn(
      BuildContext context, String email, String password) async {
    RegisterProvider registerProvider = Provider.of<RegisterProvider>(
      context,
      listen: false,
    );

    registerProvider.clearAll();

    try {
      isLoading = true;
      notifyListeners();

      UserModel user = await loginController.signIn(email, password);
      setUser(user);

      CustomSnackBar(
        message: '¡Bienvenido ${user.name}!',
        type: SnackBarType.success,
      );

      if (!context.mounted) return;
      Navigator.of(context).pushNamed('/home');
    } catch (e) {
      CustomSnackBar(
        message: e.toString(),
        type: SnackBarType.informative,
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
