import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/providers/client_class_provider.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/widgets/buttons.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';
import 'package:provider/provider.dart';

class SideMenuModal extends StatefulWidget {
  const SideMenuModal({super.key});

  @override
  SideMenuModalState createState() => SideMenuModalState();
}

class SideMenuModalState extends State<SideMenuModal> {
  Texts texts = Texts();
  Buttons buttons = Buttons();

  void showLogOutConfirm() {
    ClientClassProvider clientClassProvider =
        Provider.of<ClientClassProvider>(context, listen: false);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: texts.normalText(
              text: 'Confirmar Cierre de Sesión',
              color: Colors.black,
              fontSize: 2.5 * SizeConfig.heightMultiplier,
              fontWeight: FontWeight.w500,
            ),
            content: SizedBox(
              width: 100 * SizeConfig.widthMultiplier,
              height: 28 * SizeConfig.heightMultiplier,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logotipo de Curves
                  Container(
                    width: 100 * SizeConfig.widthMultiplier,
                    height: 20 * SizeConfig.heightMultiplier,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo/logo_rectangle.jpg'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 60 * SizeConfig.widthMultiplier,
                      height: 8 * SizeConfig.heightMultiplier,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          texts.normalText(
                            text: 'Estás seguro que deseas cerrar sesión?',
                            color: Colors.black,
                            fontSize: 2 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: texts.normalText(
                  text: 'No',
                  color: ColorsPalette.primaryColor,
                  fontSize: 2 * SizeConfig.heightMultiplier,
                  fontWeight: FontWeight.w500,
                ),
              ),
              buttons.standart(
                text: 'Sí',
                color: ColorsPalette.primaryColor,
                width: 4 * SizeConfig.widthMultiplier,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);

                  Future.delayed(const Duration(seconds: 3), () {
                    clientClassProvider.clearAll();
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Positioned(
            left: 3 * SizeConfig.widthMultiplier,
            top: 0 * SizeConfig.heightMultiplier,
            width: 55 * SizeConfig.widthMultiplier,
            height: 70 * SizeConfig.heightMultiplier,
            child: Material(
              color: const Color.fromARGB(255, 158, 148, 135),
              elevation: 8.0,
              borderRadius: BorderRadius.circular(70.0),
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(5 * SizeConfig.widthMultiplier),
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(
                          FontAwesomeIcons.grip,
                          color: Colors.white,
                        ),
                        title: const Text('Dashboard'),
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.pushNamed(context, '/dashboard');
                        },
                      ),
                      SizedBox(
                        height: 2.5 * SizeConfig.heightMultiplier,
                      ),
                      ListTile(
                        leading: const Icon(
                          FontAwesomeIcons.solidPenToSquare,
                          color: Colors.white,
                        ),
                        title: const Text('Agendar Cita'),
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.pushNamed(context, '/schedule_date');
                        },
                      ),
                      SizedBox(
                        height: 2.5 * SizeConfig.heightMultiplier,
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                        ),
                        title: const Text('Citas Agendadas'),
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.pushNamed(context, '/appointments');
                        },
                      ),
                      SizedBox(
                        height: 2.5 * SizeConfig.heightMultiplier,
                      ),
                      ListTile(
                        leading: const Icon(
                          FontAwesomeIcons.solidAddressBook,
                          color: Colors.white,
                        ),
                        title: const Text('Contáctanos'),
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.pushNamed(context, '/contact_us');
                        },
                      ),
                      SizedBox(
                        height: 2.5 * SizeConfig.heightMultiplier,
                      ),
                      ListTile(
                        leading: const Icon(
                          FontAwesomeIcons.solidAddressCard,
                          color: Colors.white,
                        ),
                        title: const Text('Mi Cuenta'),
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                      ),
                      SizedBox(
                        height: 2.5 * SizeConfig.heightMultiplier,
                      ),
                      ListTile(
                        leading: const Icon(
                          FontAwesomeIcons.arrowRightFromBracket,
                          color: Colors.white,
                        ),
                        title: const Text('Cerrar Sesión'),
                        textColor: Colors.white,
                        onTap: () {
                          showLogOutConfirm();
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
