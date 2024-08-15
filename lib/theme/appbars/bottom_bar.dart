import 'package:flutter/material.dart';
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
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF262626),
        borderRadius: BorderRadius.circular(50),
      ),
      height: 10 * SizeConfig.heightMultiplier,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: ModalRoute.of(context)?.settings.name == '/dashboard'
                ? const Icon(Icons.home)
                : const Icon(Icons.home_outlined),
            color: ModalRoute.of(context)?.settings.name == '/dashboard'
                ? Colors.white
                : Colors.grey,
            onPressed: () {
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          IconButton(
            icon: ModalRoute.of(context)?.settings.name == '/schedule_date'
                ? const Icon(Icons.calendar_month)
                : const Icon(Icons.calendar_month_outlined),
            color: ModalRoute.of(context)?.settings.name == '/schedule_date'
                ? Colors.white
                : Colors.grey,
            onPressed: () {
              Navigator.pushNamed(context, '/schedule_date');
            },
          ),
          IconButton(
            icon: ModalRoute.of(context)?.settings.name == '/place_location'
                ? const Icon(Icons.map)
                : const Icon(Icons.map_outlined),
            color: ModalRoute.of(context)?.settings.name == '/place_location'
                ? Colors.white
                : Colors.grey,
            onPressed: () {
              Navigator.pushNamed(context, '/place_location');
            },
          ),
          IconButton(
            icon: ModalRoute.of(context)?.settings.name == '/profile'
                ? const Icon(Icons.person_2)
                : const Icon(Icons.person_2_outlined),
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
