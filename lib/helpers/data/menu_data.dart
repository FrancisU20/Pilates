import 'package:pilates/utils/paths/images.dart';

class MenuData {
  static List<Map<String, String>> activities = [
    {
      'image': images.dashboardItem1,
      'description': 'Agendar Cita',
      'route': '/schedule_date'
    },
    {
      'image': images.dashboardItem2,
      'description': 'Clases Agendadas',
      'route': '/appointments'
    },
    {
      'image': images.dashboardItem3,
      'description': 'Cómo llegar?',
      'route': '/place_location'
    },
    {
      'image': images.dashboardItem4,
      'description': 'Contáctanos',
      'route': '/contact_us'
    },
  ];
}
