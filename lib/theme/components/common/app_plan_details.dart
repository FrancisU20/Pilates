import 'package:flutter/material.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_text.dart';

class AppPlanDetails extends StatelessWidget {
  final String? planName;
  final String? planDescription;
  final String? planPrice;
  final String? planEndDate;

  const AppPlanDetails({
    super.key,
    this.planName,
    this.planDescription,
    this.planPrice,
    this.planEndDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.scaleWidth(3),
        vertical: SizeConfig.scaleHeight(1.5),
      ),
      decoration: BoxDecoration(
        color: AppColors.white200,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            'Plan Contratado: ',
            planName ?? 'No hay plan activo',
          ),
          _buildDetailRow(
            'Descripción: ',
            planDescription ?? 'No hay un plan activo',
          ),
          _buildDetailRow(
            'Precio: ',
            '\$ ${planPrice ?? 0}',
          ),
          if (planEndDate != null) ...[
            _buildDetailRow(
              'Vigencia: ',
              planEndDate ?? 'Fecha no disponible',
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        CustomText(
          text: label,
          color: AppColors.black100,
          fontSize:SizeConfig.scaleText(1.5),
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          width: SizeConfig.scaleWidth(1),
        ),
        CustomText(
          text: value,
          color: AppColors.black100,
          fontSize:SizeConfig.scaleText(1.5),
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
