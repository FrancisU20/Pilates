import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/providers/client_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/images_paths.dart';
import 'package:pilates/theme/components/app_loading.dart';
import 'package:pilates/theme/widgets/custom_button.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
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
    return Scaffold(
      backgroundColor: AppColors.white100,
      body: Consumer<ClientProvider>(
        builder: (context, clientProvider, child) {
          if (clientProvider.isLoading) {
            return AppLoading.showLoading();
          } else {
            return SingleChildScrollView(
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
                        child: Form(
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
                              CustomTextField(
                                title: 'Usuario',
                                labelColor: AppColors.black100,
                                hintText: 'Ingrese su correo electrónico',
                                icon: FontAwesomeIcons.at,
                                typeTextField: TextFieldType.email,
                                controller: emailController,
                              ),
                              SizedBox(height: SizeConfig.scaleHeight(2)),
                              CustomTextField(
                                title: 'Contraseña',
                                labelColor: AppColors.black100,
                                hintText: 'Ingrese su contraseña',
                                icon: Icons.password_outlined,
                                typeTextField: TextFieldType.password,
                                controller: passwordController,
                              ),
                              SizedBox(height: SizeConfig.scaleHeight(2)),
                              SizedBox(
                                child: Center(
                                  child: CustomButton(
                                    text: 'Iniciar Sesión',
                                    color: AppColors.grey300,
                                    onPressed: () async {
                                      await clientProvider.signIn(
                                        context,
                                        emailController.text,
                                        passwordController.text,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: SizeConfig.scaleHeight(1)),
                              Center(
                                child: CustomButton(
                                  text: '¿Aún no tiene cuenta? Registrate',
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/onboarding');
                                  },
                                  color: AppColors.grey300,
                                  buttonStyle: ButtonStyleType.outlinedText,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
