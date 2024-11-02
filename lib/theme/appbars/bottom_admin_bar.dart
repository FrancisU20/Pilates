import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/utils/size_config.dart';

class BottomAdminBar extends StatelessWidget {
  const BottomAdminBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2 * SizeConfig.heightMultiplier),
      decoration: BoxDecoration(
        color: ColorsPalette.black,
        borderRadius: BorderRadius.circular(50),
      ),
      height: 10 * SizeConfig.heightMultiplier,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: ModalRoute.of(context)?.settings.name == '/dashboard_admin'
                ? const Icon(FontAwesomeIcons.chartPie)
                : const Icon(FontAwesomeIcons.chartPie),
            color: ModalRoute.of(context)?.settings.name == '/dashboard_admin'
                ? ColorsPalette.white
                : ColorsPalette.greyAged,
            onPressed: () {
              Navigator.pushNamed(context, '/dashboard_admin');
            },
          ),
          IconButton(
            icon: ModalRoute.of(context)?.settings.name == '/clients'
                ? const Icon(FontAwesomeIcons.solidAddressBook)
                : const Icon(FontAwesomeIcons.addressBook),
            color: ModalRoute.of(context)?.settings.name == '/clients'
                ? ColorsPalette.white
                : ColorsPalette.greyAged,
            onPressed: () {
              Navigator.pushNamed(context, '/clients');
            },
          ),
          IconButton(
            icon: ModalRoute.of(context)?.settings.name == '/clients'
                ? const Icon(FontAwesomeIcons.chartSimple)
                : const Icon(FontAwesomeIcons.chartSimple),
            color: ModalRoute.of(context)?.settings.name == '/clients'
                ? ColorsPalette.white
                : ColorsPalette.greyAged,
            onPressed: () {
              Navigator.pushNamed(context, '/clients');
            },
          ),
        ],
      ),
    );
  }
}
