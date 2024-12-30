import 'package:pilates/config/images_paths.dart';

class MenuData {
  static List<Map<String, String>> menuItems = [
    {
      'image': imagesPaths.dashboardItem1,
      'description': 'Agendar Cita',
      'route': '/schedule_date'
    },
    {
      'image': imagesPaths.dashboardItem2,
      'description': 'Clases Agendadas',
      'route': '/appointments'
    },
    {
      'image': imagesPaths.dashboardItem3,
      'description': 'Contáctanos',
      'route': '/contact_us'
    },
    {
      'image': imagesPaths.dashboardItem4,
      'description': 'Mi Cuenta',
      'route': '/profile'
    },
  ];
}
