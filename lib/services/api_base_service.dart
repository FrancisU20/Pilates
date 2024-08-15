import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pilates/models/response/login_response.dart';
import 'package:pilates/models/send/login_send.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiBaseService {
  bool isLogging;
  String isProduction = dotenv.env['ENV']!;
  String typeHeader;
  final endpoint = dotenv.env['API']!;
  final endpointLocal = dotenv.env['API_LOCAL']!;
  late Map<String, String> defaultHeaders = {};

  ApiBaseService._internal({
    required this.isLogging,
    required this.typeHeader,
  });

  static Future<ApiBaseService> create({
    required bool isLogging,
    required String typeHeader,
  }) async {
    final api =
        ApiBaseService._internal(isLogging: isLogging, typeHeader: typeHeader);
    await api.setHeader(isLogging, api.isProduction, typeHeader);
    return api;
  }

  Future<void> setHeader(
      bool isLogging, String isProduction, String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    switch (type) {
      case 'json':
        typeHeader = 'application/json';
        break;
      case 'urlencoded':
        typeHeader = 'application/x-www-form-urlencoded';
        break;
      case 'formdata':
        typeHeader = 'multipart/form-data';
        break;
      case 'text':
        typeHeader = 'text/plain';
        break;
      default:
        typeHeader = 'application/json';
        break;
    }

    switch (isProduction) {
      case 'dev':
        if (isLogging) {
          defaultHeaders['Content-Type'] = typeHeader;
        } else if (token != null) {
          defaultHeaders['Authorization'] = 'Bearer $token';
          defaultHeaders['Content-Type'] = typeHeader;
        }
        break;
      case 'prod':
        if (isLogging) {
          defaultHeaders['Content-Type'] = typeHeader;
        } else if (token != null) {
          defaultHeaders['Authorization'] = 'Bearer $token';
          defaultHeaders['Content-Type'] = typeHeader;
        }
        break;
      case 'test':
        if (isLogging) {
          defaultHeaders['Content-Type'] = typeHeader;
        } else if (token != null) {
          defaultHeaders['Authorization'] = 'Bearer $token';
          defaultHeaders['Content-Type'] = typeHeader;
        }
        break;
    }
  }

  // Método para refrescar el token de la API
  Future<String> refreshToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Obtener las credenciales de las preferencias
      final email = prefs.getString('loginUser') ?? '';
      final password = prefs.getString('loginPassword') ?? '';

      LoginSend userData = LoginSend(
        email: email,
        password: password,
      );

      // Se prepara el objeto para ser enviado
      Map<String, dynamic> dataJson = userData.toJson();
      String dataString = jsonEncode(dataJson);

      log('Data enviada: $dataJson');

      final response =
          await post('/api/clients/login', bodyRequest: dataString);

      if (response.statusCode == 200) {
        LoginResponse loginResponse =
            LoginResponse.fromJson(json.decode(response.body));
        final token = loginResponse.token;
        prefs.setString('token', token);
        return token;
      } else {
        log(response.body);
        throw Exception('Error al refrescar el token');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Error al refrescar el token');
    }
  }

  Future<http.Response> get(String microserviceAndParams,
      {Map<String, String>? headersAdditional, bool? isLocal}) async {
    final api = isLocal != null && isLocal ? endpointLocal : endpoint;
    final headers = {...defaultHeaders, ...?headersAdditional};
    return http.get(Uri.parse('$api$microserviceAndParams'), headers: headers);
  }

  Future<http.Response> post(String microserviceAndParams,
      {Map<String, String>? headersAdditional,
      String? bodyRequest,
      bool? isLocal}) async {
    final api = isLocal != null && isLocal ? endpointLocal : endpoint;
    final headers = {...defaultHeaders, ...?headersAdditional};
    return http.post(Uri.parse('$api$microserviceAndParams'),
        headers: headers, body: bodyRequest);
  }

  Future<http.StreamedResponse> multipartRequest(String microserviceAndParams,
      {Map<String, String>? headersAdditional,
      required List<http.MultipartFile> files,
      String? bodyRequest,
      bool? isLocal}) async {
    final api = isLocal != null && isLocal ? endpointLocal : endpoint;
    final headers = {...defaultHeaders, ...?headersAdditional};
    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse('$api$microserviceAndParams'));

    request.headers.addAll(headers);
    if (bodyRequest != null) {
      request.fields['bodyAuthorizations'] = bodyRequest;
    }
    request.files.addAll(files);

    return request.send();
  }

  Future<http.Response> put(String microserviceAndParams,
      {Map<String, String>? headersAdditional,
      String? bodyRequest,
      bool? isLocal}) async {
    final api = isLocal != null && isLocal ? endpointLocal : endpoint;
    final headers = {...defaultHeaders, ...?headersAdditional};
    return http.put(Uri.parse('$api$microserviceAndParams'),
        headers: headers, body: bodyRequest);
  }

  Future<http.Response> delete(String microserviceAndParams,
      {Map<String, String>? headersAdditional,
      String? bodyRequest,
      bool? isLocal}) async {
    final api = isLocal != null && isLocal ? endpointLocal : endpoint;
    final headers = {...defaultHeaders, ...?headersAdditional};
    return http.delete(Uri.parse('$api$microserviceAndParams'),
        headers: headers, body: bodyRequest);
  }
}
