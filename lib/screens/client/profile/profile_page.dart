import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/helpers/launchers/maps_launcher.dart';
import 'package:pilates/providers/client_class_provider.dart';
import 'package:pilates/theme/appbars/bottom_bar.dart';
import 'package:pilates/theme/appbars/custom_appbar.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/widgets/buttons.dart';
import 'package:pilates/theme/widgets/images_containers.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  Texts texts = Texts();
  ImagesContainers imagesContainers = ImagesContainers();
  Buttons buttons = Buttons();
  MapAppLauncher mapAppLauncher = MapAppLauncher();

  void showCommingSoonDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: texts.normalText(
              text: 'Próximamente ...',
              color: Colors.black,
              fontSize: 2.5 * SizeConfig.heightMultiplier,
              fontWeight: FontWeight.w500,
            ),
            content: SizedBox(
              width: 100 * SizeConfig.widthMultiplier,
              height: 35 * SizeConfig.heightMultiplier,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logotipo de Curves
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
                  SizedBox(
                    width: 100 * SizeConfig.widthMultiplier,
                    height: 15 * SizeConfig.heightMultiplier,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        texts.normalText(
                          text:
                              'El módulo estará disponible en la próxima actualización',
                          color: Colors.black,
                          fontSize: 2 * SizeConfig.heightMultiplier,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 2 * SizeConfig.heightMultiplier,
                        ),
                        Center(
                          child: buttons.standart(
                            text: 'Aceptar',
                            color: ColorsPalette.primaryColor,
                            width: 8 * SizeConfig.widthMultiplier,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void showLogOutConfirm() {
    ClientClassProvider clientClassProvider =
        Provider.of<ClientClassProvider>(context, listen: false);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: texts.normalText(
              text: 'Confirmar Cierre de Sesión',
              color: Colors.black,
              fontSize: 2.5 * SizeConfig.heightMultiplier,
              fontWeight: FontWeight.w500,
            ),
            content: SizedBox(
              width: 100 * SizeConfig.widthMultiplier,
              height: 28 * SizeConfig.heightMultiplier,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logotipo de Curves
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
                  Center(
                    child: SizedBox(
                      width: 60 * SizeConfig.widthMultiplier,
                      height: 8 * SizeConfig.heightMultiplier,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          texts.normalText(
                            text: 'Estás seguro que deseas cerrar sesión?',
                            color: Colors.black,
                            fontSize: 2 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w400,
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
                  Navigator.of(context).pop();
                },
                child: texts.normalText(
                  text: 'No',
                  color: ColorsPalette.primaryColor,
                  fontSize: 2 * SizeConfig.heightMultiplier,
                  fontWeight: FontWeight.w500,
                ),
              ),
              buttons.standart(
                text: 'Sí',
                color: ColorsPalette.primaryColor,
                width: 4 * SizeConfig.widthMultiplier,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);

                  Future.delayed(const Duration(seconds: 3), () {
                    clientClassProvider.clearAll();
                  });
                },
              ),
            ],
          );
        });
  }

  String convertDate(String date) {
    String year = date.substring(0, 4);
    String month = date.substring(5, 7);
    String day = date.substring(8, 10);

    // La fecah debe mostrarse como Miércoles 12 de Mayo de 2021
    String monthName = '';

    switch (month) {
      case '01':
        monthName = 'Enero';
        break;
      case '02':
        monthName = 'Febrero';
        break;
      case '03':
        monthName = 'Marzo';
        break;
      case '04':
        monthName = 'Abril';
        break;
      case '05':
        monthName = 'Mayo';
        break;
      case '06':
        monthName = 'Junio';
        break;
      case '07':
        monthName = 'Julio';
        break;
      case '08':
        monthName = 'Agosto';
        break;
      case '09':
        monthName = 'Septiembre';
        break;
      case '10':
        monthName = 'Octubre';
        break;
      case '11':
        monthName = 'Noviembre';
        break;
      case '12':
        monthName = 'Diciembre';
        break;
    }

    return '$day de $monthName de $year';
  }

  void showPaymentInvoice() {
    ClientClassProvider clientClassProvider =
        Provider.of<ClientClassProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: texts.normalText(
            text: 'Comprobante de Pago',
            color: Colors.black,
            fontSize: 2.5 * SizeConfig.heightMultiplier,
            fontWeight: FontWeight.w500,
          ),
          content: SizedBox(
            width: 100 * SizeConfig.widthMultiplier,
            height: 50 * SizeConfig.heightMultiplier,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ),
                  width: 100 * SizeConfig.widthMultiplier,
                  height: 45 * SizeConfig.heightMultiplier,
                  child: InteractiveViewer(
                    panEnabled: true, // Permite desplazar la imagen
                    minScale: 0.5,
                    maxScale: 10,
                    child: Center(
                      child: Image.network(
                        clientClassProvider.currentPlan!.paymentToken,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5 * SizeConfig.heightMultiplier,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    ClientClassProvider clientClassProvider =
        Provider.of<ClientClassProvider>(context);
    return Scaffold(
      appBar: const CustomAppBar(backgroundColor: ColorsPalette.primaryColor),
      body: Stack(children: [
        Container(
          color: ColorsPalette.primaryColor,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 5 * SizeConfig.widthMultiplier,
                    vertical: 1 * SizeConfig.heightMultiplier),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 8 * SizeConfig.imageSizeMultiplier,
                      backgroundColor: Colors.white,
                      child: Icon(
                        FontAwesomeIcons.addressCard,
                        size: 8 * SizeConfig.imageSizeMultiplier,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 5 * SizeConfig.widthMultiplier,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        texts.normalText(
                            text: 'Mi Cuenta',
                            color: Colors.white,
                            fontSize: 4 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w400),
                        texts.normalText(
                            text: 'Tu información personal',
                            color: Colors.white,
                            fontSize: 2 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.left),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 14 * SizeConfig.heightMultiplier,
              ),
              Flexible(
                child: Container(
                    width: 100 * SizeConfig.widthMultiplier,
                    height: 57 * SizeConfig.heightMultiplier,
                    padding: EdgeInsets.symmetric(
                        horizontal: 5 * SizeConfig.widthMultiplier,
                        vertical: 2 * SizeConfig.heightMultiplier),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(
                                25))), //Color.fromARGB(255, 87, 136, 120)
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12 * SizeConfig.heightMultiplier,
                          ),
                          Center(
                            child: texts.normalText(
                                text:
                                    'Bienvenido ${clientClassProvider.loginResponse!.client.name} 👋',
                                color: Colors.black,
                                fontSize: 2.5 * SizeConfig.heightMultiplier,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 1.5 * SizeConfig.heightMultiplier,
                          ),
                          texts.normalText(
                              text: 'Mi Plan',
                              color: Colors.black,
                              fontSize: 2 * SizeConfig.heightMultiplier,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.left),
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 15 * SizeConfig.heightMultiplier,
                              enlargeCenterPage: true,
                              aspectRatio: 1 / 1,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: false,
                              viewportFraction: 0.4,
                            ),
                            items: [
                              GestureDetector(
                                onTap: () {
                                  showPaymentInvoice();
                                },
                                child: Container(
                                  width: 15 * SizeConfig.heightMultiplier,
                                  height: 15 * SizeConfig.heightMultiplier,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 5,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.fileInvoiceDollar,
                                        size: 4 * SizeConfig.heightMultiplier,
                                      ),
                                      SizedBox(
                                        height: 1 * SizeConfig.heightMultiplier,
                                      ),
                                      texts.normalText(
                                          text: 'Visualizar Pago',
                                          color: Colors.black,
                                          fontSize:
                                              1.8 * SizeConfig.heightMultiplier,
                                          fontWeight: FontWeight.w500,
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/plans');
                                },
                                child: Container(
                                  width: 15 * SizeConfig.heightMultiplier,
                                  height: 15 * SizeConfig.heightMultiplier,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 5,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.idCardClip,
                                        size: 4 * SizeConfig.heightMultiplier,
                                      ),
                                      SizedBox(
                                        height: 1 * SizeConfig.heightMultiplier,
                                      ),
                                      texts.normalText(
                                          text: 'Renovar Plan',
                                          color: Colors.black,
                                          fontSize:
                                              1.8 * SizeConfig.heightMultiplier,
                                          fontWeight: FontWeight.w500,
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showCommingSoonDialog();
                                },
                                child: Container(
                                  width: 15 * SizeConfig.heightMultiplier,
                                  height: 15 * SizeConfig.heightMultiplier,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 5,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.circleInfo,
                                        size: 4 * SizeConfig.heightMultiplier,
                                      ),
                                      SizedBox(
                                        height: 1 * SizeConfig.heightMultiplier,
                                      ),
                                      texts.normalText(
                                          text: 'Actualizar información',
                                          color: Colors.black,
                                          fontSize:
                                              1.8 * SizeConfig.heightMultiplier,
                                          fontWeight: FontWeight.w500,
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showLogOutConfirm();
                                },
                                child: Container(
                                  width: 15 * SizeConfig.heightMultiplier,
                                  height: 15 * SizeConfig.heightMultiplier,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 5,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.rightFromBracket,
                                        size: 4 * SizeConfig.heightMultiplier,
                                      ),
                                      SizedBox(
                                        height: 1 * SizeConfig.heightMultiplier,
                                      ),
                                      texts.normalText(
                                          text: 'Cerrar Sesión',
                                          color: Colors.black,
                                          fontSize:
                                              1.8 * SizeConfig.heightMultiplier,
                                          fontWeight: FontWeight.w500,
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.5 * SizeConfig.heightMultiplier,
                          ),
                          texts.normalText(
                              text: 'Detalles:',
                              color: Colors.black,
                              fontSize: 2 * SizeConfig.heightMultiplier,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.left),
                          SizedBox(
                            height: 1 * SizeConfig.heightMultiplier,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  texts.normalText(
                                      text: 'Plan Contratado: ',
                                      color: Colors.black,
                                      fontSize:
                                          1.5 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.bold),
                                  SizedBox(
                                    width: 1 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                      text: clientClassProvider
                                              .currentPlan?.planName ??
                                          'Sin datos para mostrar',
                                      color: Colors.black,
                                      fontSize:
                                          1.5 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                              Row(
                                children: [
                                  texts.normalText(
                                      text: 'Descripción: ',
                                      color: Colors.black,
                                      fontSize:
                                          1.5 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.bold),
                                  SizedBox(
                                    width: 1 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                      text: clientClassProvider
                                              .currentPlan?.planDescription ??
                                          'Sin datos para mostrar',
                                      color: Colors.black,
                                      fontSize:
                                          1.5 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                              Row(
                                children: [
                                  texts.normalText(
                                      text: 'Precio: ',
                                      color: Colors.black,
                                      fontSize:
                                          1.5 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.bold),
                                  SizedBox(
                                    width: 1 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                      text: clientClassProvider.currentPlan !=
                                              null
                                          ? '\$ ${clientClassProvider.currentPlan!.planPrice}'
                                          : 'Sin datos para mostrar',
                                      color: Colors.black,
                                      fontSize:
                                          1.5 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                              Row(
                                children: [
                                  texts.normalText(
                                      text: 'Vigencia: ',
                                      color: Colors.black,
                                      fontSize:
                                          1.5 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.bold),
                                  SizedBox(
                                    width: 1 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                      text: clientClassProvider.currentPlan !=
                                              null
                                          ? 'Hasta el ${convertDate(clientClassProvider.currentPlan!.planExpiration.toString().substring(0, 10))}'
                                          : 'Sin datos para mostrar',
                                      color: Colors.black,
                                      fontSize:
                                          1.5 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w400),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 1.5 * SizeConfig.heightMultiplier,
                          ),
                          Center(
                            child: SizedBox(
                              width: 60 * SizeConfig.widthMultiplier,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 15 * SizeConfig.widthMultiplier,
                                        height: 15 * SizeConfig.widthMultiplier,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF262626),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        padding: EdgeInsets.all(
                                            2 * SizeConfig.widthMultiplier),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            texts.normalText(
                                                text:
                                                    '${clientClassProvider.currentPlan?.numberOfClasses ?? 0}',
                                                color: Colors.white,
                                                fontSize: 3.5 *
                                                    SizeConfig.heightMultiplier,
                                                fontWeight: FontWeight.w600),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1 * SizeConfig.heightMultiplier,
                                      ),
                                      texts.normalText(
                                          text: 'Clases contratadas',
                                          color: Colors.black,
                                          fontSize:
                                              1.5 * SizeConfig.heightMultiplier,
                                          fontWeight: FontWeight.w400),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 15 * SizeConfig.widthMultiplier,
                                        height: 15 * SizeConfig.widthMultiplier,
                                        decoration: BoxDecoration(
                                            color: ColorsPalette.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        padding: EdgeInsets.all(
                                            2 * SizeConfig.widthMultiplier),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            texts.normalText(
                                              text:
                                                  '${(clientClassProvider.currentPlan?.numberOfClasses ?? 0) - (clientClassProvider.currentPlan?.attendedClasses ?? 0)}',
                                              color: Colors.white,
                                              fontSize: 3.5 *
                                                  SizeConfig.heightMultiplier,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1 * SizeConfig.heightMultiplier,
                                      ),
                                      texts.normalText(
                                          text: 'Clases restantes',
                                          color: Colors.black,
                                          fontSize:
                                              1.5 * SizeConfig.heightMultiplier,
                                          fontWeight: FontWeight.w400),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
        Positioned(
          top: 12 * SizeConfig.heightMultiplier,
          left: 8 * SizeConfig.widthMultiplier,
          right: 8 * SizeConfig.widthMultiplier,
          child: Container(
            width: 100 * SizeConfig.widthMultiplier,
            height: 50 * SizeConfig.widthMultiplier,
            padding: EdgeInsets.symmetric(
                horizontal: 5 * SizeConfig.widthMultiplier,
                vertical: 2 * SizeConfig.heightMultiplier),
            decoration: BoxDecoration(
                color: const Color(0xFF262626),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 20 * SizeConfig.widthMultiplier,
                      height: 30 * SizeConfig.widthMultiplier,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          clientClassProvider.loginResponse!.client.photo,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5 * SizeConfig.widthMultiplier,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 20 * SizeConfig.widthMultiplier,
                              height: 10 * SizeConfig.widthMultiplier,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  'assets/logo/logo_rectangle.jpg',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1 * SizeConfig.heightMultiplier,
                        ),
                        texts.normalText(
                            text:
                                '${clientClassProvider.loginResponse!.client.name} ${clientClassProvider.loginResponse!.client.lastname}',
                            color: Colors.white,
                            fontSize: 1.6 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w500),
                        texts.normalText(
                            text: clientClassProvider
                                .loginResponse!.client.dniNumber,
                            color: Colors.white,
                            fontSize: 1.6 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w500),
                        texts.normalText(
                            text:
                                'Celular: ${clientClassProvider.loginResponse!.client.phone.replaceAll('+593', '0')}',
                            color: Colors.white,
                            fontSize: 1.6 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w500),
                        texts.normalText(
                            text:
                                'Cumpleaños: ${clientClassProvider.loginResponse!.client.birthdate.toString().substring(0, 10).replaceAll('-', ' / ')}',
                            color: Colors.white,
                            fontSize: 1.6 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w500),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 2 * SizeConfig.heightMultiplier,
                ),
                texts.normalText(
                    text:
                        'Miembro desde el ${convertDate(clientClassProvider.loginResponse!.client.createdAt.toString().substring(0, 10))}',
                    color: Colors.white,
                    fontSize: 1.6 * SizeConfig.heightMultiplier,
                    fontWeight: FontWeight.w500),
              ],
            ),
          ),
        ),
      ]),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
