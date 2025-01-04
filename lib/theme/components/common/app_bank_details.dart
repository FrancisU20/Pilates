import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_snack_bar.dart';
import 'package:pilates/config/size_config.dart';

class AppBankDetails extends StatelessWidget {
  const AppBankDetails({super.key});

  void _copyToClipboard(BuildContext context, String text, String message) {
    Clipboard.setData(ClipboardData(text: text));
    CustomSnackBar.show(context, message, SnackBarType.informative);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.scaleWidth(5),
        vertical: SizeConfig.scaleHeight(2),
      ),
      decoration: BoxDecoration(
        color: AppColors.green200,
        borderRadius: BorderRadius.circular(15),
      ),
      width: SizeConfig.scaleWidth(100),
      child: Column(
        children: [
          CustomText(
            text: 'Datos de la cuenta:',
            color: AppColors.white100,
            fontSize: SizeConfig.scaleText(2),
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: SizeConfig.scaleHeight(1.5)),
          Column(
            children: [
              _buildDetailRow(
                label: 'Banco:',
                value: 'Produbanco Cuenta de Corriente',
              ),
              SizedBox(height: SizeConfig.scaleHeight(0.5)),
              _buildDetailRowWithCopy(
                context: context,
                label: 'Cuenta:',
                value: '02005333063',
                copyMessage: 'Cuenta copiada al portapapeles',
              ),
              SizedBox(height: SizeConfig.scaleHeight(0.5)),
              _buildDetailRow(
                label: 'Razón Social:',
                value: 'Curve Experience S.A.S.',
              ),
              SizedBox(height: SizeConfig.scaleHeight(0.5)),
              _buildDetailRowWithCopy(
                context: context,
                label: 'Identificación:',
                value: '1091798469001',
                copyMessage: 'RUC copiado al portapapeles',
              ),
              SizedBox(height: SizeConfig.scaleHeight(0.5)),
              _buildDetailRow(
                label: 'Teléfono:',
                value: '0958983470',
              ),
              SizedBox(height: SizeConfig.scaleHeight(0.5)),
              _buildDetailRow(
                label: 'Email:',
                value: 'curvexperiencegomlop@gmail.com',
              ),
            ],
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
          color: AppColors.white200,
          fontSize: SizeConfig.scaleText(1.5),
          fontWeight: FontWeight.w600,
        ),
        SizedBox(width: SizeConfig.scaleWidth(2)),
        CustomText(
          text: value,
          color: AppColors.white200,
          fontSize: SizeConfig.scaleText(1.5),
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }

  Widget _buildDetailRowWithCopy({
    required BuildContext context,
    required String label,
    required String value,
    required String copyMessage,
  }) {
    return Row(
      children: [
        CustomText(
          text: label,
          color: AppColors.white200,
          fontSize: SizeConfig.scaleText(1.5),
          fontWeight: FontWeight.w600,
        ),
        SizedBox(width: SizeConfig.scaleWidth(2)),
        GestureDetector(
          onTap: () => _copyToClipboard(context, value, copyMessage),
          child: CustomText(
            text: value,
            color: AppColors.white200,
            fontSize: SizeConfig.scaleText(1.5),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
