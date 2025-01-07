import 'package:pilates/config/images_paths.dart';

class ActivitiesData {
  static List<Map<String, String>> activities = [
    {
      'description': 'Clase de Pilates',
      'image': imagesPaths.pilates,
    },
    {
      'description': 'Rutina de relajación',
      'image': imagesPaths.relaxation,
    },
    {
      'description': 'Acompañamiento',
      'image': imagesPaths.yoga,
    },
  ];
}
