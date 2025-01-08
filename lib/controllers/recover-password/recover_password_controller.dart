import 'dart:convert';
import 'package:pilates/common/logger.dart';
import 'package:pilates/models/common/standard_response.dart';
import 'package:pilates/models/recover-password/recover_password_create_model.dart';
import 'package:pilates/models/recover-password/recover_password_model.dart';
import 'package:pilates/models/user/user_model.dart';
import 'package:pilates/models/user/user_password_put_model.dart';
import 'package:pilates/services/api_base_service.dart';

class RecoverPasswordController {
  Future<StandardResponse<RecoverPasswordModel>> createCode(RecoverPasswordCreateModel email) async {
    try {
      final apiBase = await ApiBaseService.create(contentType: 'json');
      
      String dataJson = jsonEncode(email.toJson());
      Logger.logSendData(dataJson);

      final response = await apiBase.post('/recover-password', bodyRequest: dataJson);
      final serverJson = json.decode(response.body);

      if (serverJson['statusCode'] != 200 && serverJson['statusCode'] != 201) {
        Logger.logServerError(serverJson);
        throw Exception(serverJson['message']);
      } else {
        Logger.logServerSuccess(serverJson);
      }

      StandardResponse<RecoverPasswordModel> recoverPasswordResponse = StandardResponse<RecoverPasswordModel>.fromJson(
        serverJson,
        (data) => RecoverPasswordModel.fromJson(data),
      );

      return recoverPasswordResponse;
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<StandardResponse<UserModel>> updatePassword(UserPasswordPutModel newPassword) async {
    try {
      final apiBase = await ApiBaseService.create(contentType: 'json');
      
      String dataJson = jsonEncode(newPassword.toJson());
      Logger.logSendData(dataJson);

      final response = await apiBase.put('/users/update-password', bodyRequest: dataJson);
      final serverJson = json.decode(response.body);

      if (serverJson['statusCode'] != 200 && serverJson['statusCode'] != 201) {
        Logger.logServerError(serverJson);
        throw Exception(serverJson['message']);
      } else {
        Logger.logServerSuccess(serverJson);
      }

      StandardResponse<UserModel> updatePasswordResponse = StandardResponse<UserModel>.fromJson(
        serverJson,
        (data) => UserModel.fromJson(data),
      );

      return updatePasswordResponse;
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
