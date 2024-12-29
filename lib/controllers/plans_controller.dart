import 'dart:convert';
import 'package:pilates/controllers/common/logger.dart';
import 'package:pilates/models/common/standard_response.dart';
import 'package:pilates/models/plans/plan_response.dart';
import 'package:pilates/services/api_base_service.dart';

class PlanController {
  Future<List<PlanResponse>> getPlans() async {
    try {
      final apiBase = await ApiBaseService.create(contentType: 'json');

      final response = await apiBase.get('/plans');
      final serverJson = json.decode(response.body);

      if (serverJson['statusCode'] != 200 && serverJson['statusCode'] != 201) {
        Logger.logServerError(serverJson);
        throw Exception(serverJson['message']);
      } else {
        Logger.logServerSuccess(serverJson);
      }

      final planListResponse = StandardResponse<List<PlanResponse>>.fromJson(
        serverJson,
        (data) => PlanResponse.listFromJson(data),
      );

      List<PlanResponse> planList = planListResponse.data!;

      return planList;
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<PlanResponse> getPlanById(String id) async {
    try {
      final apiBase = await ApiBaseService.create(contentType: 'json');

      final response = await apiBase.get('/plans/$id');
      final serverJson = json.decode(response.body);

      if (serverJson['statusCode'] != 200 && serverJson['statusCode'] != 201) {
        Logger.logServerError(serverJson);
        throw Exception(serverJson['message']);
      } else {
        Logger.logServerSuccess(serverJson);
      }

      final planResponse = StandardResponse<PlanResponse>.fromJson(
        serverJson,
        (data) => PlanResponse.fromJson(data),
      );

      PlanResponse plan = planResponse.data!;

      return plan;
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
