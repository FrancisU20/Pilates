import 'dart:convert';
import 'dart:developer';
import 'package:pilates/models/response/all_client_class_response.dart';
import 'package:pilates/models/response/available_client_class_response.dart';
import 'package:pilates/models/response/client_plans_response.dart';
import 'package:pilates/models/response/create_client_plan_response.dart';
import 'package:pilates/models/response/error_response.dart';
import 'package:pilates/models/response/most_popular_plan_response.dart';
import 'package:pilates/models/response/plans_response.dart';
import 'package:pilates/models/send/create_client_plan_send.dart';
import 'package:pilates/services/api_base_service.dart';

class ClientPlansController {
  Future<List<ClientPlansResponse>> getPlansByClient(
      String userId, isInactive) async {
    try {
      final apiBase =
          await ApiBaseService.create( contentType: 'json');

      String url = isInactive
          ? '/api/client_plans/$userId?status=inactive'
          : '/api/client_plans/$userId';

      final response = await apiBase.get(url);
      if (response.statusCode == 200) {
        List<ClientPlansResponse> clientPlansResponse =
            clientPlansResponseFromJson(response.body);
        log('Se obtuvieron los planes del cliente correctamente');
        return clientPlansResponse;
      } else {
        log('Error del servidor en /api/client_plans con código: ${response.statusCode}');
        throw Exception(response.body);
      }
    } catch (e) {
      log('$e');
      ErrorResponse errorResponse = ErrorResponse.fromJson(
          json.decode(e.toString().replaceAll('Exception: ', '')));
      throw Exception(errorResponse.message);
    }
  }

  Future<AvailableClientClassResponse> getAvailableClassesByClient(
      String userId, String planId) async {
    try {
      final apiBase =
          await ApiBaseService.create( contentType: 'json');

      final response = await apiBase
          .get('/api/client_plans/available-classes/$userId/$planId');
      if (response.statusCode == 200) {
        AvailableClientClassResponse availableClientClassResponse =
            availableClientClassResponseFromJson(response.body);
        log('Se obtuvieron las clases disponibles del cliente correctamente');
        return availableClientClassResponse;
      } else {
        log('Error del servidor en /api/client_plans con código: ${response.statusCode}');
        throw Exception(response.body);
      }
    } catch (e) {
      log('$e');
      ErrorResponse errorResponse = ErrorResponse.fromJson(
          json.decode(e.toString().replaceAll('Exception: ', '')));
      throw Exception(errorResponse.message);
    }
  }

  Future<CreateClientPlanResponse> createClientPlan(
      CreateClientPlanSend clientPlanObject) async {
    try {
      final apiBase =
          await ApiBaseService.create( contentType: 'json');

      String bodyRequest = json.encode(clientPlanObject.toJson());

      final response = await apiBase.post('/api/client_plans/create',
          bodyRequest: bodyRequest);
      if (response.statusCode == 201) {
        CreateClientPlanResponse createClientPlanResponse =
            createClientPlanResponseFromJson(response.body);
        log('Se creó el plan del cliente correctamente');
        return createClientPlanResponse;
      } else {
        log('Error del servidor en /api/client_plans con código: ${response.statusCode}');
        throw Exception(response.body);
      }
    } catch (e) {
      log('$e');
      ErrorResponse errorResponse = ErrorResponse.fromJson(
          json.decode(e.toString().replaceAll('Exception: ', '')));
      throw Exception(errorResponse.message);
    }
  }

  Future<List<AllClientsPlansResponse>> getAllClientsPlans() async {
    try {
      final apiBase =
          await ApiBaseService.create( contentType: 'json');

      final response = await apiBase.get('/api/client_plans/all');
      if (response.statusCode == 200) {
        List<AllClientsPlansResponse> allClientsPlansResponse =
            allClientsPlansResponseFromJson(response.body);
        log('Se obtuvieron los planes de los clientes correctamente');
        return allClientsPlansResponse;
      } else {
        log('Error del servidor en /api/client_plans con código: ${response.statusCode}');
        throw Exception(response.body);
      }
    } catch (e) {
      log('$e');
      ErrorResponse errorResponse = ErrorResponse.fromJson(
          json.decode(e.toString().replaceAll('Exception: ', '')));
      throw Exception(errorResponse.message);
    }
  }

  Future<PlanInfo> getPlanById(String planId) async {
    try {
      final apiBase =
          await ApiBaseService.create( contentType: 'json');

      final response = await apiBase.get('/api/plans/$planId');
      if (response.statusCode == 200) {
        PlansResponse planResponse = plansResponseFromJson(response.body);
        log('Se obtuvo el plan correctamente');
        return planResponse.data[0];
      } else {
        log('Error del servidor en /api/plans con código: ${response.statusCode}');
        throw Exception(response.body);
      }
    } catch (e) {
      log('$e');
      ErrorResponse errorResponse = ErrorResponse.fromJson(
          json.decode(e.toString().replaceAll('Exception: ', '')));
      throw Exception(errorResponse.message);
    }
  }

  Future<MostPopularPlanResponse> getMostPopularPlan() async {
    try {
      final apiBase =
          await ApiBaseService.create( contentType: 'json');

      final response = await apiBase.get('/api/client_plans/popular-plan');
      if (response.statusCode == 200) {
        MostPopularPlanResponse mostPopularPlanResponse =
            mostPopularPlanResponseFromJson(response.body);
        log('Se obtuvo el plan más popular correctamente');
        return mostPopularPlanResponse;
      } else {
        log('Error del servidor en /api/client_plans con código: ${response.statusCode}');
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
