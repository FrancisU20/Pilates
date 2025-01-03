import 'dart:convert';
import 'package:pilates/common/logger.dart';
import 'package:pilates/models/common/standard_response.dart';
import 'package:pilates/models/user/user_model.dart';
import 'package:pilates/services/api_base_service.dart';

class UserController {
  Future<StandardResponse<UserModel>> register(UserModel newUser) async {
    try {
      final apiBase = await ApiBaseService.create(contentType: 'json');
      
      String dataJson = jsonEncode(newUser.toJson());
      Logger.logSendData(dataJson);

      final response = await apiBase.post('/users', bodyRequest: dataJson);
      final serverJson = json.decode(response.body);

      if (serverJson['statusCode'] != 200 && serverJson['statusCode'] != 201) {
        Logger.logServerError(serverJson);
        throw Exception(serverJson['message']);
      } else {
        Logger.logServerSuccess(serverJson);
      }

      StandardResponse<UserModel> registerResponse = StandardResponse<UserModel>.fromJson(
        serverJson,
        (data) => UserModel.fromJson(data),
      );

      return registerResponse;
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
