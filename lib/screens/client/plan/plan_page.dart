import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/integrations/whatsapp_launcher.dart';
import 'package:pilates/providers/plan/plan_provider.dart';
import 'package:pilates/theme/components/common/app_dialogs.dart';
import 'package:pilates/theme/components/common/app_loading.dart';
import 'package:pilates/theme/widgets/custom_app_bar.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_button.dart';
import 'package:pilates/theme/widgets/custom_image_network.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';
import 'package:provider/provider.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  PlanPageState createState() => PlanPageState();
}

class PlanPageState extends State<PlanPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PlanProvider>(context, listen: false).getPlans(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.white100,
          appBar: const CustomAppBar(backgroundColor: AppColors.brown300),
          body: Container(
            color: AppColors.brown300,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.scaleWidth(5),
                    vertical: SizeConfig.scaleHeight(1),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: SizeConfig.scaleImage(8),
                        backgroundColor: AppColors.white100,
                        child: Icon(
                          FontAwesomeIcons.boxesStacked,
                          size: SizeConfig.scaleImage(8),
                          color: AppColors.black100,
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.scaleWidth(5),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              text: 'Planes',
                              color: AppColors.white100,
                              fontSize: SizeConfig.scaleText(4),
                              fontWeight: FontWeight.w400),
                          CustomText(
                              text: 'Conoce nuestros planes',
                              color: AppColors.white100,
                              fontSize: SizeConfig.scaleText(2),
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.left),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.scaleHeight(2),
                ),
                Consumer<PlanProvider>(
                  builder: (context, planProvider, child) {
                    if (planProvider.plans.isEmpty) {
                      return Flexible(
                        child: Container(
                            width: SizeConfig.scaleWidth(100),
                            height: SizeConfig.scaleHeight(78),
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.scaleWidth(5),
                                vertical: SizeConfig.scaleHeight(2)),
                            decoration: const BoxDecoration(
                                color: AppColors.white100,
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
                                    height: SizeConfig.scaleHeight(3),
                                  ),
                                  Center(
                                    child: CustomImageNetwork(
                                      imagePath:
                                          'https://curvepilates-bucket.s3.amazonaws.com/app-assets/box/box-empty.png',
                                      height: SizeConfig.scaleHeight(25),
                                      errorIconSize: SizeConfig.scaleImage(20),
                                      borderRadius: SizeConfig.scaleHeight(100),
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(2),
                                  ),
                                  Center(
                                    child: CustomText(
                                      text:
                                          'Lo sentimos, no hay planes disponibles, comunícate con nosotros para más información.',
                                      color: AppColors.black100,
                                      fontSize: SizeConfig.scaleText(2.5),
                                      fontWeight: FontWeight.w400,
                                      maxLines: 3,
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(2),
                                  ),
                                  Center(
                                    child: CustomButton(
                                      icon: FontAwesomeIcons.whatsapp,
                                      onPressed: () {
                                        whatsappServices.whatsappRedirect(message: 'Hola, me gustaría obtener información sobre los planes de Pilates.');
                                      },
                                      text: 'Contactar',
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      );
                    } else {
                      return Flexible(
                        child: Container(
                            width: SizeConfig.scaleWidth(100),
                            height: SizeConfig.scaleHeight(78),
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.scaleWidth(5),
                                vertical: SizeConfig.scaleHeight(2)),
                            decoration: const BoxDecoration(
                                color: AppColors.white100,
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
                                    height: SizeConfig.scaleHeight(2),
                                  ),
                                  Center(
                                    child: CustomText(
                                        text: 'Hola 👋, selecciona un plan:',
                                        color: AppColors.black100,
                                        fontSize: SizeConfig.scaleText(2.5),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(3.5),
                                  ),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 10.0,
                                      childAspectRatio: 1 / 1,
                                    ),
                                    itemCount: planProvider.plans.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          AppDialogs.showPaymentMethod(
                                              context: context,
                                              selectedPlan:
                                                  planProvider.plans[index]);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                AppColors.beige100,
                                                AppColors.white200,
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops: [
                                                0.5,
                                                0.5
                                              ], // Marca el punto medio donde los colores cambian
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                SizeConfig.scaleHeight(2)),
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height:
                                                    SizeConfig.scaleHeight(1),
                                              ),
                                              Center(
                                                child: CustomText(
                                                  text: planProvider
                                                      .plans[index].classesCount
                                                      .toString(),
                                                  color: AppColors.black100,
                                                  fontSize:
                                                      SizeConfig.scaleText(4.5),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Center(
                                                child: CustomText(
                                                  text: 'clases',
                                                  color: AppColors.black100,
                                                  fontSize:
                                                      SizeConfig.scaleText(2),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    SizeConfig.scaleHeight(1.5),
                                              ),
                                              Column(
                                                children: [
                                                  CustomText(
                                                    text: planProvider
                                                        .plans[index].name,
                                                    color: AppColors.black100,
                                                    fontSize:
                                                        SizeConfig.scaleText(
                                                            2.5),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  CustomText(
                                                    text:
                                                        '\$ ${planProvider.plans[index].basePrice}/mes',
                                                    color: AppColors.black100,
                                                    fontSize:
                                                        SizeConfig.scaleText(
                                                            2.5),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  CustomText(
                                                    text:
                                                        '\$ ${planProvider.plans[index].pricePerClass}/por clase',
                                                    color: AppColors.black100,
                                                    fontSize:
                                                        SizeConfig.scaleText(
                                                            1.5),
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
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        Consumer<PlanProvider>(
          builder: (context, planProvider, child) {
            if (planProvider.isLoading) {
              return const AppLoading();
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
