import 'package:flutter/material.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/providers/user-plan/user_plan_provider.dart';

class PlanDetails extends StatelessWidget {
  final UserPlanProvider userPlanProvider;
  final DateTime planStart;
  final DateTime planExpiration;

  const PlanDetails({
    super.key,
    required this.userPlanProvider,
    required this.planStart,
    required this.planExpiration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.scaleWidth(5),
        vertical: SizeConfig.scaleHeight(2),
      ),
      decoration: BoxDecoration(
        color: AppColors.beige100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          CustomText(
            text: 'Datos del plan contratado:',
            color: AppColors.black100,
            fontSize: SizeConfig.scaleText(2),
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: SizeConfig.scaleHeight(1.5)),
          _buildDetailRow(
            label: 'Plan:',
            value:
                '${userPlanProvider.selectedPlan!.name} - ${userPlanProvider.selectedPlan!.description}',
          ),
          SizedBox(height: SizeConfig.scaleHeight(0.5)),
          _buildDetailRow(
            label: 'Vigencia desde:',
            value: userPlanProvider.convertDate(planStart.toString().substring(0, 10)),
          ),
          SizedBox(height: SizeConfig.scaleHeight(0.5)),
          _buildDetailRow(
            label: 'Vigencia hasta:',
            value: userPlanProvider.convertDate(planExpiration.toString().substring(0, 10)),
          ),
          SizedBox(height: SizeConfig.scaleHeight(0.5)),
          _buildDetailRow(
            label: 'Precio:',
            value: '\$ ${userPlanProvider.selectedPlan!.basePrice}',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({required String label, required String value}) {
    return Row(
      children: [
        CustomText(
          text: label,
          color: AppColors.black100,
          fontSize: SizeConfig.scaleText(1.5),
          fontWeight: FontWeight.w600,
        ),
        SizedBox(width: SizeConfig.scaleWidth(2)),
        CustomText(
          text: value,
          color: AppColors.black100,
          fontSize: SizeConfig.scaleText(1.5),
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
