import 'package:flutter/material.dart';
import 'package:pilates/providers/admin/admin_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/components/common/app_dialogs.dart';
import 'package:pilates/theme/widgets/custom_icon_button.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';

class MonthSelector extends StatelessWidget {
  final AdminProvider adminProvider;

  const MonthSelector({super.key, required this.adminProvider});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
            text: 'Estadísticas, ',
            color: AppColors.brown400,
            fontSize:SizeConfig.scaleText(3),
            fontWeight: FontWeight.w400),
        SizedBox(
          width: SizeConfig.scaleWidth(1),
        ),
        CustomText(
            text: adminProvider.getStringMonth(adminProvider.selectedMonth),
            color: AppColors.brown200,
            fontSize:SizeConfig.scaleText(3),
            fontWeight: FontWeight.w600),
        const Spacer(),
        CustomIconButton(
          icon: Icons.keyboard_arrow_down_rounded,
          iconColor: AppColors.white200,
          onPressed: () {
            AppDialogs.showMonthSelector(context, adminProvider);
          },
          iconSize: 3,
          height: 3,
          radius: 0.8,
          width: 8.5,
          color: AppColors.brown200.withOpacity(0.6),
        ),
      ],
    );
  }
}
