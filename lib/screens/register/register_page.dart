import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pilates/providers/register_provider.dart';
import 'package:pilates/screens/dashboard/dashboard_page.dart';
import 'package:pilates/screens/register/widgets/final_step.dart';
import 'package:pilates/screens/register/widgets/gender_step.dart';
import 'package:pilates/screens/register/widgets/personal_information_step.dart';
import 'package:pilates/screens/register/widgets/profile_picture_step.dart';
import 'package:pilates/theme/colors_palette.dart';
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
  String _gender = '';
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Texts texts = Texts();
  Buttons buttons = Buttons();
  TextFormFields textFormFields = TextFormFields();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? selected = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
    });
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsPalette.backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: ColorsPalette.backgroundColor,
          ),
          width: double.infinity,
          height: double.infinity,
          child: Stepper(
            currentStep: _currentStep,
            onStepContinue: () {
              if (_currentStep < 3) {
                setState(() {
                  _currentStep += 1;
                });
              } else {
                if (_formKey.currentState!.validate()) {
                  log('Formulario completado');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DashboardPage()),
                      (route) => false);
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
            connectorColor: WidgetStateProperty.all(ColorsPalette.primaryColor),
            controlsBuilder: (context, details) => Row(
              children: [
                if (_currentStep < 1)
                  buttons.standart(
                      text: 'Siguiente',
                      onPressed: details.onStepContinue!,
                      color: ColorsPalette.primaryColor,
                      width: 10 * SizeConfig.widthMultiplier,
                      height: 0.6 * SizeConfig.heightMultiplier),
                if (_currentStep > 0 && _currentStep < 3) ...[
                  buttons.undelineText(
                    text: 'Anterior',
                    onPressed: details.onStepCancel!,
                    color: ColorsPalette.primaryColor,
                  ),
                  buttons.standart(
                      text: 'Siguiente',
                      onPressed: details.onStepContinue!,
                      color: ColorsPalette.primaryColor,
                      width: 10 * SizeConfig.widthMultiplier,
                      height: 0.6 * SizeConfig.heightMultiplier),
                ],
                if (_currentStep == 3) ...[
                  SizedBox(width: 2 * SizeConfig.widthMultiplier),
                  buttons.undelineText(
                    text: 'Anterior',
                    onPressed: details.onStepCancel!,
                    color: ColorsPalette.primaryColor,
                  ),
                  buttons.standart(
                      text: 'Finalizar',
                      onPressed: details.onStepContinue!,
                      color: ColorsPalette.primaryColor,
                      width: 10 * SizeConfig.widthMultiplier,
                      height: 0.6 * SizeConfig.heightMultiplier),
                ],
              ],
            ),
            steps: [
              Step(
                title: texts.titleText(
                    text: _currentStep == 0 ? 'Registro' : 'Completado',
                    fontWeight: FontWeight.w500),
                content: PersonalInformationStep(
                  formKey: _formKey,
                  textFormFields: textFormFields,
                  texts: texts,
                ),
                isActive: _currentStep >= 0,
                state:
                    _currentStep >= 1 ? StepState.complete : StepState.indexed,
              ),
              Step(
                title: texts.titleText(
                    text:
                        _currentStep == 1 ? 'Cuál es tu género?' : 'Completado',
                    fontWeight: FontWeight.w500),
                content: GenderStep(
                  gender: _gender,
                  texts: texts,
                  onGenderChanged: (newGender) {
                    setState(() {
                      _gender = newGender;
                    });
                  },
                ),
                isActive: _currentStep >= 1,
                state:
                    _currentStep >= 2 ? StepState.complete : StepState.indexed,
              ),
              Step(
                title: texts.titleText(
                    text: _currentStep == 2
                        ? 'Sube una foto de perfil'
                        : 'Completado',
                    fontWeight: FontWeight.w500),
                content: ProfilePictureStep(
                  imageFile: _imageFile,
                  onShowPicker: () => _showPicker(context),
                  buttons: buttons,
                ),
                isActive: _currentStep == 2,
                state:
                    _currentStep >= 3 ? StepState.complete : StepState.indexed,
              ),
              Step(
                title: texts.titleText(
                    text: 'Registro Exitoso', fontWeight: FontWeight.w500),
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
