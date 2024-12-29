import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';

class ClientNavBar extends StatelessWidget {
  const ClientNavBar({super.key});

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
            icon: ModalRoute.of(context)?.settings.name == '/dashboard'
                ? const Icon(FontAwesomeIcons.grip)
                : const Icon(FontAwesomeIcons.grip),
            color: ModalRoute.of(context)?.settings.name == '/dashboard'
                ? AppColors.white100
                : AppColors.grey300,
            onPressed: () {
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          IconButton(
            icon: ModalRoute.of(context)?.settings.name == '/schedule_date'
                ? const Icon(FontAwesomeIcons.solidPenToSquare)
                : const Icon(FontAwesomeIcons.penToSquare),
            color: ModalRoute.of(context)?.settings.name == '/schedule_date'
                ? AppColors.white100
                : AppColors.grey300,
            onPressed: () {
              Navigator.pushNamed(context, '/schedule_date');
            },
          ),
          IconButton(
            icon: ModalRoute.of(context)?.settings.name == '/appointments'
                ? const Icon(Icons.calendar_month)
                : const Icon(Icons.calendar_month_outlined),
            color: ModalRoute.of(context)?.settings.name == '/appointments'
                ? AppColors.white100
                : AppColors.grey300,
            onPressed: () {
              Navigator.pushNamed(context, '/appointments');
            },
          ),
          IconButton(
            icon: ModalRoute.of(context)?.settings.name == '/contact_us'
                ? const Icon(FontAwesomeIcons.solidComment)
                : const Icon(FontAwesomeIcons.comment),
            color: ModalRoute.of(context)?.settings.name == '/contact_us'
                ? AppColors.white100
                : AppColors.grey300,
            onPressed: () {
              Navigator.pushNamed(context, '/contact_us');
            },
          ),
          IconButton(
            icon: ModalRoute.of(context)?.settings.name == '/profile'
                ? const Icon(FontAwesomeIcons.solidAddressCard)
                : const Icon(FontAwesomeIcons.addressCard),
            color: ModalRoute.of(context)?.settings.name == '/profile'
                ? AppColors.white100
                : AppColors.grey300,
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
    );
  }
}
