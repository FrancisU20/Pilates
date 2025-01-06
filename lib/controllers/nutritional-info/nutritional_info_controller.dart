import 'dart:convert';
import 'package:pilates/common/logger.dart';
import 'package:pilates/models/common/standard_response.dart';
import 'package:pilates/models/nutritional-info/nutritional_info_create_model.dart';
import 'package:pilates/models/nutritional-info/nutritional_info_model.dart';
import 'package:pilates/services/api_base_service.dart';

class NutritionalInfoController {
  Future<StandardResponse<NutritionalInfoModel>> createNutritionalInfo(NutritionalInfoCreateModel newNutritionalInfoModel) async {
    try {
      final apiBase = await ApiBaseService.create(contentType: 'json');
      
      String dataJson = jsonEncode(newNutritionalInfoModel.toJson());
      Logger.logSendData(dataJson);

      final response = await apiBase.post('/users-nutritional-sheets', bodyRequest: dataJson);
      final serverJson = json.decode(response.body);

      if (serverJson['statusCode'] != 200 && serverJson['statusCode'] != 201) {
        Logger.logServerError(serverJson);
        throw Exception(serverJson['message']);
      } else {
        Logger.logServerSuccess(serverJson);
      }

      StandardResponse<NutritionalInfoModel> registerResponse = StandardResponse<NutritionalInfoModel>.fromJson(
        serverJson,
        (data) => NutritionalInfoModel.fromJson(data),
      );

      return registerResponse;
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<StandardResponse<NutritionalInfoModel>> getUserNutritionalInfo(String userId) async {
    try {
      final apiBase = await ApiBaseService.create(contentType: 'json');
      final response = await apiBase.get('/users-nutritional-sheets/$userId');
      final serverJson = json.decode(response.body);

      if (serverJson['statusCode'] != 200 && serverJson['statusCode'] != 201) {
        Logger.logServerError(serverJson);
        throw Exception(serverJson['message']);
      } else {
        Logger.logServerSuccess(serverJson);
      }

      StandardResponse<NutritionalInfoModel> registerResponse = StandardResponse<NutritionalInfoModel>.fromJson(
        serverJson,
        (data) => NutritionalInfoModel.fromJson(data),
      );

      return registerResponse;
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
