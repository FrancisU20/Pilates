import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';

class AdminNavBar extends StatelessWidget {
  const AdminNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(SizeConfig.scaleHeight(2)),
      decoration: BoxDecoration(
        color: AppColors.black100,
        borderRadius: BorderRadius.circular(50),
      ),
      height: SizeConfig.scaleHeight(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: ModalRoute.of(context)?.settings.name == '/dashboard_admin'
                ? const Icon(FontAwesomeIcons.chartPie)
                : const Icon(FontAwesomeIcons.chartPie),
            color: ModalRoute.of(context)?.settings.name == '/dashboard_admin'
                ? AppColors.white100
                : AppColors.brown200,
            onPressed: () {
              
            },
          ),
          IconButton(
            icon: ModalRoute.of(context)?.settings.name == '/clients'
                ? const Icon(FontAwesomeIcons.solidAddressBook)
                : const Icon(FontAwesomeIcons.addressBook),
            color: ModalRoute.of(context)?.settings.name == '/clients'
                ? AppColors.white100
                : AppColors.brown200,
            onPressed: () {
            },
          ),
          IconButton(
            icon: ModalRoute.of(context)?.settings.name == '/clients'
                ? const Icon(FontAwesomeIcons.chartSimple)
                : const Icon(FontAwesomeIcons.chartSimple),
            color: ModalRoute.of(context)?.settings.name == '/clients'
                ? AppColors.white100
                : AppColors.brown200,
            onPressed: () {
            },
          ),
        ],
      ),
    );
  }
}
