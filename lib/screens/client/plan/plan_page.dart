import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/controllers/plans_controller.dart';
import 'package:pilates/models/plans/plan_response.dart';
import 'package:pilates/providers/register_provider.dart';
import 'package:pilates/theme/appbars/custom_appbar.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/common/dialogs.dart';
import 'package:pilates/theme/modals/loading_modal.dart';
import 'package:pilates/theme/widgets/buttons.dart';
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
  Buttons buttons = Buttons();
  List<PlanResponse> plansList = [];

  //Controladores
  PlanController planController = PlanController();

  // Modals
  final LoadingModal loadingModal = LoadingModal();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPlans();
    });
  }

  void getPlans() async {
    try {
      RegisterProvider registerProvider =
          Provider.of<RegisterProvider>(context, listen: false);
      // Mostrar el modal de carga
      Future.microtask(() => {loadingModal.showLoadingModal(context)});

      // Verificar si el cliente puede renovar su plan
      if (registerProvider.dni == null) {
        
      }

      // Obtener los datos de los planes
      List<PlanResponse> plansResponse = await planController.getPlans();

      // Actualizar el estado con los nuevos datos y cerrar el modal de carga
      setState(() {
        plansList = plansResponse;
        loadingModal.closeLoadingModal(context);
      });
    } catch (e) {
      Future.microtask(() => {
            loadingModal.closeLoadingModal(context),
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: texts.normalText(
                    text: e.toString().replaceAll('Exception: ', ''),
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.start,
                    fontSize: 2 * SizeConfig.heightMultiplier,
                    color: ColorsPalette.white),
                backgroundColor: ColorsPalette.redAged,
              ),
            ),
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsPalette.white,
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
                            topRight: Radius.circular(25))),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: const ClampingScrollPhysics(),
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
                            itemCount: plansList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showPaymentMethodDialog(context: context, selectedPlan: plansList[index]);
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
                                          text: plansList[index]
                                              .classesCount
                                              .toString(),
                                          color: ColorsPalette.black,
                                          fontSize:
                                              4.5 * SizeConfig.heightMultiplier,
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
                                        height: 1.5 * SizeConfig.heightMultiplier,
                                      ),
                                      Column(
                                        children: [
                                          texts.normalText(
                                            text: plansList[index].name,
                                            color: ColorsPalette.black,
                                            fontSize: 1.5 *
                                                SizeConfig.heightMultiplier,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          texts.normalText(
                                            text:
                                                '\$ ${plansList[index].basePrice}/mes',
                                            color: ColorsPalette.black,
                                            fontSize: 2.5 *
                                                SizeConfig.heightMultiplier,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          texts.normalText(
                                            text:
                                                '\$ ${plansList[index].pricePerClass}/por clase',
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
