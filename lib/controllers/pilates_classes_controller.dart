import 'dart:convert';
import 'dart:developer';

import 'package:pilates/models/response/error_response.dart';
import 'package:pilates/models/response/pilates_classes_response.dart';
import 'package:pilates/services/api_base_service.dart';

class PilatesClassesController {
  Future<List<PilatesClassesResponse>> getSchedules(bool? isMonth) async {
    try {
      final apiBase =
          await ApiBaseService.create(isLogging: false, typeHeader: 'json');

      final response = await apiBase.get(
        '/api/pilates_classes?fullMonth=$isMonth',
      );
      if (response.statusCode == 200) {
        List<PilatesClassesResponse> pilatesClassesResponse =
            pilatesClassesResponseFromJson(response.body);
        log('Se obtuvieron las clases de pilates correctamente');
        return pilatesClassesResponse;
      } else {
        log('Error del servidor en /api/pilates_classes con código: ${response.statusCode}');
        throw Exception(response.body);
      }
    } catch (e) {
      log('$e');
      ErrorResponse errorResponse = ErrorResponse.fromJson(
          json.decode(e.toString().replaceAll('Exception: ', '')));
      throw Exception(errorResponse.message);
    }
  }
}
