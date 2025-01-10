import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pilates/data/menu_data.dart';
import 'package:pilates/integrations/whatsapp_launcher.dart';
import 'package:pilates/middleware/app_middleware.dart';
import 'package:pilates/providers/login/login_provider.dart';
import 'package:pilates/providers/user-plan/user_plan_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/components/client/client_home_bar.dart';
import 'package:pilates/theme/components/client/client_nav_bar.dart';
import 'package:pilates/theme/components/common/app_loading.dart';
import 'package:pilates/theme/routes/page_state_provider.dart';
import 'package:pilates/theme/widgets/custom_button.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  final menuItems = MenuData.menuItems;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<PageStateProvider>(context, listen: false)
          .setActiveRoute('/dashboard');
      await Provider.of<UserPlanProvider>(context, listen: false).getUserPlans(
          context,
          startDate: DateTime.now().subtract(const Duration(days: 30)),
          endDate: DateTime.now().add(const Duration(days: 30)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: AppColors.white100,
            appBar: const ClientHomeBar(),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              child: Container(
                color: AppColors.white100,
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.scaleWidth(5),
                    vertical: SizeConfig.scaleHeight(0.5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Consumer<LoginProvider>(
                      builder: (context, loginProvider, child) {
                        return Row(
                          children: [
                            CustomText(
                                text: 'Hola,',
                                color: AppColors.brown400,
                                fontSize:SizeConfig.scaleText(4),
                                fontWeight: FontWeight.w400),
                            SizedBox(
                              width: SizeConfig.scaleWidth(3),
                            ),
                            CustomText(
                                text: '${loginProvider.user!.name}!',
                                color: AppColors.brown200,
                                fontSize:SizeConfig.scaleText(4),
                                fontWeight: FontWeight.w400),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(0.5),
                    ),
                    Row(
                      children: [
                        CustomText(
                            text: '¿Qué te gustaría hacer hoy?',
                            color: AppColors.brown400,
                            fontSize:SizeConfig.scaleText(2.5),
                            fontWeight: FontWeight.w500),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: SizeConfig.scaleHeight(4),
                        ),
                        CarouselSlider(
                          options: CarouselOptions(
                            height: SizeConfig.scaleHeight(45),
                            enlargeCenterPage: true,
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 1600),
                            viewportFraction: 0.8,
                          ),
                          items: menuItems.map((menuItem) {
                            return Builder(
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  onTap: () async {
                                    await AppMiddleware.updateClientData(
                                        context, menuItem['route']);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: AssetImage(menuItem['image']!),
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            AppColors.black100.withOpacity(0.2),
                                            BlendMode.darken),
                                      ),
                                    ),
                                    child: Center(
                                      child: CustomText(
                                          text: menuItem['description']!,
                                          color: AppColors.white100,
                                          fontSize:SizeConfig.scaleText(2.5),
                                          fontWeight: FontWeight.w500,
                                          textAlign: TextAlign.center),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        Consumer<UserPlanProvider>(
                          builder: (context, userPlanProvider, child) {
                            if (userPlanProvider.activeUserPlan != null) {
                              double barPercent = (userPlanProvider
                                          .activeUserPlan!.plan.classesCount
                                          .toDouble() -
                                      userPlanProvider
                                          .activeUserPlan!.scheduledClasses
                                          .toDouble()) /
                                  userPlanProvider
                                      .activeUserPlan!.plan.classesCount
                                      .toDouble();
                              return SizedBox(
                                height: SizeConfig.scaleHeight(15),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                        text:
                                            '${userPlanProvider.activeUserPlan!.plan.classesCount - userPlanProvider.activeUserPlan!.scheduledClasses} de ${userPlanProvider.activeUserPlan!.plan.classesCount}',
                                        color: AppColors.brown200,
                                        fontSize:SizeConfig.scaleText(2),
                                        fontWeight: FontWeight.w500),
                                    SizedBox(
                                      height: SizeConfig.scaleHeight(1.5),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.scaleWidth(70),
                                      child: LinearProgressIndicator(
                                        value: barPercent,
                                        backgroundColor: AppColors.grey100,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          barPercent <= 0.25
                                              ? AppColors.red300
                                              : AppColors.brown200,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        minHeight: SizeConfig.scaleHeight(1),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.scaleHeight(0.5),
                                    ),
                                    CustomText(
                                        text: 'Clases Disponibles',
                                        color: AppColors.brown200,
                                        fontSize:SizeConfig.scaleText(2),
                                        fontWeight: FontWeight.w500,
                                        textAlign: TextAlign.start),
                                  ],
                                ),
                              );
                            } else if (userPlanProvider.inactiveUserPlan !=
                                null) {
                              return SizedBox(
                                height: SizeConfig.scaleHeight(15),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text:
                                          'Tu plan se encuentra en proceso de activación',
                                      color: AppColors.brown400,
                                      fontSize:SizeConfig.scaleText(2),
                                      fontWeight: FontWeight.w500,
                                      maxLines: 2,
                                    ),
                                    SizedBox(
                                      height: SizeConfig.scaleHeight(1.5),
                                    ),
                                    CustomButton(
                                        onPressed: () {
                                          whatsappServices.whatsappRedirect(
                                              message:
                                                  'Hola, necesito ayuda con la activación de mi plan. Mi número de cédula es ${userPlanProvider.inactiveUserPlan!.user.dniNumber}');
                                        },
                                        text: 'Informar pago',
                                        color: AppColors.brown200,
                                        icon: FontAwesomeIcons.whatsapp),
                                  ],
                                ),
                              );
                            } else {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(5),
                                  ),
                                  GestureDetector(
                                      onTap: () => {
                                            context.go('/dashboard/plans'),
                                          },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                              text: 'Adquiere un plan',
                                              color: AppColors.red300,
                                              fontSize:
                                                  SizeConfig.scaleText(2.5),
                                              fontWeight: FontWeight.w500,
                                              textAlign: TextAlign.center),
                                          SizedBox(
                                            width: SizeConfig.scaleWidth(1.5),
                                          ),
                                          Icon(
                                            FontAwesomeIcons
                                                .arrowUpRightFromSquare,
                                            color: AppColors.red300,
                                            size: SizeConfig.scaleHeight(2),
                                          )
                                        ],
                                      )),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(2.5),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: const ClientNavBar(),
          ),
          const AppLoading(),
        ],
      ),
    );
  }
}
