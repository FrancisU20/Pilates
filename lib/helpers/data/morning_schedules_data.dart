import 'package:pilates/utils/paths/images_paths.dart';

class ActivitiesData {
  static List<Map<String, String>> activities = [
    // Cada hora se divide en 3 actividades diferentes
    // Primera Hora
    {
      'id': '1',
      'id_time_range': 'time-range-1',
      'description': 'Yoga al aire libre',
      'time-start': '6:00 am',
      'time-end': '7:00 am',
      'image': imagesPaths.yoga,
    },
    {
      'id': '2',
      'id_time_range': 'time-range-1',
      'description': 'Clase de Pilates',
      'time-start': '6:00 am',
      'time-end': '7:00 am',
      'image': imagesPaths.pilates,
    },
    {
      'id': '3',
      'id_time_range': 'time-range-1',
      'description': 'Rutina de relajación',
      'time-start': '6:00 am',
      'time-end': '7:00 am',
      'image': imagesPaths.relaxation,
    },

    // Segunda Hora
    {
      'id': '4',
      'id_time_range': 'time-range-2',
      'description': 'Clase de Pilates',
      'time-start': '7:00 am',
      'time-end': '8:00 am',
      'image': imagesPaths.pilates,
    },
    {
      'id': '5',
      'id_time_range': 'time-range-2',
      'description': 'Yoga al aire libre',
      'time-start': '7:00 am',
      'time-end': '8:00 am',
      'image': imagesPaths.yoga,
    },
    {
      'id': '6',
      'id_time_range': 'time-range-2',
      'description': 'Rutina de relajación',
      'time-start': '7:00 am',
      'time-end': '8:00 am',
      'image': imagesPaths.relaxation,
    },

    // Tercera Hora
    {
      'id': '7',
      'id_time_range': 'time-range-3',
      'description': 'Rutina de relajación',
      'time-start': '8:00 am',
      'time-end': '9:00 am',
      'image': imagesPaths.relaxation,
    },
    {
      'id': '8',
      'id_time_range': 'time-range-3',
      'description': 'Yoga al aire libre',
      'time-start': '8:00 am',
      'time-end': '9:00 am',
      'image': imagesPaths.yoga,
    },
    {
      'id': '9',
      'id_time_range': 'time-range-3',
      'description': 'Clase de Pilates',
      'time-start': '8:00 am',
      'time-end': '9:00 am',
      'image': imagesPaths.pilates,
    },

    // Cuarta Hora
    {
      'id': '10',
      'id_time_range': 'time-range-4',
      'description': 'Clase de Pilates',
      'time-start': '9:00 am',
      'time-end': '10:00 am',
      'image': imagesPaths.pilates,
    },
    {
      'id': '11',
      'id_time_range': 'time-range-4',
      'description': 'Rutina de relajación',
      'time-start': '9:00 am',
      'time-end': '10:00 am',
      'image': imagesPaths.relaxation,
    },
    {
      'id': '12',
      'id_time_range': 'time-range-4',
      'description': 'Yoga al aire libre',
      'time-start': '9:00 am',
      'time-end': '10:00 am',
      'image': imagesPaths.yoga,
    },

    // Quinta Hora
    {
      'id': '13',
      'id_time_range': 'time-range-5',
      'description': 'Yoga al aire libre',
      'time-start': '10:00 am',
      'time-end': '11:00 am',
      'image': imagesPaths.yoga,
    },
    {
      'id': '14',
      'id_time_range': 'time-range-5',
      'description': 'Clase de Pilates',
      'time-start': '10:00 am',
      'time-end': '11:00 am',
      'image': imagesPaths.pilates,
    },
    {
      'id': '15',
      'id_time_range': 'time-range-5',
      'description': 'Rutina de relajación',
      'time-start': '10:00 am',
      'time-end': '11:00 am',
      'image': imagesPaths.relaxation,
    },

    // Sexta Hora
    {
      'id': '16',
      'id_time_range': 'time-range-6',
      'description': 'Rutina de relajación',
      'time-start': '11:00 am',
      'time-end': '12:00 pm',
      'image': imagesPaths.relaxation,
    },
    {
      'id': '17',
      'id_time_range': 'time-range-6',
      'description': 'Yoga al aire libre',
      'time-start': '11:00 am',
      'time-end': '12:00 pm',
      'image': imagesPaths.yoga,
    },
    {
      'id': '18',
      'id_time_range': 'time-range-6',
      'description': 'Clase de Pilates',
      'time-start': '11:00 am',
      'time-end': '12:00 pm',
      'image': imagesPaths.pilates,
    },
  ];
}
