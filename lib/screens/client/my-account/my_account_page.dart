import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/providers/login/login_provider.dart';
import 'package:pilates/providers/user-plan/user_plan_provider.dart';
import 'package:pilates/screens/client/my-account/widgets/classes_summary.dart';
import 'package:pilates/screens/client/my-account/widgets/plan_details.dart';
import 'package:pilates/theme/components/client/client_identification.dart';
import 'package:pilates/theme/components/client/client_nav_bar.dart';
import 'package:pilates/theme/components/client/client_app_bar.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/components/common/app_loading.dart';
import 'package:pilates/theme/widgets/custom_page_header.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';
import 'package:provider/provider.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  MyAccountPageState createState() => MyAccountPageState();
}

class MyAccountPageState extends State<MyAccountPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: AppColors.white100,
            appBar: const ClientAppBar(
                backgroundColor: AppColors.brown200, ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              child: Stack(children: [
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.brown200,
                      ),
                      child: Column(
                        children: [
                          const CustomPageHeader(
                            icon: FontAwesomeIcons.userAstronaut,
                            title: 'Mi Cuenta',
                            subtitle: 'Tu información personal',
                          ),
                          SizedBox(
                            height: SizeConfig.scaleHeight(10),
                          ),
                          Consumer<LoginProvider>(
                            builder: (context, loginProvider, child) {
                              return Consumer<UserPlanProvider>(
                                builder: (context, userPlanProvider, child) {
                                  return Container(
                                      width: SizeConfig.scaleWidth(100),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: SizeConfig.scaleWidth(5),
                                          vertical: SizeConfig.scaleHeight(2)),
                                      decoration: const BoxDecoration(
                                          color: AppColors.white100,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(25))),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: SizeConfig.scaleHeight(16.5),
                                          ),
                                          Center(
                                            child: CustomText(
                                                text:
                                                    'Hola, ${loginProvider.user!.name} 👋',
                                                color: AppColors.black100,
                                                fontSize: SizeConfig.scaleText(2.5),
                                                fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(
                                            height: SizeConfig.scaleHeight(1.5),
                                          ),
                                          CustomText(
                                              text: 'Mi Plan',
                                              color: AppColors.black100,
                                              fontSize: SizeConfig.scaleText(2),
                                              fontWeight: FontWeight.w500,
                                              textAlign: TextAlign.left),
                                          ClassesSummary(
                                            classesCount: userPlanProvider
                                                    .activeUserPlan
                                                    ?.plan
                                                    .classesCount ??
                                                0,
                                            remainingClasses: userPlanProvider
                                                            .activeUserPlan
                                                            ?.plan
                                                            .classesCount !=
                                                        null &&
                                                    userPlanProvider.activeUserPlan
                                                            ?.scheduledClasses !=
                                                        null
                                                ? (userPlanProvider.activeUserPlan!
                                                        .plan.classesCount -
                                                    userPlanProvider.activeUserPlan!
                                                        .scheduledClasses)
                                                : 0,
                                          ),
                                          SizedBox(
                                            height: SizeConfig.scaleHeight(2),
                                          ),
                                          PlanDetails(
                                            planName: userPlanProvider
                                                    .activeUserPlan?.plan.name ??
                                                'No hay plan activo',
                                            planDescription: userPlanProvider
                                                    .activeUserPlan
                                                    ?.plan
                                                    .description ??
                                                'No hay un plan activo',
                                            planPrice: userPlanProvider
                                                    .activeUserPlan?.plan.basePrice ??
                                                '0',
                                            planEndDate: userPlanProvider
                                                        .activeUserPlan?.planEnd !=
                                                    null
                                                ? userPlanProvider.convertDate(
                                                    userPlanProvider
                                                        .activeUserPlan!.planEnd
                                                        .toString()
                                                        .substring(0, 10))
                                                : 'Fecha no disponible',
                                          ),
                                        ],
                                      ));
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Consumer<LoginProvider>(
                  builder: (context, loginProvider, child) {
                    return Consumer<UserPlanProvider>(
                      builder: (context, userPlanProvider, child) {
                        return Positioned(
                            top: SizeConfig.scaleHeight(12),
                            left: SizeConfig.scaleWidth(5),
                            right: SizeConfig.scaleWidth(5),
                            child: SizedBox(
                              width: SizeConfig.scaleWidth(90),
                              child: ClientIdentification(
                                loginProvider: loginProvider,
                                userPlanProvider: userPlanProvider,
                              ),
                            ));
                      },
                    );
                  },
                ),
              ]),
            ),
            bottomNavigationBar: const ClientNavBar(),
          ),
          const AppLoading(),
        ],
      ),
    );
  }
}
