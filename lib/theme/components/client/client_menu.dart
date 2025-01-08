import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/components/common/app_dialogs.dart';

class ClientMenu extends StatefulWidget {
  const ClientMenu({super.key});

  @override
  ClientMenuState createState() => ClientMenuState();
}

class ClientMenuState extends State<ClientMenu> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Material(
          color: AppColors.black100,
          elevation: 8.0,
          borderRadius: BorderRadius.circular(70.0),
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.scaleHeight(2)),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: SizeConfig.scaleWidth(17),
              ),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.clipboardList,
                      color: AppColors.white100,
                      size: SizeConfig.scaleHeight(3),
                    ),
                    onTap: () {
                      context.pop();
                      context.go('/dashboard/nutritional-info');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.solidAddressCard,
                      color: AppColors.white100,
                      size: SizeConfig.scaleHeight(3),
                    ),
                    onTap: () {
                      context.pop();
                      context.go('/dashboard/digital-identification');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.rightToBracket,
                      color: AppColors.white100,
                      size: SizeConfig.scaleHeight(3),
                    ),
                    onTap: () {
                      context.pop();
                      AppDialogs.showLogout(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
