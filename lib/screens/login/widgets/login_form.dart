import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/controllers/clients_controller.dart';
import 'package:pilates/models/response/login_response.dart';
import 'package:pilates/providers/client_class_provider.dart';
import 'package:pilates/providers/register_provider.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/modals/loading_modal.dart';
import 'package:pilates/theme/snackbars/error_snackbar.dart';
import 'package:pilates/theme/widgets/buttons.dart';
import 'package:pilates/theme/widgets/textfields.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextFormFields textFormFields;
  final Texts texts;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.textFormFields,
    required this.texts,
  });

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final Buttons buttons = Buttons();
  final ErrorSnackBar errorSnackBar = ErrorSnackBar();
  final LoadingModal loadingModal = LoadingModal();
  final LoginController loginController = LoginController();

  // Controladores de texto
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _loginProcess(
      String email, String password, BuildContext context) async {
    ClientClassProvider clientClassProvider = Provider.of<ClientClassProvider>(
      context,
      listen: false,
    );
    RegisterProvider registerProvider = Provider.of<RegisterProvider>(
      context,
      listen: false,
    );
    try {
      loadingModal.showLoadingModal(context);
      LoginResponse loginResponse =
          await loginController.loginProcess(email, password);
      bool isRegistered = loginResponse.token.isNotEmpty;
      if (isRegistered) {
        clientClassProvider.setLoginResponse(loginResponse);
        registerProvider.clearAll();
        Future.microtask(
          () => Navigator.pushNamedAndRemoveUntil(
              context, '/dashboard', (route) => false),
        );
      }
    } catch (e) {
      Future.microtask(() => {
            loadingModal.closeLoadingModal(context),
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: widget.texts.normalText(
                    text: e.toString().replaceAll('Exception: ', ''),
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.start,
                    fontSize: 16,
                    color: Colors.white),
                backgroundColor: const Color.fromARGB(255, 207, 117, 117),
              ),
            ),
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsPalette.backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      width: 90 * SizeConfig.widthMultiplier,
      padding: const EdgeInsets.all(25),
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100 * SizeConfig.widthMultiplier,
              height: 20 * SizeConfig.heightMultiplier,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo/logo_rectangle.jpg'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            widget.texts.titleText(
              text: 'Bienvenido,',
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.start,
              fontSize: 32,
            ),
            SizedBox(height: 2 * SizeConfig.heightMultiplier),
            widget.texts.normalText(
              text: 'Es un gusto volver a verte.',
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.start,
              fontSize: 16,
            ),
            SizedBox(height: 2 * SizeConfig.heightMultiplier),
            widget.textFormFields.create(
              title: 'Usuario',
              labelcolor: ColorsPalette.textColor,
              hintText: 'Ingrese su correo electrónico',
              icon: FontAwesomeIcons.user,
              typeTextField: TextFieldType.email,
              controller: emailController,
            ),
            SizedBox(height: 2 * SizeConfig.heightMultiplier),
            widget.textFormFields.create(
              title: 'Contraseña',
              labelcolor: ColorsPalette.textColor,
              hintText: 'Ingrese su contraseña',
              icon: Icons.password_outlined,
              typeTextField: TextFieldType.password,
              controller: passwordController,
            ),
            SizedBox(height: 4 * SizeConfig.heightMultiplier),
            SizedBox(
              child: Center(
                child: buttons.standart(
                  text: 'Iniciar Sesión',
                  color: ColorsPalette.primaryColor,
                  onPressed: () async {
                    _loginProcess(
                        emailController.text, passwordController.text, context);
                  },
                ),
              ),
            ),
            SizedBox(height: 2 * SizeConfig.heightMultiplier),
            Center(
              child: widget.texts.underlineText(
                  text: '¿Aún no tiene cuenta? Registrate',
                  onPressed: () {
                    Navigator.pushNamed(context, '/onboarding');
                  },
                  color: ColorsPalette.primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
