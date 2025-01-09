import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pilates/common/logger.dart';
import 'package:pilates/controllers/file-asset/file_asset_controller.dart';
import 'package:pilates/controllers/login/login_controller.dart';
import 'package:pilates/models/common/standard_response.dart';
import 'package:pilates/models/file-asset/file_asset_model.dart';
import 'package:pilates/models/user/user_model.dart';
import 'package:pilates/providers/class/class_provider.dart';
import 'package:pilates/providers/nutritional-info/nutritional_info_provider.dart';
import 'package:pilates/providers/plan/plan_provider.dart';
import 'package:pilates/providers/recover-password/recover_password_provider.dart';
import 'package:pilates/providers/register/register_provider.dart';
import 'package:pilates/providers/user-class/user_class_provider.dart';
import 'package:pilates/providers/user-plan/user_plan_provider.dart';
import 'package:pilates/theme/widgets/custom_snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

class LoginProvider extends ChangeNotifier {
  //****************************************/
  //? Controllers
  final LoginController loginController = LoginController();
  final FileAssetController fileAssetController = FileAssetController();

  //? Packages
  final ImagePicker imagePicker = ImagePicker();

  //****************************************/
  //? Variables
  String email = '';
  String password = '';

  bool canCheckBiometric = false;
  String profilePhotoUrl = '';

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

  void setProfilePhotoUrl(String profilePhotoUrl) {
    this.profilePhotoUrl = profilePhotoUrl;
    notifyListeners();
  }

  //? Clear Variables
  void clearEmail() {
    email = '';
    notifyListeners();
  }

  void clearPassword() {
    password = '';
    notifyListeners();
  }

  void clearCanCheckBiometric() {
    canCheckBiometric = false;
    notifyListeners();
  }

  void clearProfilePhotoUrl() {
    profilePhotoUrl = '';
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

  //? Clean Objetos
  void clearUser() {
    user = null;
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

  //? Clean Listas
  void clearListBiometrics() {
    listBiometrics = [];
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
    clearEmail();
    clearPassword();
    clearUser();
    clearListBiometrics();
    clearCanCheckBiometric();
    clearProfilePhotoUrl();
  }

  //! METODO UNICO DE ESTA CLASE LOGOUT
  void logout(BuildContext context) {
    ClassProvider classProvider =
        Provider.of<ClassProvider>(context, listen: false);
    NutritionalInfoProvider nutritionalInfoProvider =
        Provider.of<NutritionalInfoProvider>(context, listen: false);
    PlanProvider planProvider =
        Provider.of<PlanProvider>(context, listen: false);
    RecoverPasswordProvider recoverPasswordProvider =
        Provider.of<RecoverPasswordProvider>(context, listen: false);
    RegisterProvider registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);
    UserClassProvider userClassProvider =
        Provider.of<UserClassProvider>(context, listen: false);
    UserPlanProvider userPlanProvider =
        Provider.of<UserPlanProvider>(context, listen: false);

    //? Resetear estados
    classProvider.reset();
    nutritionalInfoProvider.reset();
    planProvider.reset();
    recoverPasswordProvider.reset();
    registerProvider.reset();
    userClassProvider.reset();
    userPlanProvider.reset();
    reset(); //! Provider de Login
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
    registerProvider.reset();
    try {
      showLoading();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      StandardResponse<UserModel> loginResponse =
          await loginController.login(email, password);

      UserModel loggingInUser = loginResponse.data!;

      setUser(loggingInUser);

      if (!context.mounted) return;

      prefs.setString('email', email);
      prefs.setString('password', password);

      context.go('/dashboard');
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

  //! FUnciones de actualización de imagen
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
          'Formato de imagen no soportado, seleccione otra imagen e intentalo nuevamente.');
    }
  }

  //? Capturar Imagen
  Future<void> pickImage(BuildContext context, ImageSource source) async {
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
              multipartFile, 'clients-photos', user!.dniNumber);

      setProfilePhotoUrl(fileAssetResponse.data!.path);

      UserModel userNewData = UserModel(
        dniNumber: user!.dniNumber,
        email: user!.email,
        name: user!.name,
        lastname: user!.lastname,
        phone: user!.phone,
        birthdate: user!.birthdate,
        gender: user!.gender,
        photo: fileAssetResponse.data!.path,
        role: 'client',
      );

      String userId = user!.id ?? '';

      StandardResponse<UserModel> userResponse =
          await loginController.updateUser(userId, userNewData);

      //? Actualiza la data del usuario (Imagen)
      setUser(userResponse.data!);

      if (!context.mounted) return;
      CustomSnackBar.show(
        context,
        userResponse.message,
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
