import 'dart:convert';
import 'package:pilates/common/logger.dart';
import 'package:pilates/models/common/standard_response.dart';
import 'package:pilates/models/user-plan/user_plan_create_model.dart';
import 'package:pilates/models/user-plan/user_plan_model.dart';
import 'package:pilates/services/api_base_service.dart';

class UserPlanController {
  Future<StandardResponse<UserPlanModel>> createUserPlan(
      UserPlanCreateModel newUserPlan) async {
    try {
      final apiBase = await ApiBaseService.create(contentType: 'json');

      String dataJson = jsonEncode(newUserPlan.toJson());
      Logger.logSendData(dataJson);

      final response =
          await apiBase.post('/users-plans', bodyRequest: dataJson);
      final serverJson = json.decode(response.body);

      if (serverJson['statusCode'] != 200 && serverJson['statusCode'] != 201) {
        Logger.logServerError(serverJson);
        throw Exception(serverJson['message']);
      } else {
        Logger.logServerSuccess(serverJson);
      }

      StandardResponse<UserPlanModel> createUserPlanResponse =
          StandardResponse<UserPlanModel>.fromJson(
        serverJson,
        (data) => UserPlanModel.fromJson(data),
      );

      return createUserPlanResponse;
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
