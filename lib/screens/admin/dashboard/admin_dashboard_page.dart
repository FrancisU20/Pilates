import 'package:flutter/material.dart';
import 'package:pilates/data/menu_data.dart';
import 'package:pilates/models/plan/plan_model.dart';
import 'package:pilates/providers/admin/admin_provider.dart';
import 'package:pilates/screens/admin/dashboard/widgets/indicators.dart';
import 'package:pilates/screens/admin/dashboard/widgets/month_selector.dart';
import 'package:pilates/screens/admin/dashboard/widgets/pie_data.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/components/admin/admin_home_bar.dart';
import 'package:pilates/theme/components/admin/admin_nav_bar.dart';
import 'package:pilates/theme/components/common/app_empty_data.dart';
import 'package:pilates/theme/components/common/app_loading.dart';
import 'package:pilates/theme/components/common/app_plan_details.dart';
import 'package:pilates/theme/routes/page_state_provider.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  AdminDashboardPageState createState() => AdminDashboardPageState();
}

class AdminDashboardPageState extends State<AdminDashboardPage> {
  final menuItems = MenuData.menuItems;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<PageStateProvider>(context, listen: false)
          .setActiveRoute('/admin-dashboard');
      Provider.of<AdminProvider>(context, listen: false).getMonths();
      await Provider.of<AdminProvider>(context, listen: false).getUsersPlans(context);
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
            appBar: const AdminHomeBar(),
            body: Container(
              color: AppColors.white100,
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.scaleWidth(5),
                  vertical: SizeConfig.scaleHeight(0.5)),
              child: Consumer<AdminProvider>(
                builder: (context, adminProvider, child) {
                  if (adminProvider.listUserPlans.isEmpty) {
                    return Column(
                      children: [
                        MonthSelector(adminProvider: adminProvider),
                        AppEmptyData(
                            imagePath:
                                'https://curvepilates-bucket.s3.amazonaws.com/app-assets/box/box-empty.png',
                            message:
                                'No se ha encontrado datos para el mes de ${adminProvider.getStringMonth(adminProvider.selectedMonth)}'),
                      ],
                    );
                  } else {
                    PlanModel mostUsedPlan = adminProvider.getMostUsedPlan();
                    return ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MonthSelector(adminProvider: adminProvider),
                            SizedBox(
                              height: SizeConfig.scaleHeight(0.5),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.white200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: SizeConfig.scaleWidth(90),
                              height: SizeConfig.scaleHeight(40),
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.scaleWidth(5),
                                  vertical: SizeConfig.scaleHeight(2)),
                              child: PieData(
                                adminProvider: adminProvider,
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.scaleHeight(2),
                            ),
                            Center(
                              child: CustomText(
                                  text: 'Métricas mensuales ',
                                  color: AppColors.black100,
                                  fontSize:SizeConfig.scaleText(2),
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: SizeConfig.scaleHeight(2),
                            ),
                            Indicators(adminProvider: adminProvider),
                            SizedBox(
                              height: SizeConfig.scaleHeight(2),
                            ),
                            Center(
                              child: CustomText(
                                text: 'Plan más usado',
                                color: AppColors.black100,
                                fontSize:SizeConfig.scaleText(2),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.scaleHeight(1),
                            ),
                            AppPlanDetails(
                              planName: mostUsedPlan.name,
                              planDescription: mostUsedPlan.description,
                              planPrice: mostUsedPlan.basePrice.toString(),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
            bottomNavigationBar: const AdminNavBar(),
          ),
          const AppLoading(),
        ],
      ),
    );
  }
}
