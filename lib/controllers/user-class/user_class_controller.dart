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

  //**
  // ? Funcion para obtener las clases
  // ! @param  userId= UUID del usuario
  // ! @param  status= Estado de la clase
  // ! @param  startAt= Fecha de inicio del filtro (Creación de la clase)
  // */
  Future<StandardResponse<List<UserClassModel>>> getUserClass(
      String userId, String status, String startAt) async {
    try {
      final apiBase = await ApiBaseService.create(contentType: 'json');

      final response = await apiBase
          .get('/users-classes?userId=$userId&status=$status&startAt=$startAt');
      final serverJson = json.decode(response.body);

      if (serverJson['statusCode'] != 200 && serverJson['statusCode'] != 201) {
        Logger.logServerError(serverJson);
        throw Exception(serverJson['message']);
      } else {
        Logger.logServerSuccess(serverJson);
      }

      StandardResponse<List<UserClassModel>> getUserClassResponse =
          StandardResponse<List<UserClassModel>>.fromJson(
        serverJson,
        (data) => List<UserClassModel>.from(
            data.map((x) => UserClassModel.fromJson(x))),
      );

      return getUserClassResponse;
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
