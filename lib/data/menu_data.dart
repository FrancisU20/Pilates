import 'package:pilates/config/images_paths.dart';

class MenuData {
  static List<Map<String, dynamic>> menuItems = [
    {
      'image': imagesPaths.dashboardItem1,
      'description': 'Agendar Cita',
      'route': '/dashboard/class'
    },
    {
      'image': imagesPaths.dashboardItem2,
      'description': 'Clases Agendadas',
      'route': '/dashboard/user-class'
    },
    {
      'image': imagesPaths.dashboardItem3,
      'description': 'Contáctanos',
      'route': '/dashboard/contact'
    },
    {
      'image': imagesPaths.dashboardItem4,
      'description': 'Mi Cuenta',
      'route': '/dashboard/my-account'
    },
  ];
}
