import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pilates/common/logger.dart';
import 'package:pilates/controllers/file-asset/file_asset_controller.dart';
import 'package:pilates/controllers/user/user_controller.dart';
import 'package:pilates/models/common/standard_response.dart';
import 'package:pilates/models/file-asset/file_asset_model.dart';
import 'package:pilates/models/user/user_model.dart';
import 'package:pilates/theme/widgets/custom_snack_bar.dart';

class RegisterProvider extends ChangeNotifier {
  //****************************************/
  //? Controllers
  final FileAssetController fileAssetController = FileAssetController();
  final UserController userController = UserController();

  //? Packages
  final ImagePicker imagePicker = ImagePicker();

  //****************************************/
  //? Variables
  String email = '';
  String dni = '';
  String name = '';
  String lastname = '';
  String password = '';
  String repeatPassword = '';
  DateTime? birthday;
  String phone = '';
  String gender = '';
  String profilePhotoUrl = '';

  //? Setters Variables
  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setDni(String dni) {
    this.dni = dni;
    notifyListeners();
  }

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setLastname(String lastname) {
    this.lastname = lastname;
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

  void setBirthday(DateTime birthday) {
    this.birthday = birthday;
    notifyListeners();
  }

  void setPhone(String phone) {
    this.phone = phone;
    notifyListeners();
  }

  void setGender(String gender) {
    this.gender = gender;
    notifyListeners();
  }

  void setProfilePhotoUrl(String profilePhotoUrl) {
    this.profilePhotoUrl = profilePhotoUrl;
    notifyListeners();
  }

  //****************************************/
  //? Objetos

  //? Setters Objetos

  //****************************************/
  //? Listas

  //? Setters Listas

  //****************************************/
  //? Reutilizables
  bool isLoading = false;
  int currentStep = 0;
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

  void nextStep() {
    currentStep++;
    notifyListeners();
  }

  void previousStep() {
    currentStep--;
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

  //? Eliminar toda la data
  void clearData() {
    email = '';
    dni = '';
    name = '';
    lastname = '';
    password = '';
    repeatPassword = '';
    birthday = DateTime.now();
    phone = '';
    gender = '';
    profilePhotoUrl = '';
    currentStep = 0;
    isStep1Completed = false;
    isStep2Completed = false;
    isStep3Completed = false;
    notifyListeners();
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
      if (password == dni) {
        throw Exception('La contraseña no puede ser igual a su identificación');
      }
      if (password == email) {
        throw Exception('La contraseña no puede ser igual a su correo');
      }
      if (password == phone) {
        throw Exception('La contraseña no puede ser igual a su teléfono');
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

  Future<void> validateStep1(BuildContext context) async {
    try {
      //? Validar email
      if (email.isEmpty) {
        throw Exception('El email es requerido');
      }
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        throw Exception('El email no es válido');
      }
      //? Validar DNI
      if (dni.isEmpty) {
        throw Exception('El DNI es requerido');
      }
      if (dni.length != 10) {
        throw Exception('El DNI debe tener 10 caracteres');
      }

      //? Validar Nombre y Apellido
      if (name.isEmpty) {
        throw Exception('El nombre es requerido');
      }
      if (lastname.isEmpty) {
        throw Exception('El apellido es requerido');
      }

      //? Validar Contraseña
      await validatePassword(password, repeatPassword);

      //? Validar Fecha de Nacimiento
      if (birthday == null) {
        throw Exception('La fecha de nacimiento es requerida');
      }
      if (birthday!.isAfter(DateTime.now())) {
        throw Exception(
            'La fecha de nacimiento no puede ser mayor a la fecha actual');
      }

      //? Validar Teléfono
      if (phone.isEmpty) {
        throw Exception('El teléfono es requerido ');
      }
      if (phone.length != 10) {
        throw Exception('El teléfono debe tener 10 caracteres');
      }
      setStep1Completed(true);
    } catch (e) {
      Logger.logAppError('Error al validar el primer paso:$e');
      throw Exception(e.toString());
    }
  }

  Future<void> validateStep2(BuildContext context) async {
    try {
      if (gender.isEmpty) {
        throw Exception('El género es requerido');
      }
      setStep2Completed(true);
    } catch (e) {
      Logger.logAppError('Error al validar el segundo paso:$e');
      throw Exception(e.toString());
    }
  }

  Future<void> validateStep3(BuildContext context) async {
    try {
      if (profilePhotoUrl.isEmpty) {
        throw Exception('La foto de perfil es requerida');
      }
      setStep3Completed(true);
    } catch (e) {
      Logger.logAppError('Error al validar el tercer paso:$e');
      throw Exception(e.toString());
    }
  }

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
  Future<void> pickImage(BuildContext context, ImageSource source) async {
    try {
      showLoading();
      final XFile? imageSelected = await imagePicker.pickImage(source: source);
      if (imageSelected == null) {
        return;
      }
      XFile compressedImage = await compressImage(imageSelected);
      MultipartFile multipartFile = await convertToFile(compressedImage);

      StandardResponse<FileAssetModel> fileAssetResponse = await fileAssetController.postS3File(
          multipartFile, 'clients-photos', dni);

      setProfilePhotoUrl(fileAssetResponse.data!.path);

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

  //? Crear Usuario
  Future<void> register(BuildContext context) async {
    try {
      showLoading();

      UserModel newUser = UserModel(
        dniNumber: dni,
        name: name,
        lastname: lastname,
        password: password,
        birthdate: birthday!,
        phone: phone,
        gender: gender,
        photo: profilePhotoUrl,
        email: email,
        role: 'client',
      );

      StandardResponse<UserModel> registerResponse = await userController.register(newUser);

      if (!context.mounted) return;

      nextStep();

      CustomSnackBar.show(
        context,
        registerResponse.message,
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
