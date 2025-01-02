import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/providers/login_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/images_paths.dart';
import 'package:pilates/theme/components/app_loading.dart';
import 'package:pilates/theme/widgets/custom_button.dart';
import 'package:pilates/theme/widgets/custom_icon_button.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/theme/widgets/custom_text_button.dart';
import 'package:pilates/theme/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LoginProvider clientProvider =
        Provider.of<LoginProvider>(context, listen: false);
    clientProvider.canUseBiometrics(context);
    clientProvider.getAvailableBiometrics(context);
    clientProvider.getSharedPreferences(context);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.white100,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagesPaths.backgroundLogin),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      AppColors.black100.withOpacity(0.8), BlendMode.dstATop),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white100,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black100.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      width: SizeConfig.scaleWidth(90),
                      padding: const EdgeInsets.all(25),
                      child: Consumer<LoginProvider>(
                        builder: (context, clientProvider, child) {
                          return Form(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: SizeConfig.scaleWidth(100),
                                  height: SizeConfig.scaleHeight(15),
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/logo/logo_rectangle.png'),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                CustomText(
                                  text: 'Bienvenido,',
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.start,
                                  fontSize: SizeConfig.scaleHeight(3),
                                ),
                                SizedBox(height: SizeConfig.scaleHeight(1)),
                                CustomText(
                                  text: 'Es un gusto volver a verte',
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.start,
                                  fontSize: SizeConfig.scaleHeight(2),
                                ),
                                SizedBox(height: SizeConfig.scaleHeight(2)),
                                Consumer<LoginProvider>(
                                  builder: (context, clientProvider, child) {
                                    if (clientProvider.canCheckBiometric &&
                                        clientProvider
                                            .listBiometrics.isNotEmpty &&
                                        clientProvider.email.isNotEmpty &&
                                        clientProvider.password.isNotEmpty) {
                                      return Column(
                                        children: [
                                          CustomIconButton(
                                            onPressed: () {
                                              clientProvider
                                                  .loginBiometric(context);
                                            },
                                            icon: clientProvider.listBiometrics
                                                    .contains(
                                                        BiometricType.face)
                                                ? Icons.face
                                                : FontAwesomeIcons.fingerprint,
                                            iconSize: 5,
                                            text: clientProvider.listBiometrics
                                                    .contains(
                                                        BiometricType.face)
                                                ? 'Face ID'
                                                : 'Touch ID \n Huella',
                                            color: AppColors.brown200,
                                          ),
                                          SizedBox(
                                              height:
                                                  SizeConfig.scaleHeight(1)),
                                          Center(
                                            child: CustomTextButton(
                                              text:
                                                  'Iniciar sesión con correo y contraseña',
                                              onPressed: () {
                                                clientProvider
                                                    .setCanCheckBiometric(
                                                        false);
                                                clientProvider
                                                    .setListBiometrics([]);
                                              },
                                              color: AppColors.grey300,
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Column(
                                        children: [
                                          CustomTextField(
                                            title: 'Correo Electrónico',
                                            labelColor: AppColors.black100,
                                            hintText:
                                                'Ingrese su correo electrónico',
                                            icon: FontAwesomeIcons.at,
                                            typeTextField: TextFieldType.email,
                                            controller: emailController,
                                          ),
                                          SizedBox(
                                              height:
                                                  SizeConfig.scaleHeight(2)),
                                          CustomTextField(
                                            title: 'Contraseña',
                                            labelColor: AppColors.black100,
                                            hintText: 'Ingrese su contraseña',
                                            icon: Icons.password_outlined,
                                            typeTextField:
                                                TextFieldType.password,
                                            controller: passwordController,
                                          ),
                                          SizedBox(
                                              height:
                                                  SizeConfig.scaleHeight(2)),
                                          SizedBox(
                                            child: Center(
                                              child: CustomButton(
                                                text: 'Iniciar Sesión',
                                                color: AppColors.brown200,
                                                onPressed: () {
                                                  clientProvider.login(
                                                    context,
                                                    emailController.text,
                                                    passwordController.text,
                                                  );
                                                },
                                                isActive:
                                                    clientProvider.isLoading
                                                        ? false
                                                        : true,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            child: Center(
                                              child: CustomTextButton(
                                                text:
                                                    '¿Olvidaste tu contraseña?',
                                                onPressed: () {
                                                  Navigator.pushNamed(context,
                                                      '/forgot_password');
                                                },
                                                color: AppColors.brown200,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height:
                                                  SizeConfig.scaleHeight(2)),
                                          Center(
                                            child: CustomTextButton(
                                              text:
                                                  '¿Aún no tienes cuenta? Registrate',
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/onboarding');
                                              },
                                              color: AppColors.grey300,
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Consumer<LoginProvider>(
          builder: (context, clientProvider, child) {
            if (clientProvider.isLoading) {
              return const AppLoading();
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
