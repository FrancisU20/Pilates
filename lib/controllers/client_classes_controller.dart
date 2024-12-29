import 'dart:convert';
import 'dart:developer';

import 'package:pilates/models/response/cancel_class_response.dart';
import 'package:pilates/models/response/client_class_response.dart';
import 'package:pilates/models/response/create_class_response.dart';
import 'package:pilates/models/response/error_response.dart';
import 'package:pilates/models/send/create_class_send.dart';
import 'package:pilates/services/api_base_service.dart';

class ClientClassesController {
  Future<CreateClassResponse> postClass(
      CreateClassSend createClassObject) async {
    try {
      final apiBase =
          await ApiBaseService.create(contentType: 'json');

      String bodyRequest = json.encode(createClassObject.toJson());

      final response = await apiBase.post(
        '/api/client_classes/create',
        bodyRequest: bodyRequest,
      );
      if (response.statusCode == 201) {
        CreateClassResponse createClassResponse =
            createClassResponseFromJson(response.body);
        return createClassResponse;
      } else {
        log('Error del servidor en /api/pilates_classes/create con código: ${response.statusCode}');
        throw Exception(response.body);
      }
    } catch (e) {
      log('$e');
      ErrorResponse errorResponse = ErrorResponse.fromJson(
          json.decode(e.toString().replaceAll('Exception: ', '')));
      throw Exception(errorResponse.message);
    }
  }

  Future<List<ClientClassResponse>> getClassesByClient(
      String userId, isHistory) async {
    try {
      final apiBase =
          await ApiBaseService.create( contentType: 'json');

      DateTime now = DateTime.now();

      String url = isHistory
          ? '/api/client_classes/$userId'
          : '/api/client_classes/$userId/${now.year}-${now.month}-${now.day}';

      final response = await apiBase.get(url);
      if (response.statusCode == 200) {
        List<ClientClassResponse> pilatesClassesResponse =
            clienClassResponseFromJson(response.body);
        log('Se obtuvieron las clases de pilates del cliente correctamente');
        return pilatesClassesResponse;
      } else {
        log('Error del servidor en /api/pilates_classes con código: ${response.statusCode}');
        throw Exception(response.body);
      }
    } catch (e) {
      log('$e');
      ErrorResponse errorResponse = ErrorResponse.fromJson(
          json.decode(e.toString().replaceAll('Exception: ', '')));
      throw Exception(errorResponse.message);
    }
  }

  Future<CancelClassResponse> deleteClass(String classId) async {
    try {
      final apiBase =
          await ApiBaseService.create( contentType: 'json');

      final response =
          await apiBase.delete('/api/client_classes/cancel/$classId');
      if (response.statusCode == 200) {
        CancelClassResponse cancelClassResponse =
            cancelClassResponseFromJson(response.body);
        log('Se ha cancelado la clase correctamente');
        return cancelClassResponse;
      } else {
        log('Error del servidor en /api/pilates_classes con código: ${response.statusCode}');
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
