import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/integrations/whatsapp_launcher.dart';
import 'package:pilates/providers/plan/plan_provider.dart';
import 'package:pilates/providers/user-plan/user_plan_provider.dart';
import 'package:pilates/theme/components/common/app_dialogs.dart';
import 'package:pilates/theme/components/common/app_empty_data.dart';
import 'package:pilates/theme/components/common/app_loading.dart';
import 'package:pilates/theme/components/client/client_app_bar.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_page_header.dart';
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
      Provider.of<UserPlanProvider>(context, listen: false).clearData();
      Provider.of<PlanProvider>(context, listen: false).getPlans(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.white100,
          appBar: const ClientAppBar(backgroundColor: AppColors.brown200),
          body: Container(
            color: AppColors.brown200,
            child: Column(
              children: [
                const CustomPageHeader(
                    icon: FontAwesomeIcons.boxesStacked,
                    title: 'Planes',
                    subtitle: 'Conoce nuestros planes'),
                SizedBox(
                  height: SizeConfig.scaleHeight(2),
                ),
                Consumer<PlanProvider>(
                  builder: (context, planProvider, child) {
                    if (planProvider.plans.isEmpty) {
                      return AppEmptyData(
                          imagePath:
                              'https://curvepilates-bucket.s3.amazonaws.com/app-assets/box/box-empty.png',
                          message:
                              'Lo sentimos, no hay planes disponibles, comunícate con nosotros para más información.',
                          buttonText: 'Contactar',
                          onButtonPressed: () {
                            whatsappServices.whatsappRedirect(
                                message:
                                    'Hola, me gustaría obtener información sobre los planes de Pilates.');
                          },
                          buttonIcon: FontAwesomeIcons.whatsapp);
                    } else {
                      return Expanded(
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
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(
                                                  SizeConfig.scaleHeight(1)),
                                              decoration: BoxDecoration(
                                                color: AppColors.beige100,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(
                                                      SizeConfig.scaleHeight(
                                                          2)),
                                                  topRight: Radius.circular(
                                                      SizeConfig.scaleHeight(
                                                          2)),
                                                ),
                                              ),
                                              width: SizeConfig.scaleWidth(40),
                                              child: Column(
                                                children: [
                                                  Center(
                                                    child: CustomText(
                                                      text: planProvider
                                                          .plans[index]
                                                          .classesCount
                                                          .toString(),
                                                      color: AppColors.black100,
                                                      fontSize:
                                                          SizeConfig.scaleText(
                                                              4.5),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Center(
                                                    child: CustomText(
                                                      text: 'clases',
                                                      color: AppColors.black100,
                                                      fontSize:
                                                          SizeConfig.scaleText(
                                                              2),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                  SizeConfig.scaleHeight(1)),
                                              width: SizeConfig.scaleWidth(40),
                                              decoration: BoxDecoration(
                                                color: AppColors.white200,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(
                                                      SizeConfig.scaleHeight(
                                                          2)),
                                                  bottomRight: Radius.circular(
                                                      SizeConfig.scaleHeight(
                                                          2)),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  CustomText(
                                                    text: planProvider
                                                        .plans[index].name,
                                                    color: AppColors.black100,
                                                    fontSize:
                                                        SizeConfig.scaleText(
                                                            1.6),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  CustomText(
                                                    text:
                                                        '\$ ${planProvider.plans[index].basePrice}/mes',
                                                    color: AppColors.black100,
                                                    fontSize:
                                                        SizeConfig.scaleText(
                                                            2.2),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  CustomText(
                                                    text:
                                                        '\$ ${planProvider.plans[index].pricePerClass}/clase',
                                                    color: AppColors.black100,
                                                    fontSize:
                                                        SizeConfig.scaleText(
                                                            1.6),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
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
