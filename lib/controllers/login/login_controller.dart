import 'dart:convert';
import 'package:pilates/common/logger.dart';
import 'package:pilates/models/common/standard_response.dart';
import 'package:pilates/models/login/login_model.dart';
import 'package:pilates/models/user/user_model.dart';
import 'package:pilates/services/api_base_service.dart';

class LoginController {
  Future<UserModel> login(String email, String password) async {
    try {
      final apiBase = await ApiBaseService.create(contentType: 'json');
      LoginModel loginModel = LoginModel(email: email, password: password);
      
      String dataJson = jsonEncode(loginModel.toJson());
      Logger.logSendData(dataJson);

      final response = await apiBase.post('/users/login', bodyRequest: dataJson);
      final serverJson = json.decode(response.body);

      if (serverJson['statusCode'] != 200 && serverJson['statusCode'] != 201) {
        Logger.logServerError(serverJson);
        throw Exception(serverJson['message']);
      } else {
        Logger.logServerSuccess(serverJson);
      }

      final userResponse = StandardResponse<UserModel>.fromJson(
        serverJson,
        (data) => UserModel.fromJson(data),
      );
      
      UserModel user = userResponse.data!;

      return user;
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
