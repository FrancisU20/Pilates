import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/utils/size_config.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 2 * SizeConfig.heightMultiplier,
        right: 5 * SizeConfig.widthMultiplier,
        left: 5 * SizeConfig.widthMultiplier,
        top: 2 * SizeConfig.heightMultiplier,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF262626),
        borderRadius: BorderRadius.circular(50),
      ),
      height: 6 * SizeConfig.heightMultiplier,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: ModalRoute.of(context)?.settings.name == '/dashboard'
                ? const Icon(FontAwesomeIcons.grip)
                : const Icon(FontAwesomeIcons.grip),
            color: ModalRoute.of(context)?.settings.name == '/dashboard'
                ? Colors.white
                : Colors.grey,
            onPressed: () {
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          IconButton(
            icon: ModalRoute.of(context)?.settings.name == '/schedule_date'
                ? const Icon(FontAwesomeIcons.solidPenToSquare)
                : const Icon(FontAwesomeIcons.penToSquare),
            color: ModalRoute.of(context)?.settings.name == '/schedule_date'
                ? Colors.white
                : Colors.grey,
            onPressed: () {
              Navigator.pushNamed(context, '/schedule_date');
            },
          ),
          IconButton(
            icon: ModalRoute.of(context)?.settings.name == '/appointments'
                ? const Icon(Icons.calendar_month)
                : const Icon(Icons.calendar_month_outlined),
            color: ModalRoute.of(context)?.settings.name == '/appointments'
                ? Colors.white
                : Colors.grey,
            onPressed: () {
              Navigator.pushNamed(context, '/appointments');
            },
          ),
          IconButton(
            icon: ModalRoute.of(context)?.settings.name == '/contact_us'
                ? const Icon(FontAwesomeIcons.solidAddressBook)
                : const Icon(FontAwesomeIcons.addressBook),
            color: ModalRoute.of(context)?.settings.name == '/contact_us'
                ? Colors.white
                : Colors.grey,
            onPressed: () {
              Navigator.pushNamed(context, '/contact_us');
            },
          ),
          IconButton(
            icon: ModalRoute.of(context)?.settings.name == '/profile'
                ? const Icon(FontAwesomeIcons.solidAddressCard)
                : const Icon(FontAwesomeIcons.addressCard),
            color: ModalRoute.of(context)?.settings.name == '/profile'
                ? Colors.white
                : Colors.grey,
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
    );
  }
}
