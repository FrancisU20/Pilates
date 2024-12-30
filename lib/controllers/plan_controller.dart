import 'dart:convert';
import 'package:pilates/controllers/common/logger.dart';
import 'package:pilates/models/common/standard_response.dart';
import 'package:pilates/models/plan/plan_model.dart';
import 'package:pilates/services/api_base_service.dart';

class PlanController {
  Future<List<PlanModel>> getPlans() async {
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

      final planListResponse = StandardResponse<List<PlanModel>>.fromJson(
        serverJson,
        (data) => PlanModel.listFromJson(data),
      );

      List<PlanModel> planList = planListResponse.data!;

      return planList;
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<PlanModel> getPlanById(String id) async {
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

      final planResponse = StandardResponse<PlanModel>.fromJson(
        serverJson,
        (data) => PlanModel.fromJson(data),
      );

      PlanModel plan = planResponse.data!;

      return plan;
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
