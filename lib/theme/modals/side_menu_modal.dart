import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/utils/size_config.dart';

class SideMenuModal extends StatelessWidget {
  const SideMenuModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Positioned(
            left: 3 * SizeConfig.widthMultiplier,
            top: 0 * SizeConfig.heightMultiplier,
            width: 65 * SizeConfig.widthMultiplier,
            height: 80 * SizeConfig.heightMultiplier,
            child: Material(
              color: const Color.fromARGB(255, 158, 148, 135),
              elevation: 8.0,
              borderRadius: BorderRadius.circular(70.0),
              child: Align(
                alignment:
                    Alignment.center, // Centra verticalmente el contenido
                child: Padding(
                  padding: EdgeInsets.all(5 * SizeConfig.widthMultiplier),
                  child: ListView(
                    shrinkWrap:
                        true, // Hace que el ListView solo ocupe el espacio necesario
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(
                          FontAwesomeIcons.house,
                          color: Colors.white,
                        ),
                        title: Text('Dashboard'),
                        textColor: Colors.white,
                      ),
                      SizedBox(
                        height: 5 * SizeConfig.heightMultiplier,
                      ),
                      const ListTile(
                        leading: Icon(
                          FontAwesomeIcons.solidIdBadge,
                          color: Colors.white,
                        ),
                        title: Text('Mi Plan'),
                        textColor: Colors.white,
                      ),
                      SizedBox(
                        height: 5 * SizeConfig.heightMultiplier,
                      ),
                      const ListTile(
                        leading: Icon(
                          FontAwesomeIcons.fileLines,
                          color: Colors.white,
                        ),
                        title: Text('Ficha Nutricional'),
                        textColor: Colors.white,
                      ),
                      SizedBox(
                        height: 5 * SizeConfig.heightMultiplier,
                      ),
                      ListTile(
                        leading: const Icon(
                          FontAwesomeIcons.arrowRightFromBracket,
                          color: Colors.white,
                        ),
                        title: const Text('Cerrar Sesión'),
                        textColor: Colors.white,
                        onTap: () => Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false),
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
