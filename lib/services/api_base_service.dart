import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pilates/models/response/login_response.dart';
import 'package:pilates/models/send/login_send.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiBaseService {
  late Map<String, String> customHeaders = {};
  String contentType;
  final String uri = dotenv.env['API']!, uriLocal = dotenv.env['API_LOCAL']!;

  ApiBaseService._internal({
    required this.contentType,
  });

  static Future<ApiBaseService> create({
    required String contentType,
  }) async {
    final api = ApiBaseService._internal(contentType: contentType);
    await api.setHeader(contentType);
    return api;
  }

  Future<void> setHeader(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // Configurar el tipo de contenido según el parámetro `type`
    switch (type) {
      case 'json':
        contentType = 'application/json';
        break;
      case 'urlencoded':
        contentType = 'application/x-www-form-urlencoded';
        break;
      case 'formdata':
        contentType = 'multipart/form-data';
        break;
      case 'text':
        contentType = 'text/plain';
        break;
      default:
        contentType = 'application/json';
        break;
    }

    // Configurar los headers por defecto
    customHeaders['Content-Type'] = contentType;

    // Incluir el token si está disponible y `authApi` es falso
    if (token != null) {
      customHeaders['Authorization'] = 'Bearer $token';
    }

    log('Default Headers: $customHeaders');
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
    final api = isLocal != null && isLocal ? uriLocal : uri;
    final headers = {...customHeaders, ...?headersAdditional};
    return http.get(Uri.parse('$api$microserviceAndParams'), headers: headers);
  }

  Future<http.Response> post(String microserviceAndParams,
      {Map<String, String>? headersAdditional,
      String? bodyRequest,
      bool? isLocal}) async {
    final api = isLocal != null && isLocal ? uriLocal : uri;
    final headers = {...customHeaders, ...?headersAdditional};
    log('Headers: $headers');
    return http.post(Uri.parse('$api$microserviceAndParams'),
        headers: headers, body: bodyRequest);
  }

  Future<http.StreamedResponse> multipartRequest(String microserviceAndParams,
      {Map<String, String>? headersAdditional,
      required List<http.MultipartFile> files,
      String? bodyRequest,
      bool? isLocal}) async {
    final api = isLocal != null && isLocal ? uriLocal : uri;
    final headers = {...customHeaders, ...?headersAdditional};
    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse('$api$microserviceAndParams'));

    request.headers.addAll(headers);
    if (bodyRequest != null) {
      request.fields['data'] = bodyRequest;
    }
    request.files.addAll(files);

    return request.send();
  }

  Future<http.Response> put(String microserviceAndParams,
      {Map<String, String>? headersAdditional,
      String? bodyRequest,
      bool? isLocal}) async {
    final api = isLocal != null && isLocal ? uriLocal : uri;
    final headers = {...customHeaders, ...?headersAdditional};
    return http.put(Uri.parse('$api$microserviceAndParams'),
        headers: headers, body: bodyRequest);
  }

  Future<http.Response> delete(String microserviceAndParams,
      {Map<String, String>? headersAdditional,
      String? bodyRequest,
      bool? isLocal}) async {
    final api = isLocal != null && isLocal ? uriLocal : uri;
    final headers = {...customHeaders, ...?headersAdditional};
    return http.delete(Uri.parse('$api$microserviceAndParams'),
        headers: headers, body: bodyRequest);
  }
}
