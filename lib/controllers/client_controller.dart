import 'dart:convert';
import 'dart:developer';

import 'package:pilates/models/response/create_client_response.dart';
import 'package:pilates/models/response/error_response.dart';
import 'package:pilates/models/response/update_status_response.dart';
import 'package:pilates/models/send/create_client_send.dart';
import 'package:pilates/models/send/update_status_send.dart';
import 'package:pilates/services/api_base_service.dart';

class ClientController {
  Future<CreateClientResponse> postClient(
      CreateClientSend createClientObject) async {
    try {
      final apiBase =
          await ApiBaseService.create( contentType: 'json');

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

  Future<UpdateStatusResponse> updateStatusClient(
      UpdateStatusSend updateStatusSend, String dni) async {
    try {
      final apiBase =
          await ApiBaseService.create( contentType: 'json');

      String bodyRequest = jsonEncode(updateStatusSend);

      final response =
          await apiBase.post('/api/clients/update-status/$dni', bodyRequest: bodyRequest);
      if (response.statusCode == 200) {
        UpdateStatusResponse updateStatusResponse =
            UpdateStatusResponse.fromJson(json.decode(response.body));
        return updateStatusResponse;
      } else {
        log('Error del servidor en /api/clients/update-status con código: ${response.statusCode}');
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
