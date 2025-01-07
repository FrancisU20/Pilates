import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pilates/models/plan/plan_model.dart';
import 'package:pilates/models/class/class_model.dart';
import 'package:pilates/providers/login/login_provider.dart';
import 'package:pilates/providers/register/register_provider.dart';
import 'package:pilates/providers/user-class/user_class_provider.dart';
import 'package:pilates/providers/user-plan/user_plan_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_button.dart';
import 'package:pilates/theme/widgets/custom_snack_bar.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/widgets/custom_text_button.dart';
import 'package:pilates/theme/widgets/custom_text_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class AppDialogs {
  /// Widget reutilizable para mostrar el logotipo
  static Widget _buildLogo() {
    return Container(
      width: SizeConfig.scaleWidth(90),
      height: SizeConfig.scaleHeight(15),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/logo/logo_rectangle.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  /// Diálogo "Próximamente"
  static Future<void> showComingSoon({
    required BuildContext context,
    VoidCallback? onButtonPressed, // Acción opcional al presionar el botón
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white100,
          title: CustomText(
            text: 'Próximamente ...',
            color: AppColors.black100,
            fontSize: SizeConfig.scaleText(2.5),
            fontWeight: FontWeight.w500,
          ),
          content: SizedBox(
            width: SizeConfig.scaleWidth(100),
            height: SizeConfig.scaleHeight(27.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLogo(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text:
                          'El módulo estará disponible en la próxima actualización',
                      color: AppColors.black100,
                      fontSize: SizeConfig.scaleText(2),
                      fontWeight: FontWeight.w400,
                      maxLines: 3,
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(2),
                    ),
                    Center(
                      child: CustomButton(
                        text: 'Regresar',
                        color: AppColors.brown200,
                        width: SizeConfig.scaleWidth(15),
                        onPressed: onButtonPressed ??
                            () {
                              Navigator.pop(context);
                            },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Diálogo para seleccionar método de pago
  static Future<void> showPaymentMethod({
    required BuildContext context,
    required PlanModel selectedPlan,
  }) async {
    final UserPlanProvider userPlanProvider =
        Provider.of<UserPlanProvider>(context, listen: false);

    userPlanProvider.setSelectedPlan(selectedPlan);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white100,
          title: CustomText(
            text: 'Seleccione un método de pago',
            color: AppColors.black100,
            fontSize: SizeConfig.scaleText(2),
            fontWeight: FontWeight.w500,
            maxLines: 3,
          ),
          content: SizedBox(
            width: SizeConfig.scaleWidth(100),
            height: SizeConfig.scaleHeight(26),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLogo(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text:
                          'Usted ha seleccionado el plan ${selectedPlan.name}',
                      color: AppColors.black100,
                      fontSize: SizeConfig.scaleText(1.7),
                      fontWeight: FontWeight.w400,
                      maxLines: 3,
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(2),
                    ),
                    CustomText(
                      text:
                          'Nota: Una vez realizado el pago, no se aceptan devoluciones.',
                      color: AppColors.red300,
                      fontSize: SizeConfig.scaleText(1.5),
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.start,
                      maxLines: 3,
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: 'Transferencia',
                    color: AppColors.black100,
                    width: SizeConfig.scaleWidth(15),
                    onPressed: () {
                      context.go('/dashboard/plans/transfer-payment');
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.scaleHeight(2),
                  ),
                  CustomButton(
                    text: 'Tarjeta de Crédito',
                    color: AppColors.brown200,
                    width: SizeConfig.scaleWidth(15),
                    onPressed: () {
                      showComingSoon(
                        context: context,
                        onButtonPressed: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  static Future<void> showLogout(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.white100,
            title: CustomText(
              text: 'Confirmar Cierre de Sesión',
              color: AppColors.black100,
              fontSize: SizeConfig.scaleText(2.5),
              fontWeight: FontWeight.w500,
            ),
            content: SizedBox(
              width: SizeConfig.scaleWidth(100),
              height: SizeConfig.scaleHeight(23),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLogo(),
                  Center(
                    child: SizedBox(
                      width: SizeConfig.scaleWidth(60),
                      height: SizeConfig.scaleHeight(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Estás seguro que deseas cerrar sesión?',
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleText(2),
                            fontWeight: FontWeight.w400,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: CustomText(
                  text: 'No',
                  color: AppColors.beige200,
                  fontSize: SizeConfig.scaleText(2),
                  fontWeight: FontWeight.w500,
                ),
              ),
              CustomButton(
                text: 'Sí',
                color: AppColors.brown200,
                width: SizeConfig.scaleWidth(6),
                onPressed: () {
                  Router.neglect(
                    context,
                    () => context.go('/login'),
                  );
                },
              ),
            ],
          );
        });
  }

  static Future<void> showProfilePhotoPicker(BuildContext context) {
    RegisterProvider registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(FontAwesomeIcons.images),
                title: CustomText(
                  text: 'Galería',
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                  fontSize: SizeConfig.scaleText(2),
                ),
                onTap: () {
                  registerProvider.pickImage(context, ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.cameraRetro),
                title: CustomText(
                  text: 'Cámara',
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                  fontSize: SizeConfig.scaleText(2),
                ),
                onTap: () {
                  registerProvider.pickImage(context, ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showTransferPaymentPicker(
      BuildContext context, String dni) {
    UserPlanProvider userPlanProvider =
        Provider.of<UserPlanProvider>(context, listen: false);
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(FontAwesomeIcons.images),
                title: CustomText(
                  text: 'Galería',
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                  fontSize: SizeConfig.scaleText(2),
                ),
                onTap: () {
                  userPlanProvider.pickImage(context, ImageSource.gallery, dni);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.cameraRetro),
                title: CustomText(
                  text: 'Cámara',
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                  fontSize: SizeConfig.scaleText(2),
                ),
                onTap: () {
                  userPlanProvider.pickImage(context, ImageSource.camera, dni);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showBooleanOptions(
      BuildContext context, TextEditingController controller) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.white100,
            title: CustomText(
              text: 'Seleccione una opción:',
              color: AppColors.black100,
              fontSize: SizeConfig.scaleText(2),
              fontWeight: FontWeight.w500,
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: 'No',
                    color: AppColors.beige200,
                    width: SizeConfig.scaleWidth(6),
                    onPressed: () {
                      controller.text = 'NO';
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: SizeConfig.scaleWidth(2),
                  ),
                  CustomButton(
                    text: 'Sí',
                    color: AppColors.brown200,
                    width: SizeConfig.scaleWidth(6),
                    onPressed: () {
                      controller.text = 'SI';
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }

  static Future<void> showDiseasesOptions(
      BuildContext context, TextEditingController controller) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.white100,
            title: CustomText(
              text: 'Seleccione una opción:',
              color: AppColors.black100,
              fontSize: SizeConfig.scaleText(2),
              fontWeight: FontWeight.w500,
            ),
            content: SizedBox(
              height: SizeConfig.scaleHeight(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    text: 'Padre',
                    color: AppColors.beige200,
                    width: SizeConfig.scaleWidth(10),
                    onPressed: () {
                      controller.text = 'Padre';
                      Navigator.pop(context);
                    },
                  ),
                  CustomButton(
                    text: 'Madre',
                    color: AppColors.brown200,
                    width: SizeConfig.scaleWidth(10),
                    onPressed: () {
                      controller.text = 'Madre';
                      Navigator.pop(context);
                    },
                  ),
                  CustomButton(
                    text: 'Ninguno',
                    color: AppColors.brown200,
                    width: SizeConfig.scaleWidth(10),
                    onPressed: () {
                      controller.text = 'Ninguno';
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  static Future<void> showSheduleConfirm(BuildContext context) async {
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    ClassProvider classProvider =
        Provider.of<ClassProvider>(context, listen: false);

    ClassModel selectedClass = classProvider.selectedClass!;

    //? Formatear la hora de inicio y fin
    String startHour = selectedClass.schedule!.startHour.substring(0, 5);
    String endHour = selectedClass.schedule!.endHour.substring(0, 5);

    //? Obtener la fecha de la cita
    String selectedDate = selectedClass.classDate;

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.white100,
            title: CustomText(
              text: 'Confirmar cita',
              color: AppColors.black100,
              fontSize: SizeConfig.scaleText(2.5),
              fontWeight: FontWeight.w500,
            ),
            content: SizedBox(
              width: SizeConfig.scaleWidth(100),
              height: SizeConfig.scaleHeight(32),
              child: Column(
                children: [
                  _buildLogo(),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Nombre:',
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleHeight(2),
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(1),
                          ),
                          CustomText(
                            text: 'Apellido:',
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleHeight(2),
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(1),
                          ),
                          CustomText(
                            text: 'Fecha:',
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleHeight(2),
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(1),
                          ),
                          CustomText(
                            text: 'Hora de inicio:',
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleHeight(2),
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(1),
                          ),
                          CustomText(
                            text: 'Hora de fin:',
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleHeight(2),
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(1),
                          ),
                          CustomText(
                            text: 'Duración:',
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleHeight(2),
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: SizeConfig.scaleWidth(5),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: loginProvider.user!.name,
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleHeight(2),
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(1),
                          ),
                          CustomText(
                            text: loginProvider.user!.lastname,
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleHeight(2),
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(1),
                          ),
                          CustomText(
                            text: selectedDate,
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleHeight(2),
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(1),
                          ),
                          CustomText(
                            text: '$startHour hrs',
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleHeight(2),
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(1),
                          ),
                          CustomText(
                            text: '$endHour hrs',
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleHeight(2),
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(1),
                          ),
                          CustomText(
                            text: '50 min',
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleHeight(2),
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              CustomTextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'Cancelar',
                color: AppColors.brown200,
              ),
              CustomButton(
                  onPressed: () {},
                  text: 'Confirmar',
                  color: AppColors.brown200,
                  width: SizeConfig.scaleWidth(10)),
            ],
          );
        });
  }

  static Future<void> showResetPassword(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController pinController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Para permitir que el modal ocupe más espacio
      builder: (BuildContext bc) {
        bool sendEmail = false;
        bool resetPassword = false;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.scaleWidth(5),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CustomText(
                        text: 'Restablecer Contraseña',
                        color: AppColors.black100,
                        fontSize: SizeConfig.scaleText(2.5),
                        fontWeight: FontWeight.w500,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: SizeConfig.scaleHeight(1)),

                    // Formulario para enviar correo
                    Visibility(
                      visible: !sendEmail,
                      child: Column(
                        children: [
                          CustomTextField(
                            title: 'Correo Electrónico',
                            labelColor: AppColors.black100,
                            hintText: 'info@curve.com',
                            typeTextField: TextFieldType.email,
                            controller: emailController,
                            fontSize: SizeConfig.scaleText(1.7),
                          ),
                          SizedBox(height: SizeConfig.scaleHeight(1)),
                          Center(
                            child: CustomButton(
                              onPressed: () async {
                                //? Validar correo debe tener una
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(emailController.text)) {
                                  return;
                                }
                                //? Enviar al server el correo para enviar el código

                                setState(() {
                                  sendEmail = true;
                                });
                              },
                              text: 'Enviar Código',
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: SizeConfig.scaleHeight(1)),

                    // Formulario para código de verificación
                    Visibility(
                      visible: sendEmail && !resetPassword,
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              width: SizeConfig.scaleWidth(60),
                              decoration: BoxDecoration(
                                color: AppColors.white100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding:
                                  EdgeInsets.all(SizeConfig.scaleHeight(1)),
                              child: PinCodeTextField(
                                appContext: context,
                                length: 4,
                                cursorColor: AppColors.black100,
                                controller: pinController,
                                backgroundColor: AppColors.white100,
                              ),
                            ),
                            SizedBox(height: SizeConfig.scaleHeight(2)),
                            CustomButton(
                              onPressed: () async {
                                //? Validar el código en el servidor
                                if (!RegExp(r'^[0-9]{4}$')
                                    .hasMatch(pinController.text)) {
                                  return;
                                }
                                setState(() {
                                  resetPassword = true;
                                });
                              },
                              text: 'Validar Código',
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Formulario para restablecer contraseña
                    Visibility(
                      visible: sendEmail && resetPassword,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextField(
                            title: 'Contraseña',
                            labelColor: AppColors.black100,
                            hintText: '********',
                            typeTextField: TextFieldType.password,
                            controller: passwordController,
                            fontSize: SizeConfig.scaleText(1.7),
                          ),
                          CustomTextField(
                            title: 'Confirmar Contraseña',
                            labelColor: AppColors.black100,
                            hintText: '********',
                            typeTextField: TextFieldType.password,
                            controller: confirmPasswordController,
                            fontSize: SizeConfig.scaleText(1.7),
                          ),
                          SizedBox(height: SizeConfig.scaleHeight(1)),
                          Center(
                            child: CustomButton(
                              onPressed: () async {
                                // Validar que las contraseñas coincidan
                                if (passwordController.text !=
                                    confirmPasswordController.text) {
                                  CustomSnackBar.show(
                                    context,
                                    'Las contraseñas no coinciden',
                                    SnackBarType.error,
                                  );
                                  return;
                                }

                                // Validar que la contraseña cumpla con los requisitos
                                if (!RegExp(
                                        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,15}$')
                                    .hasMatch(passwordController.text)) {
                                  CustomSnackBar.show(
                                    context,
                                    'La contraseña debe tener entre 8 y 15 caracteres, incluir una letra mayúscula, una minúscula, un número y un carácter especial.',
                                    SnackBarType.error,
                                  );
                                  return;
                                }

                                // Enviar al servidor la nueva contraseña
                                try {
                                  // Lógica para enviar la contraseña al servidor
                                  // await yourApiService.resetPassword(passwordController.text);

                                  // Redirigir al login después de éxito
                                  Navigator.pop(context);
                                  CustomSnackBar.show(
                                    context,
                                    'Contraseña restablecida correctamente',
                                    SnackBarType.success,
                                  );
                                } catch (error) {
                                  CustomSnackBar.show(
                                    context,
                                    'Error al restablecer la contraseña. Inténtalo de nuevo.',
                                    SnackBarType.error,
                                  );
                                }
                              },
                              text: 'Restablecer Contraseña',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              ),
            );
          },
        );
      },
    );
  }
}
