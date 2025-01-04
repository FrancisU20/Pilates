import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/components/common/app_dialogs.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/utils/functions.dart';

class AdminMenu extends StatefulWidget {
  const AdminMenu({super.key});

  @override
  AdminMenuState createState() => AdminMenuState();
}

class AdminMenuState extends State<AdminMenu> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Positioned(
            left: SizeConfig.scaleWidth(3),
            top: SizeConfig.scaleHeight(0),
            width: SizeConfig.scaleWidth(55),
            height: SizeConfig.scaleHeight(70),
            child: Material(
              color: AppColors.black100,
              elevation: 8.0,
              borderRadius: BorderRadius.circular(70.0),
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.scaleHeight(2)),
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      ListTile(
                        leading:  Icon(
                          FontAwesomeIcons.chartPie,
                          color: AppColors.white100,
                          size: SizeConfig.scaleHeight(3),
                        ),
                        title: const Text('Dashboard'),
                        textColor: AppColors.white100,
                        onTap: () {
                          smoothTransition(context, '/dashboard_admin');
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.scaleHeight(2.5),
                      ),
                      ListTile(
                        leading:  Icon(
                          FontAwesomeIcons.solidAddressBook,
                          color: AppColors.white100,
                          size: SizeConfig.scaleHeight(3),
                        ),
                        title: const Text('Clientes'),
                        textColor: AppColors.white100,
                        onTap: () {
                          smoothTransition(context, '/clients');
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.scaleHeight(2.5),
                      ),
                      ListTile(
                        leading:  Icon(
                          FontAwesomeIcons.chartSimple,
                          color: AppColors.white100,
                          size: SizeConfig.scaleHeight(3),
                        ),
                        title: const Text('Reportes'),
                        textColor: AppColors.white100,
                        onTap: () {
                          smoothTransition(context, '/clients');
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.scaleHeight(2.5),
                      ),
                      ListTile(
                        leading:  Icon(
                          FontAwesomeIcons.hands,
                          color: AppColors.white100,
                          size: SizeConfig.scaleHeight(3),
                        ),
                        title: const Text('Cerrar Sesión'),
                        textColor: AppColors.white100,
                        onTap: () {
                          AppDialogs.showLogout(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
