import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/providers/register_provider.dart';
import 'package:pilates/theme/appbars/custom_appbar.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/modals/loading_modal.dart';
import 'package:pilates/theme/widgets/buttons.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';
import 'package:provider/provider.dart';

class TransferMethodPage extends StatefulWidget {
  const TransferMethodPage({super.key});

  @override
  TransferMethodPageState createState() => TransferMethodPageState();
}

class TransferMethodPageState extends State<TransferMethodPage> {
  Texts texts = Texts();
  Buttons buttons = Buttons();

  //Controladores

  // Modals
  final LoadingModal loadingModal = LoadingModal();

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    RegisterProvider registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);
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
                        FontAwesomeIcons.moneyBill,
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
                            text: 'Checkout',
                            color: Colors.white,
                            fontSize: 4 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w400),
                        texts.normalText(
                            text: 'Estás a un paso de comenzar',
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
                height: 2 * SizeConfig.heightMultiplier,
              ),
              Flexible(
                child: Container(
                    width: 100 * SizeConfig.widthMultiplier,
                    height: 78 * SizeConfig.heightMultiplier,
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
                          Center(
                            child: texts.normalText(
                                text: 'Tu credencial esta lista',
                                color: Colors.black,
                                fontSize: 2.5 * SizeConfig.heightMultiplier,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 2 * SizeConfig.heightMultiplier,
                          ),
                          Container(
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
                                        child: Image.file(
                                          File(
                                              registerProvider.imageFile!.path),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5 * SizeConfig.widthMultiplier,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 20 *
                                                  SizeConfig.widthMultiplier,
                                              height: 10 *
                                                  SizeConfig.widthMultiplier,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.asset(
                                                  'assets/logo/logo_rectangle.jpg',
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              1 * SizeConfig.heightMultiplier,
                                        ),
                                        texts.normalText(
                                            text:
                                                '${registerProvider.name} ${registerProvider.lastname}',
                                            color: Colors.white,
                                            fontSize: 1.6 *
                                                SizeConfig.heightMultiplier,
                                            fontWeight: FontWeight.w500),
                                        texts.normalText(
                                            text: registerProvider.dni!,
                                            color: Colors.white,
                                            fontSize: 1.6 *
                                                SizeConfig.heightMultiplier,
                                            fontWeight: FontWeight.w500),
                                        texts.normalText(
                                            text:
                                                'Celular: ${registerProvider.phone!.replaceAll('+593', '0')}',
                                            color: Colors.white,
                                            fontSize: 1.6 *
                                                SizeConfig.heightMultiplier,
                                            fontWeight: FontWeight.w500),
                                        texts.normalText(
                                            text:
                                                'Cumpleaños: ${registerProvider.birthday.toString().substring(0, 10)}',
                                            color: Colors.white,
                                            fontSize: 1.6 *
                                                SizeConfig.heightMultiplier,
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
                                        'Miembro desde el ${convertDate(DateTime.now().toString().substring(0, 10))}',
                                    color: Colors.white,
                                    fontSize: 1.6 * SizeConfig.heightMultiplier,
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2 * SizeConfig.heightMultiplier,
                          ),
                          texts.normalText(
                              text: 'Datos del plan contratado:',
                              color: Colors.black,
                              fontSize: 2.5 * SizeConfig.heightMultiplier,
                              fontWeight: FontWeight.w400),
                          SizedBox(
                            height: 2 * SizeConfig.heightMultiplier,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  texts.normalText(
                                      text: 'Cliente:',
                                      color: Colors.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w600),
                                  SizedBox(
                                    width: 2 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                      text:
                                          '${registerProvider.name} ${registerProvider.lastname}',
                                      color: Colors.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                              SizedBox(
                                height: 1 * SizeConfig.heightMultiplier,
                              ),
                              Row(
                                children: [
                                  texts.normalText(
                                      text: 'Identificación:',
                                      color: Colors.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w600),
                                  SizedBox(
                                    width: 2 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                      text: registerProvider.dni!,
                                      color: Colors.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                              SizedBox(
                                height: 1 * SizeConfig.heightMultiplier,
                              ),
                              Row(
                                children: [
                                  texts.normalText(
                                      text: 'Género:',
                                      color: Colors.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w600),
                                  SizedBox(
                                    width: 2 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                      text: registerProvider.gender! == 'Male'
                                          ? 'Masculino'
                                          : registerProvider.gender! == 'Female'
                                              ? 'Femenino'
                                              : 'Prefiero no mencionarlo',
                                      color: Colors.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                              SizedBox(
                                height: 1 * SizeConfig.heightMultiplier,
                              ),
                              Row(
                                children: [
                                  texts.normalText(
                                      text: 'Cumpleaños:',
                                      color: Colors.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w600),
                                  SizedBox(
                                    width: 2 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                      text: registerProvider.birthday!
                                          .toString()
                                          .substring(0, 10),
                                      color: Colors.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                              SizedBox(
                                height: 1 * SizeConfig.heightMultiplier,
                              ),
                              Row(
                                children: [
                                  texts.normalText(
                                      text: 'Email:',
                                      color: Colors.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w600),
                                  SizedBox(
                                    width: 2 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                      text: registerProvider.email!,
                                      color: Colors.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                              SizedBox(
                                height: 1 * SizeConfig.heightMultiplier,
                              ),
                              Row(
                                children: [
                                  texts.normalText(
                                      text: 'Teléfono:',
                                      color: Colors.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w600),
                                  SizedBox(
                                    width: 2 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                      text: registerProvider.phone!,
                                      color: Colors.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                              SizedBox(
                                height: 1 * SizeConfig.heightMultiplier,
                              ),
                              Row(
                                children: [
                                  texts.normalText(
                                      text: 'Plan:',
                                      color: Colors.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w600),
                                  SizedBox(
                                    width: 2 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                      text:
                                          '${registerProvider.selectedPlan!.name} - ${registerProvider.selectedPlan!.description}',
                                      color: Colors.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                              SizedBox(
                                height: 1 * SizeConfig.heightMultiplier,
                              ),
                              Row(
                                children: [
                                  texts.normalText(
                                      text: 'Vigencia desde:',
                                      color: Colors.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w600),
                                  SizedBox(
                                    width: 2 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                      text: convertDate(DateTime.now()
                                          .toString()
                                          .substring(0, 10)),
                                      color: Colors.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                              SizedBox(
                                height: 1 * SizeConfig.heightMultiplier,
                              ),
                              Row(
                                children: [
                                  texts.normalText(
                                      text: 'Vigencia hasta:',
                                      color: Colors.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w600),
                                  SizedBox(
                                    width: 2 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                      text: convertDate(DateTime.now()
                                          .add(Duration(
                                              days: registerProvider
                                                  .selectedPlan!.classVigency))
                                          .toString()
                                          .substring(0, 10)),
                                      color: Colors.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                              SizedBox(
                                height: 1 * SizeConfig.heightMultiplier,
                              ),
                              Row(
                                children: [
                                  texts.normalText(
                                      text: 'Precio:',
                                      color: Colors.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w600),
                                  SizedBox(
                                    width: 2 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                      text:
                                          '\$ ${registerProvider.selectedPlan!.price.toStringAsFixed(2)}',
                                      color: Colors.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
