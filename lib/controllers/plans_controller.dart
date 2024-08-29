import 'dart:convert';
import 'dart:developer';
import 'package:pilates/models/response/error_response.dart';
import 'package:pilates/models/response/plans_response.dart';
import 'package:pilates/services/api_base_service.dart';

class PlansController {
  Future<List<PlanResponse>> getPlans() async {
    try {
      final apiBase =
          await ApiBaseService.create(isLogging: false, typeHeader: 'json');

      final response = await apiBase.get('/api/plans');
      if (response.statusCode == 200) {
        List<PlanResponse> plansResponse = plansResponseFromJson(response.body);
        log('Se obtuvieron los planes correctamente');
        return plansResponse;
      } else {
        log('Error del servidor en /api/plans con código: ${response.statusCode}');
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
