import 'package:pilates/config/images_paths.dart';

class ActivitiesData {
  static List<Map<String, String>> activities = [
    {
      'description': 'Clase de Pilates',
      'image': imagesPaths.pilates,
    },
    {
      'description': 'Eventos',
      'image': imagesPaths.relaxation,
    },
    {
      'description': 'Acompañamiento',
      'image': imagesPaths.yoga,
    },
  ];
}
