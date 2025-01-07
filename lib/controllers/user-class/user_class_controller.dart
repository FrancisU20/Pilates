import 'dart:convert';

import 'package:pilates/common/logger.dart';
import 'package:pilates/models/common/standard_response.dart';
import 'package:pilates/models/user-class/user_class_create_model.dart';
import 'package:pilates/models/user-class/user_class_model.dart';
import 'package:pilates/services/api_base_service.dart';

class UserClassController {
  Future<StandardResponse<UserClassModel>> createUserClass(
      UserClassCreateModel newUserClassModel) async {
    try {
      final apiBase = await ApiBaseService.create(contentType: 'json');

      String dataJson = jsonEncode(newUserClassModel.toJson());
      Logger.logSendData(dataJson);

      final response =
          await apiBase.post('/users-classes', bodyRequest: dataJson);
      final serverJson = json.decode(response.body);

      if (serverJson['statusCode'] != 200 && serverJson['statusCode'] != 201) {
        Logger.logServerError(serverJson);
        throw Exception(serverJson['message']);
      } else {
        Logger.logServerSuccess(serverJson);
      }

      StandardResponse<UserClassModel> createUserClassResponse =
          StandardResponse<UserClassModel>.fromJson(
        serverJson,
        (data) => UserClassModel.fromJson(data),
      );

      return createUserClassResponse;
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
