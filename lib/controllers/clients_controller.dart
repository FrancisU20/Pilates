import 'dart:convert';
import 'dart:developer';

import 'package:pilates/models/response/create_client_response.dart';
import 'package:pilates/models/response/error_response.dart';
import 'package:pilates/models/response/login_response.dart';
import 'package:pilates/models/send/create_client_send.dart';
import 'package:pilates/models/send/login_send.dart';
import 'package:pilates/services/api_base_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  Future<LoginResponse> loginProcess(String email, String password) async {
    try {
      final apiLoggin =
          await ApiBaseService.create(isLogging: true, typeHeader: 'json');
      SharedPreferences prefs = await SharedPreferences.getInstance();

      LoginSend userData = LoginSend(email: email, password: password);

      // Se prepara el objeto para ser enviado
      Map<String, dynamic> dataJson = userData.toJson();
      String dataString = jsonEncode(dataJson);

      log('Data enviada: $dataJson');

      final response =
          await apiLoggin.post('/api/clients/login', bodyRequest: dataString);
      if (response.statusCode == 200) {
        LoginResponse loginResponse =
            LoginResponse.fromJson(json.decode(response.body));
        prefs.setString('token', loginResponse.token);
        log('Login Exitoso');
        log('Token: ${loginResponse.token}');
        return loginResponse;
      } else {
        log('Error del servidor en /api/clients/login con código: ${response.statusCode}');
        throw Exception(response.body);
      }
    } catch (e) {
      log('$e');
      ErrorResponse errorResponse = ErrorResponse.fromJson(
          json.decode(e.toString().replaceAll('Exception: ', '')));
      throw Exception(errorResponse.message);
    }
  }

  Future<CreateClientResponse> postClient(
      CreateClientSend createClientObject) async {
    try {
      final apiBase =
          await ApiBaseService.create(isLogging: false, typeHeader: 'json');

      String bodyRequest = jsonEncode(createClientObject.toJson());

      final response =
          await apiBase.post('/api/clients/create', bodyRequest: bodyRequest);
      if (response.statusCode == 201) {
        CreateClientResponse createClientResponse =
            CreateClientResponse.fromJson(json.decode(response.body));
        return createClientResponse;
      } else {
        log('Error del servidor en /api/clients/create con código: ${response.statusCode}');
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
