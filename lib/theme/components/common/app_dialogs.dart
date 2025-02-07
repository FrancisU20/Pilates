import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pilates/models/plan/plan_model.dart';
import 'package:pilates/models/class/class_model.dart';
import 'package:pilates/providers/admin/admin_provider.dart';
import 'package:pilates/providers/login/login_provider.dart';
import 'package:pilates/providers/register/register_provider.dart';
import 'package:pilates/providers/class/class_provider.dart';
import 'package:pilates/providers/user-class/user_class_provider.dart';
import 'package:pilates/providers/user-plan/user_plan_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/components/common/app_loading.dart';
import 'package:pilates/theme/widgets/custom_button.dart';
import 'package:pilates/theme/widgets/custom_snack_bar.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/widgets/custom_text_button.dart';
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
                              context.pop();
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
                          context.pop();
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
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
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
                  context.pop();
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
                  context.pop();
                  context.go('/');
                  loginProvider.logout(context);
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
                  context.pop();
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
                  context.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showProfilePhotoPickerUpdate(BuildContext context) {
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
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
                  loginProvider.pickImage(context, ImageSource.gallery);
                  context.pop();
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
                  loginProvider.pickImage(context, ImageSource.camera);
                  context.pop();
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
                  context.pop();
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
                  context.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showBooleanOptions(
      BuildContext context, TextEditingController controller, String title) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.white100,
            title: CustomText(
              text: title,
              color: AppColors.black100,
              fontSize: SizeConfig.scaleText(1.7),
              fontWeight: FontWeight.w500,
              maxLines: 5,
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
                      controller.text = 'No';
                      context.pop();
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
                      controller.text = 'Sí';
                      context.pop();
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }

  static Future<void> showDiseasesOptions(
      BuildContext context, TextEditingController controller, String title) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.white100,
            title: CustomText(
              text: title,
              color: AppColors.black100,
              fontSize: SizeConfig.scaleText(1.7),
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
                      context.pop();
                    },
                  ),
                  CustomButton(
                    text: 'Madre',
                    color: AppColors.brown200,
                    width: SizeConfig.scaleWidth(10),
                    onPressed: () {
                      controller.text = 'Madre';
                      context.pop();
                    },
                  ),
                  CustomButton(
                    text: 'Ninguno',
                    color: AppColors.green200,
                    width: SizeConfig.scaleWidth(10),
                    onPressed: () {
                      controller.text = 'Ninguno';
                      context.pop();
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
                            fontSize: SizeConfig.scaleText(2),
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(1),
                          ),
                          CustomText(
                            text: 'Apellido:',
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleText(2),
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(1),
                          ),
                          CustomText(
                            text: 'Fecha:',
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleText(2),
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(1),
                          ),
                          CustomText(
                            text: 'Hora de inicio:',
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleText(2),
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(1),
                          ),
                          CustomText(
                            text: 'Hora de fin:',
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleText(2),
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(1),
                          ),
                          CustomText(
                            text: 'Duración:',
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleText(2),
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
                            fontSize: SizeConfig.scaleText(2),
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(1),
                          ),
                          CustomText(
                            text: loginProvider.user!.lastname,
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleText(2),
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(1),
                          ),
                          CustomText(
                            text: selectedDate,
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleText(2),
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(1),
                          ),
                          CustomText(
                            text: '$startHour hrs',
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleText(2),
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(1),
                          ),
                          CustomText(
                            text: '$endHour hrs',
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleText(2),
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(1),
                          ),
                          CustomText(
                            text: '50 min',
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleText(2),
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
                  context.pop();
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

  static Future<void> showDeleteConfirm(
      BuildContext context, String classId, DateTime classDate) async {
    DateTime now = DateTime.now();

    //Restar las diferencias de horas
    int hoursDifference = classDate.difference(now).inHours;

    showDialog(
        context: context,
        builder: (context) {
          return Stack(
            children: [
              AlertDialog(
                backgroundColor: AppColors.white100,
                title: CustomText(
                  text: 'Confirmar cancelación',
                  color: AppColors.black100,
                  fontSize: SizeConfig.scaleText(2.5),
                  fontWeight: FontWeight.w500,
                ),
                content: SizedBox(
                  width: SizeConfig.scaleWidth(100),
                  height: SizeConfig.scaleHeight(55),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLogo(),
                      SizedBox(
                        width: SizeConfig.scaleWidth(100),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Estás seguro de cancelar la cita?',
                              color: AppColors.black100,
                              fontSize: SizeConfig.scaleText(1.8),
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(
                              height: SizeConfig.scaleHeight(1),
                            ),
                            CustomText(
                              text: 'Aviso Importante:',
                              color: AppColors.gold100,
                              fontSize: SizeConfig.scaleText(1.8),
                              fontWeight: FontWeight.w700,
                              textAlign: TextAlign.justify,
                            ),
                            CustomText(
                              text:
                                  'Si decides cancelar una clase, puedes hacerlo con al menos 24 horas de anticipación a las 00:00 del día de la clase. De esta forma, la clase se repondrá automáticamente a tu plan y no la perderás. Recuerda que no se permite cancelar clases después de este plazo.',
                              color: AppColors.green200,
                              fontSize: SizeConfig.scaleText(1.8),
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                            ),
                            SizedBox(
                              height: SizeConfig.scaleHeight(1),
                            ),
                            CustomText(
                              text: 'Atención:',
                              color: AppColors.red300,
                              fontSize: SizeConfig.scaleText(1.8),
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.justify,
                            ),
                            CustomText(
                              text:
                                  'Si cancelas la última clase disponible de tu plan, esta no será repuesta, y el plan se marcará como completado.',
                              color: AppColors.red300,
                              fontSize: SizeConfig.scaleText(1.8),
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.justify,
                              maxLines: 5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: CustomText(
                      text: 'Regresar',
                      color: AppColors.brown200,
                      fontSize: SizeConfig.scaleText(2),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CustomButton(
                    text: 'Confirmar',
                    color: AppColors.brown200,
                    width: SizeConfig.scaleWidth(10),
                    onPressed: () async {
                      try {
                        if (hoursDifference < 24) {
                          context.pop();
                          CustomSnackBar.show(
                              context,
                              'No se puede cancelar la cita, debe ser con 24 horas de anticipación.',
                              SnackBarType.error);
                          return;
                        }
                        UserClassProvider userClassProvider =
                            Provider.of<UserClassProvider>(context,
                                listen: false);
                        await userClassProvider.updateUserClassStatus(
                            context, classId, 'X'); //! X porque es cancelada

                        if (!context.mounted) return;
                        context.pop();
                      } catch (e) {
                        context.pop();
                        CustomSnackBar.show(
                            context, e.toString(), SnackBarType.error);
                      }
                    },
                  ),
                ],
              ),
              const AppLoading(),
            ],
          );
        });
  }

  static Future<void> showDeleteAccountDialog(BuildContext context) {
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.white100,
            title: CustomText(
              text: 'Confirmar eliminación de cuenta',
              color: AppColors.black100,
              fontSize: SizeConfig.scaleText(2.5),
              fontWeight: FontWeight.w500,
            ),
            content: SizedBox(
              width: SizeConfig.scaleWidth(100),
              height: SizeConfig.scaleHeight(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLogo(),
                  Center(
                    child: SizedBox(
                      width: SizeConfig.scaleWidth(60),
                      height: SizeConfig.scaleHeight(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text:
                                'Tus datos serán eliminados de forma permanente, y no podrás recuperarlos.',
                            color: AppColors.red300,
                            fontSize: SizeConfig.scaleText(2),
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.justify,
                            maxLines: 3,
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(2),
                          ),
                          CustomText(
                            text: 'Estás seguro que deseas eliminar tu cuenta?',
                            color: AppColors.red300,
                            fontSize: SizeConfig.scaleText(2),
                            fontWeight: FontWeight.w500,
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
                  context.pop();
                },
                child: CustomText(
                  text: 'No',
                  color: AppColors.green200,
                  fontSize: SizeConfig.scaleText(2),
                  fontWeight: FontWeight.w500,
                ),
              ),
              CustomButton(
                text: 'Sí',
                color: AppColors.red300,
                width: SizeConfig.scaleWidth(6),
                onPressed: () async {
                  await loginProvider.deleteUser(context);
                },
              ),
            ],
          );
        });
  }

  static Future<void> showMonthSelector(
      BuildContext context, AdminProvider adminProvider) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.white100,
          child: SizedBox(
            height:
                SizeConfig.scaleHeight(35), // Ajustar altura según necesidad
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(SizeConfig.scaleWidth(
                      2)), // Espaciado alrededor del título
                  child: Text(
                    "Selecciona un mes:",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: AppColors.black100,
                        fontSize: SizeConfig.scaleText(2.5),
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.5,
                        height: 0.9,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.scaleWidth(50),
                  child: const Divider(color: AppColors.black100),
                ), // Línea divisora opcional
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: adminProvider.listMonth.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: CustomText(
                          text: adminProvider
                              .getStringMonth(adminProvider.listMonth[index]),
                          color: AppColors.black100,
                          fontSize: SizeConfig.scaleText(1.8),
                          fontWeight: FontWeight.w600,
                        ),
                        onTap: () async {
                          adminProvider
                              .setSelectedMonth(adminProvider.listMonth[index]);

                          context.pop();

                          await adminProvider.getUsersPlans(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> showInvoice(BuildContext context, String invoiceUrl) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.transparent,
          insetPadding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  invoiceUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.black200, // Fondo negro
                      shape: BoxShape.circle, // Hace que el fondo sea circular
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.close, color: AppColors.white100),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showUserPhoto(BuildContext context, String userPhoto) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.transparent,
          insetPadding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  userPhoto,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.black200, // Fondo negro
                      shape: BoxShape.circle, // Hace que el fondo sea circular
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.close, color: AppColors.white100),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}
