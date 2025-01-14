import 'package:flutter/material.dart';
import 'package:pilates/providers/admin/admin_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';

class Indicators extends StatelessWidget {
  final AdminProvider adminProvider;

  const Indicators({super.key, required this.adminProvider});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(SizeConfig.scaleHeight(1)),
              decoration: BoxDecoration(
                color: AppColors.green200,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(SizeConfig.scaleHeight(2)),
                  topRight: Radius.circular(SizeConfig.scaleHeight(2)),
                ),
              ),
              width: SizeConfig.scaleWidth(25),
              child: Column(
                children: [
                  Center(
                    child: CustomText(
                      text: adminProvider.listUserPlans
                          .where((plan) => plan.user.createdAt!.isAfter(adminProvider.selectedMonth))
                          .map((plan) => plan.user.id)
                          .toSet()
                          .length
                          .toString(),
                      color: AppColors.white100,
                      fontSize:SizeConfig.scaleText(2.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.scaleHeight(1)),
              width: SizeConfig.scaleWidth(25),
              decoration: BoxDecoration(
                color: AppColors.white200,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(SizeConfig.scaleHeight(2)),
                  bottomRight: Radius.circular(SizeConfig.scaleHeight(2)),
                ),
              ),
              child: Column(
                children: [
                  CustomText(
                    text: 'Clientes',
                    color: AppColors.black100,
                    fontSize:SizeConfig.scaleText(1.6),
                    fontWeight: FontWeight.w400,
                  ),
                  CustomText(
                    text: 'Nuevos',
                    color: AppColors.black100,
                    fontSize:SizeConfig.scaleText(1.8),
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            )
          ],
        ),
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(SizeConfig.scaleHeight(1)),
              decoration: BoxDecoration(
                color: AppColors.blue200,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(SizeConfig.scaleHeight(2)),
                  topRight: Radius.circular(SizeConfig.scaleHeight(2)),
                ),
              ),
              width: SizeConfig.scaleWidth(25),
              child: Column(
                children: [
                  Center(
                    child: CustomText(
                      text: adminProvider.listUserPlans.length.toString(),
                      color: AppColors.white100,
                      fontSize:SizeConfig.scaleText(2.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.scaleHeight(1)),
              width: SizeConfig.scaleWidth(25),
              decoration: BoxDecoration(
                color: AppColors.white200,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(SizeConfig.scaleHeight(2)),
                  bottomRight: Radius.circular(SizeConfig.scaleHeight(2)),
                ),
              ),
              child: Column(
                children: [
                  CustomText(
                    text: 'Planes',
                    color: AppColors.black100,
                    fontSize:SizeConfig.scaleText(1.6),
                    fontWeight: FontWeight.w400,
                  ),
                  CustomText(
                    text: 'Vendidos',
                    color: AppColors.black100,
                    fontSize:SizeConfig.scaleText(1.8),
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            )
          ],
        ),
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(SizeConfig.scaleHeight(1)),
              decoration: BoxDecoration(
                color: AppColors.orange300,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(SizeConfig.scaleHeight(2)),
                  topRight: Radius.circular(SizeConfig.scaleHeight(2)),
                ),
              ),
              width: SizeConfig.scaleWidth(25),
              child: Column(
                children: [
                  Center(
                    child: CustomText(
                      text: adminProvider.listUserPlans
                          .map((plan) => plan.user.id)
                          .toSet()
                          .length
                          .toString(),
                      color: AppColors.white100,
                      fontSize:SizeConfig.scaleText(2.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.scaleHeight(1)),
              width: SizeConfig.scaleWidth(25),
              decoration: BoxDecoration(
                color: AppColors.white200,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(SizeConfig.scaleHeight(2)),
                  bottomRight: Radius.circular(SizeConfig.scaleHeight(2)),
                ),
              ),
              child: Column(
                children: [
                  CustomText(
                    text: 'Clientes',
                    color: AppColors.black100,
                    fontSize:SizeConfig.scaleText(1.6),
                    fontWeight: FontWeight.w400,
                  ),
                  CustomText(
                    text: 'Totales',
                    color: AppColors.black100,
                    fontSize:SizeConfig.scaleText(1.8),
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
