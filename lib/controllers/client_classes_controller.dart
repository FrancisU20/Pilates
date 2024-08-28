import 'dart:convert';
import 'dart:developer';

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
          await ApiBaseService.create(isLogging: false, typeHeader: 'json');

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

  Future<List<ClientClassResponse>> getClassesByClient(String userId) async {
    try {
      final apiBase =
          await ApiBaseService.create(isLogging: false, typeHeader: 'json');

      DateTime now = DateTime.now();

      final response = await apiBase.get(
        '/api/client_classes/$userId/${now.year}-${now.month}-${now.day}',
      );
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
}
