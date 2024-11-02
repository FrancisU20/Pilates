import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pilates/controllers/file_manager_controller.dart';
import 'package:pilates/models/response/upload_profile_photo_response.dart';
import 'package:pilates/providers/register_provider.dart';
import 'package:pilates/screens/client/register/widgets/final_step.dart';
import 'package:pilates/screens/client/register/widgets/gender_step.dart';
import 'package:pilates/screens/client/register/widgets/personal_information_step.dart';
import 'package:pilates/screens/client/register/widgets/profile_picture_step.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/modals/loading_modal.dart';
import 'package:pilates/theme/widgets/buttons.dart';
import 'package:pilates/theme/widgets/textfields.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  bool _isFirstStepComplete = false;
  bool _isSecondStepComplete = false;
  bool _isThirdStepComplete = false;

  String _gender = '';
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  // Controladores de texto
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dniController = TextEditingController();

  // Controladores
  FileManagerController fileManagerController = FileManagerController();

  // Modals
  final LoadingModal loadingModal = LoadingModal();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Limpiar los controladores cuando se destruye el widget para evitar fugas de memoria
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    nameController.dispose();
    lastNameController.dispose();
    birthdayController.dispose();
    phoneController.dispose();
    dniController.dispose();
    super.dispose();
  }

  Texts texts = Texts();
  Buttons buttons = Buttons();
  TextFormFields textFormFields = TextFormFields();

  Future<void> _pickImage(ImageSource source) async {
    RegisterProvider registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);
    final XFile? selected = await _picker.pickImage(source: source);

    if (selected == null) {
      return;
    } else {
      try {
        Future.microtask(() {
          loadingModal.showLoadingModal(context);
        });
        UploadS3Response uploadProfilePhotoResponse =
            await fileManagerController.postS3ProfilePhoto(
                selected, registerProvider.dni!);
        log(uploadProfilePhotoResponse.fileUrl);
        registerProvider.setImageFile(selected);
        registerProvider.setImageUrl(uploadProfilePhotoResponse.fileUrl);

        Future.microtask(() {
          loadingModal.closeLoadingModal(context);
        });

        setState(() {
          _imageFile = selected;
        });
      } catch (e) {
        log(e.toString());
        setState(() {
          _imageFile = null;
        });
        registerProvider.clearImageFile();
        registerProvider.clearImageUrl();

        Future.microtask(() {
          loadingModal.closeLoadingModal(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Hubo un error al subir la imagen.'),
            ),
          );
        });
      }
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(FontAwesomeIcons.images),
                title: texts.normalText(
                    text: 'Galería',
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.start),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.cameraRetro),
                title: texts.normalText(
                    text: 'Cámara',
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.start),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  bool _validateFirstStep() {
    RegisterProvider registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);
    // Verificar si todos los campos del primer paso están llenos
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        repeatPasswordController.text.isEmpty ||
        nameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        birthdayController.text.isEmpty ||
        phoneController.text.isEmpty ||
        dniController.text.isEmpty) {
      return false;
    } else {
      DateTime normalizedDate = DateTime.parse(birthdayController.text);

      registerProvider.setEmail(emailController.text);
      registerProvider.setName(nameController.text);
      registerProvider.setLastname(lastNameController.text);
      registerProvider.setBirthday(normalizedDate);
      registerProvider.setPhone(phoneController.text);
      registerProvider.setDni(dniController.text);
      return true;
    }
  }

  bool validatePassword() {
    if (passwordController.text != repeatPasswordController.text) {
      return false;
    }
    RegisterProvider registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);
    registerProvider.setPassword(passwordController.text);
    return true;
  }

  void saveGender(String newGender) {
    RegisterProvider registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);
    registerProvider.setGender(newGender);
    log(newGender);
    setState(() {
      _gender = newGender;
      log(_gender);
    });
  }

  bool _validateSecondStep() {
    RegisterProvider registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);

    return registerProvider.gender != null;
  }

  bool _validateThirdStep() {
    RegisterProvider registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);

    return registerProvider.imageFile != null;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsPalette.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: ColorsPalette.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: ColorsPalette.white,
          ),
          width: double.infinity,
          height: double.infinity,
          child: Stepper(
            currentStep: _currentStep,
            onStepContinue: () {
              if (_currentStep == 0) {
                // Validar el primer paso
                if (!_validateFirstStep()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Por favor, llena todos los campos.')),
                  );
                  return;
                }
                if (!validatePassword()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Las contraseñas no coinciden.')),
                  );
                  return;
                }
                setState(() {
                  _isFirstStepComplete = true;
                });
              }

              if (_currentStep < 3) {
                if (_currentStep == 1 && !_validateSecondStep()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Por favor, seleccione un género.')),
                  );
                  return;
                }

                if (_currentStep == 2 && !_validateThirdStep()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Por favor, seleccione una imagen.')),
                  );
                  return;
                }

                setState(() {
                  _currentStep += 1;
                  if (_currentStep == 1) {
                    _isFirstStepComplete = true;
                  } else if (_currentStep == 2) {
                    _isFirstStepComplete = true;
                    _isSecondStepComplete = true;
                  } else if (_currentStep == 3) {
                    _isFirstStepComplete = true;
                    _isSecondStepComplete = true;
                    _isThirdStepComplete = true;
                  } else {
                    _isFirstStepComplete = false;
                    _isSecondStepComplete = false;
                    _isThirdStepComplete = false;
                  }
                });
              } else {
                if (_formKey.currentState!.validate()) {
                  log('Formulario completado');
                  Navigator.pushNamed(context, '/plans');
                }
              }
            },
            onStepCancel: () {
              if (_currentStep > 0) {
                setState(() {
                  _currentStep -= 1;
                });
              }
            },
            connectorColor: WidgetStateProperty.all(ColorsPalette.beigeAged),
            controlsBuilder: (context, details) => Row(
              children: [
                if (_currentStep < 1)
                  buttons.standart(
                      text: 'Siguiente',
                      onPressed: details.onStepContinue!,
                      color: ColorsPalette.beigeAged,
                      width: 10 * SizeConfig.widthMultiplier,
                      height: 0.6 * SizeConfig.heightMultiplier),
                if (_currentStep > 0 && _currentStep < 3) ...[
                  buttons.undelineText(
                    text: 'Anterior',
                    onPressed: details.onStepCancel!,
                    color: ColorsPalette.beigeAged,
                  ),
                  buttons.standart(
                      text: 'Siguiente',
                      onPressed: details.onStepContinue!,
                      color: ColorsPalette.beigeAged,
                      width: 10 * SizeConfig.widthMultiplier,
                      height: 0.6 * SizeConfig.heightMultiplier),
                ],
                if (_currentStep == 3) ...[
                  SizedBox(width: 2 * SizeConfig.widthMultiplier),
                  buttons.undelineText(
                    text: 'Anterior',
                    onPressed: details.onStepCancel!,
                    color: ColorsPalette.beigeAged,
                  ),
                  buttons.standart(
                      text: 'Ver Planes',
                      onPressed: details.onStepContinue!,
                      color: ColorsPalette.beigeAged,
                      width: 10 * SizeConfig.widthMultiplier,
                      height: 0.6 * SizeConfig.heightMultiplier),
                ],
              ],
            ),
            steps: [
              Step(
                title: texts.titleText(
                    text: !_isFirstStepComplete ? 'Registro' : 'Completado',
                    fontWeight: FontWeight.w500),
                content: PersonalInformationStep(
                  formKey: _formKey,
                  textFormFields: textFormFields,
                  texts: texts,
                  emailController: emailController,
                  passwordController: passwordController,
                  repeatPasswordController: repeatPasswordController,
                  nameController: nameController,
                  lastNameController: lastNameController,
                  birthdayController: birthdayController,
                  phoneController: phoneController,
                  dniController: dniController,
                ),
                isActive: _currentStep >= 0,
                state: _isFirstStepComplete
                    ? StepState.complete
                    : StepState.indexed,
              ),
              Step(
                title: texts.titleText(
                    text: !_isSecondStepComplete
                        ? 'Cuál es tu género?'
                        : 'Completado',
                    fontWeight: FontWeight.w500),
                content: GenderStep(
                  gender: _gender,
                  texts: texts,
                  onGenderChanged: (newGender) {
                    saveGender(newGender);
                  },
                ),
                isActive: _currentStep >= 1,
                state: _isSecondStepComplete
                    ? StepState.complete
                    : StepState.indexed,
              ),
              Step(
                title: texts.titleText(
                    text: !_isThirdStepComplete
                        ? 'Sube una foto de perfil'
                        : 'Completado',
                    fontWeight: FontWeight.w500),
                content: ProfilePictureStep(
                  imageFile: _imageFile,
                  onShowPicker: () => _showPicker(context),
                  buttons: buttons,
                ),
                isActive: _currentStep == 2,
                state: _isThirdStepComplete
                    ? StepState.complete
                    : StepState.indexed,
              ),
              Step(
                title: texts.titleText(
                    text: _currentStep == 3 ? 'Registro Exitoso' : 'Registro en Proceso' , fontWeight: FontWeight.w500),
                content: FinalStep(texts: texts),
                state: StepState.complete,
                isActive: _currentStep == 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
