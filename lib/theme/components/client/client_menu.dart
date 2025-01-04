import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/components/common/app_dialogs.dart';
import 'package:pilates/theme/utils/custom_navigator.dart';

class ClientMenu extends StatefulWidget {
  const ClientMenu({super.key});

  @override
  ClientMenuState createState() => ClientMenuState();
}

class ClientMenuState extends State<ClientMenu> {

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
                          FontAwesomeIcons.grip,
                          color: AppColors.white100,
                          size: SizeConfig.scaleHeight(3),
                        ),
                        title: const Text('Dashboard'),
                        textColor: AppColors.white100,
                        onTap: () {
                          customNavigator(context, '/dashboard');
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.scaleHeight(2.5),
                      ),
                      ListTile(
                        leading:  Icon(
                          FontAwesomeIcons.calendarDays,
                          color: AppColors.white100,
                          size: SizeConfig.scaleHeight(3),
                        ),
                        title: const Text('Agendar Cita'),
                        textColor: AppColors.white100,
                        onTap: () {
                          customNavigator(context, '/schedule_date');
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.scaleHeight(2.5),
                      ),
                      ListTile(
                        leading:  Icon(
                          FontAwesomeIcons.solidCalendarCheck,
                          color: AppColors.white100,
                          size: SizeConfig.scaleHeight(3),
                        ),
                        title: const Text('Citas Agendadas'),
                        textColor: AppColors.white100,
                        onTap: () {
                          customNavigator(context, '/appointments');
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.scaleHeight(2.5),
                      ),
                      ListTile(
                        leading:  Icon(
                          FontAwesomeIcons.solidComment,
                          color: AppColors.white100,
                          size: SizeConfig.scaleHeight(3),
                        ),
                        title: const Text('Contáctanos'),
                        textColor: AppColors.white100,
                        onTap: () {
                          customNavigator(context, '/contact_us');
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.scaleHeight(2.5),
                      ),
                      ListTile(
                        leading:  Icon(
                          FontAwesomeIcons.solidAddressCard,
                          color: AppColors.white100,
                          size: SizeConfig.scaleHeight(3),
                        ),
                        title: const Text('Mi Cuenta'),
                        textColor: AppColors.white100,
                        onTap: () {
                          customNavigator(context, '/profile');
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
