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

  Future<StandardResponse<List<UserPlanModel>>> getUserPlans({
    String? userId,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final apiBase = await ApiBaseService.create(contentType: 'json');

      // Inicializar una lista de parámetros
      final queryParameters = <String, String>{};

      // Agregar los parámetros opcionales solo si no son null
      if (userId != null && userId.isNotEmpty) {
        queryParameters['userId'] = userId;
      }
      if (status != null && status.isNotEmpty) {
        queryParameters['status'] = status;
      }
      if (startDate != null) {
        queryParameters['startDate'] =
            startDate.toIso8601String().substring(0, 10);
      }
      if (endDate != null) {
        queryParameters['endDate'] = endDate.toIso8601String().substring(0, 10);
      }

      // Construir la URL
      final uri = Uri(
        path: '/users-plans',
        queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      );

      // Realizar la solicitud HTTP
      final response = await apiBase.get(uri.toString());
      final serverJson = json.decode(response.body);

      // Manejar errores del servidor
      if (serverJson['statusCode'] != 200 && serverJson['statusCode'] != 201) {
        Logger.logServerError(serverJson);
        throw Exception(serverJson['message']);
      } else {
        Logger.logServerSuccess(serverJson);
      }

      // Mapear la respuesta JSON a la lista de UserPlanModel
      StandardResponse<List<UserPlanModel>> userPlanListResponse =
          StandardResponse<List<UserPlanModel>>.fromJson(
        serverJson,
        (data) => List<UserPlanModel>.from(
            data.map((x) => UserPlanModel.fromJson(x))),
      );

      return userPlanListResponse;
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
