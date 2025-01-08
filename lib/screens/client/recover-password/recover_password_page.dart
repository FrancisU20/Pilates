import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/providers/recover-password/recover_password_provider.dart';
import 'package:pilates/theme/components/client/client_app_bar.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/components/common/app_loading.dart';
import 'package:pilates/theme/widgets/custom_button.dart';
import 'package:pilates/theme/widgets/custom_image_network.dart';
import 'package:pilates/theme/widgets/custom_page_header.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/widgets/custom_text_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({super.key});

  @override
  RecoverPasswordPageState createState() => RecoverPasswordPageState();
}

class RecoverPasswordPageState extends State<RecoverPasswordPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    //pinController.dispose(); //? La libreria ya hace el dispose de este item
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.white100,
          appBar: const ClientAppBar(backgroundColor: AppColors.brown200),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            child: Container(
              color: AppColors.brown200,
              child: Column(
                children: [
                  const CustomPageHeader(
                      icon: FontAwesomeIcons.addressBook,
                      title: 'Recuperar Contraseña',
                      subtitle: 'Llena el formulario'),
                  SizedBox(
                    height: SizeConfig.scaleHeight(2),
                  ),
                  Container(
                      width: SizeConfig.scaleWidth(100),
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.scaleWidth(5),
                          vertical: SizeConfig.scaleHeight(2)),
                      decoration: const BoxDecoration(
                          color: AppColors.white100,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: SizeConfig.scaleHeight(2),
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.scaleWidth(5),
                                vertical: SizeConfig.scaleHeight(2),
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.black100,
                                borderRadius: BorderRadius.circular(
                                    SizeConfig.scaleWidth(2)),
                                border: Border.all(
                                  color: AppColors.black100.withOpacity(0.1),
                                ),
                              ),
                              child: CustomImageNetwork(
                                imagePath:
                                    'https://curvepilates-bucket.s3.amazonaws.com/app-assets/logo/logo_rectangle_transparent_white.png',
                                height: SizeConfig.scaleHeight(4),
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.scaleHeight(2)),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.scaleWidth(10),
                              vertical: SizeConfig.scaleHeight(2),
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white200,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black100.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            height: SizeConfig.scaleHeight(38),
                            width: SizeConfig.scaleWidth(100),
                            child: Form(
                              child: Column(
                                children: [
                                  SizedBox(height: SizeConfig.scaleHeight(1)),
                                  Center(
                                    child: CustomText(
                                      text: 'Datos de Usuario',
                                      color: AppColors.black100,
                                      fontSize: SizeConfig.scaleText(2.5),
                                      fontWeight: FontWeight.w500,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Consumer<RecoverPasswordProvider>(builder:
                                      (context, recoverPasswordProvider,
                                          child) {
                                    if (recoverPasswordProvider
                                            .isStep1Completed ==
                                        false) {
                                      return Column(
                                        children: [
                                          CustomTextField(
                                            title: 'Correo Electrónico',
                                            labelColor: AppColors.black100,
                                            hintText: 'info@curve.com',
                                            typeTextField: TextFieldType.email,
                                            controller: emailController,
                                            fontSize: SizeConfig.scaleText(1.7),
                                            onChanged: (value) {
                                              recoverPasswordProvider
                                                  .setEmail(value);
                                            },
                                          ),
                                          SizedBox(
                                              height:
                                                  SizeConfig.scaleHeight(1)),
                                          Center(
                                            child: CustomButton(
                                              onPressed: () async {
                                                //? Enviar al server el correo para enviar el código
                                                await recoverPasswordProvider
                                                    .createCode(context);
                                              },
                                              text: 'Enviar Código',
                                            ),
                                          ),
                                        ],
                                      );
                                    } else if (recoverPasswordProvider
                                            .isStep1Completed &&
                                        recoverPasswordProvider
                                                .isStep2Completed ==
                                            false) {
                                      return Column(
                                        children: [
                                          Container(
                                            width: SizeConfig.scaleWidth(60),
                                            decoration: BoxDecoration(
                                              color: AppColors.white100,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding: EdgeInsets.all(
                                                SizeConfig.scaleHeight(1)),
                                            child: PinCodeTextField(
                                              appContext: context,
                                              length: 4,
                                              cursorColor: AppColors.black100,
                                              controller: pinController,
                                              backgroundColor:
                                                  AppColors.white100,
                                              onChanged: (value) {
                                                recoverPasswordProvider
                                                    .setCode(value);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                              height:
                                                  SizeConfig.scaleHeight(2)),
                                          CustomButton(
                                            onPressed: () async {
                                              //? Validar el código ingresado
                                              await recoverPasswordProvider
                                                  .validateCode(
                                                      context,
                                                      recoverPasswordProvider
                                                          .code);
                                            },
                                            text: 'Validar Código',
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomTextField(
                                            title: 'Contraseña',
                                            labelColor: AppColors.black100,
                                            hintText: '********',
                                            typeTextField:
                                                TextFieldType.password,
                                            controller: passwordController,
                                            fontSize: SizeConfig.scaleText(1.7),
                                            onChanged: (value) {
                                              recoverPasswordProvider
                                                  .setPassword(value);
                                            },
                                          ),
                                          CustomTextField(
                                            title: 'Confirmar Contraseña',
                                            labelColor: AppColors.black100,
                                            hintText: '********',
                                            typeTextField:
                                                TextFieldType.password,
                                            controller:
                                                confirmPasswordController,
                                            fontSize: SizeConfig.scaleText(1.7),
                                            onChanged: (value) {
                                              recoverPasswordProvider
                                                  .setRepeatPassword(value);
                                            },
                                          ),
                                          SizedBox(
                                              height:
                                                  SizeConfig.scaleHeight(1)),
                                          Center(
                                            child: CustomButton(
                                              onPressed: () async {
                                                //? Actualizar la contraseña
                                                await recoverPasswordProvider
                                                    .updatePassword(context);
                                              },
                                              text: 'Restablecer Contraseña',
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
        const AppLoading(),
      ],
    );
  }
}
