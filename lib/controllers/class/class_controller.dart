import 'dart:convert';
import 'package:pilates/common/logger.dart';
import 'package:pilates/models/common/standard_response.dart';
import 'package:pilates/models/class/class_model.dart';
import 'package:pilates/services/api_base_service.dart';

class ClassController {
  Future<StandardResponse<List<ClassModel>>> getClassList() async {
    try {
      final apiBase = await ApiBaseService.create(contentType: 'json');
      final response = await apiBase.get('/classes');
      final serverJson = json.decode(response.body);

      if (serverJson['statusCode'] != 200 && serverJson['statusCode'] != 201) {
        Logger.logServerError(serverJson);
        throw Exception(serverJson['message']);
      } else {
        Logger.logServerSuccess(serverJson);
      }

      StandardResponse<List<ClassModel>> userClassListResponse = StandardResponse<List<ClassModel>>.fromJson(
        serverJson,
        (data) => ClassModel.listFromJson(data),
      );

      return userClassListResponse;
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
