import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/controllers/client_plans_controller.dart';
import 'package:pilates/controllers/plans_controller.dart';
import 'package:pilates/models/response/available_client_class_response.dart';
import 'package:pilates/models/response/plans_response.dart';
import 'package:pilates/providers/client_class_provider.dart';
import 'package:pilates/providers/register_provider.dart';
import 'package:pilates/theme/appbars/custom_appbar.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/modals/loading_modal.dart';
import 'package:pilates/theme/widgets/buttons.dart';
import 'package:pilates/theme/widgets/images_containers.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';
import 'package:provider/provider.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  PlanPageState createState() => PlanPageState();
}

class PlanPageState extends State<PlanPage> {
  Texts texts = Texts();
  ImagesContainers imagesContainers = ImagesContainers();
  Buttons buttons = Buttons();
  List<PlanResponse> listPlans = [];

  //Controladores
  PlansController plansController = PlansController();
  ClientPlansController clientPlansController = ClientPlansController();

  // Modals
  final LoadingModal loadingModal = LoadingModal();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPlans(); // Llamamos al método asíncrono aquí
    });
  }

  Future<bool> getAvailableClientClass(String clientId, String planId) async {
    try {
      AvailableClientClassResponse availableClientClassResponse =
          await clientPlansController.getAvailableClassesByClient(
              clientId, planId);

      int count = availableClientClassResponse.data.availableClasses;

      if (count > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('$e');
      return false;
    }
  }

  Future<bool> clientCanRenew() async {
    try {
      ClientClassProvider clientClassesProvider =
          Provider.of<ClientClassProvider>(context, listen: false);

      RegisterProvider registerProvider =
          Provider.of<RegisterProvider>(context, listen: false);

      bool canRenew = registerProvider.dni == null
          ? await getAvailableClientClass(
              clientClassesProvider.loginResponse!.client.id,
              clientClassesProvider.currentPlan?.planId ?? '1')
          : false;

      // Si el cliente tiene clases disponibles, no puede renovar aún
      if (canRenew) {
        // Mostrar mensaje y redirigir
        Future.microtask(() => {
              Navigator.pop(context),
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 5),
                  content: texts.normalText(
                      text:
                          'Aún tienes un plan activo, no puedes renovar hasta que este finalice',
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.start,
                      fontSize: 4 * SizeConfig.heightMultiplier,
                      color: ColorsPalette.white),
                  backgroundColor: ColorsPalette.redAged,
                ),
              )
            });
        return false; // No puede renovar
      }

      return true; // Puede renovar
    } catch (e) {
      log('Error en clientCanRenew: $e');
      return false; // En caso de error, retornar false
    }
  }

  void getPlans() async {
    try {
      RegisterProvider registerProvider =
          Provider.of<RegisterProvider>(context, listen: false);
      // Mostrar el modal de carga
      Future.microtask(() => {loadingModal.showLoadingModal(context)});

      // Verificar si el cliente puede renovar su plan
      if (registerProvider.dni == null) {
        bool canRenew = await clientCanRenew();

        // Si no puede renovar, mostrar el mensaje y salir
        if (!canRenew) {
          Future.microtask(() => {loadingModal.closeLoadingModal(context)});
          return; // Detener ejecución aquí si no puede renovar
        }
      }

      // Obtener los datos de los planes
      List<PlanResponse> plansResponse = await plansController.getPlans();

      // Actualizar el estado con los nuevos datos y cerrar el modal de carga
      setState(() {
        listPlans = plansResponse;
        loadingModal.closeLoadingModal(context);
      });
    } catch (e) {
      log('Error: $e');
      Future.microtask(() => {
            loadingModal.closeLoadingModal(context),
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: texts.normalText(
                    text: e.toString().replaceAll('Exception: ', ''),
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.start,
                    fontSize: 4 * SizeConfig.heightMultiplier,
                    color: ColorsPalette.white),
                backgroundColor: ColorsPalette.redAged,
              ),
            ),
          });
    }
  }

  void showSelectedPlanAndPay(PlanResponse selectedPlan) {
    RegisterProvider registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);
    log('Plan seleccionado: ${selectedPlan.name}');
    registerProvider.setSelectedPlan(selectedPlan);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: ColorsPalette.white,
            title: texts.normalText(
              text: 'Seleccione un método de pago',
              color: ColorsPalette.black,
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
                        image: AssetImage('assets/logo/logo_rectangle.png'),
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
                              'Usted ha seleccionado el plan ${selectedPlan.name}',
                          color: ColorsPalette.black,
                          fontSize: 2 * SizeConfig.heightMultiplier,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 2 * SizeConfig.heightMultiplier,
                        ),
                        texts.normalText(
                          text:
                              'Nota: Una vez realizado el pago, no se aceptan devoluciones.',
                          color: ColorsPalette.black,
                          fontSize: 2 * SizeConfig.heightMultiplier,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
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
                    buttons.standart(
                      text: 'Transferencia',
                      color: ColorsPalette.greyChocolate,
                      width: 15 * SizeConfig.widthMultiplier,
                      onPressed: () {
                        registerProvider.clearTransferImageFile();
                        Navigator.pushNamed(context, '/transfer');
                      },
                    ),
                    SizedBox(
                      height: 2 * SizeConfig.heightMultiplier,
                    ),
                    buttons.standart(
                      text: 'Tarjeta de Crédito',
                      color: ColorsPalette.greyChocolate,
                      width: 15 * SizeConfig.widthMultiplier,
                      onPressed: () {
                        showCommingSoonDialog();
                      },
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  void showCommingSoonDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: ColorsPalette.white,
            title: texts.normalText(
              text: 'Próximamente ...',
              color: ColorsPalette.black,
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
                        image: AssetImage('assets/logo/logo_rectangle.png'),
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
                          color: ColorsPalette.black,
                          fontSize: 2 * SizeConfig.heightMultiplier,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 2 * SizeConfig.heightMultiplier,
                        ),
                        Center(
                          child: buttons.standart(
                            text: 'Aceptar',
                            color: ColorsPalette.greyChocolate,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(backgroundColor: ColorsPalette.greyChocolate),
      body: Stack(children: [
        Container(
          color: ColorsPalette.greyChocolate,
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
                      backgroundColor: ColorsPalette.white,
                      child: Icon(
                        FontAwesomeIcons.boxesStacked,
                        size: 8 * SizeConfig.imageSizeMultiplier,
                        color: ColorsPalette.black,
                      ),
                    ),
                    SizedBox(
                      width: 5 * SizeConfig.widthMultiplier,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        texts.normalText(
                            text: 'Planes',
                            color: ColorsPalette.white,
                            fontSize: 4 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w400),
                        texts.normalText(
                            text: 'Conoce nuestros planes',
                            color: ColorsPalette.white,
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
                        color: ColorsPalette.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(
                                25))), 
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 2 * SizeConfig.heightMultiplier,
                          ),
                          Center(
                            child: texts.normalText(
                                text: 'Hola 👋, selecciona un plan:',
                                color: ColorsPalette.black,
                                fontSize: 2.5 * SizeConfig.heightMultiplier,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 3.5 * SizeConfig.heightMultiplier,
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 1 / 1,
                            ),
                            itemCount: listPlans.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showSelectedPlanAndPay(listPlans[index]);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        ColorsPalette.beige,
                                          ColorsPalette.whiteAlternative,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: [
                                        0.5,
                                        0.5
                                      ], // Marca el punto medio donde los colores cambian
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        2 * SizeConfig.heightMultiplier),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 1 * SizeConfig.heightMultiplier,
                                      ),
                                      Center(
                                        child: texts.normalText(
                                          text: listPlans[index]
                                              .numberOfClasses
                                              .toString(),
                                          color: ColorsPalette.black,
                                          fontSize:
                                              5 * SizeConfig.heightMultiplier,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Center(
                                        child: texts.normalText(
                                          text: 'clases',
                                          color: ColorsPalette.black,
                                          fontSize:
                                              2 * SizeConfig.heightMultiplier,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4 * SizeConfig.heightMultiplier,
                                      ),
                                      Column(
                                        children: [
                                          texts.normalText(
                                            text: listPlans[index].name,
                                            color: ColorsPalette.black,
                                            fontSize: 1.5 *
                                                SizeConfig.heightMultiplier,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          texts.normalText(
                                            text:
                                                '\$ ${listPlans[index].price.toStringAsFixed(2)}/mes',
                                            color: ColorsPalette.black,
                                            fontSize: 2.5 *
                                                SizeConfig.heightMultiplier,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          texts.normalText(
                                            text:
                                                '\$ ${listPlans[index].classPrice.toStringAsFixed(2)}/por clase',
                                            color: ColorsPalette.black,
                                            fontSize: 1.5 *
                                                SizeConfig.heightMultiplier,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
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
