import 'dart:developer';

class Logger {
  static void logServerError(Map<String, dynamic> serverJson) {
    log('=======================================================');
    log('Error del Servidor con statusCode: ${serverJson['statusCode']}');
    log('Mensaje: ${serverJson['message']}');
    log('Indicador: ${serverJson['log']}');
    log('=======================================================');
  }

  static void logServerSuccess(Map<String, dynamic> serverJson) {
    log('=======================================================');
    log('Respuesta del Servidor con statusCode: ${serverJson['statusCode']}');
    log('Mensaje: ${serverJson['message']}');
    log('Datos: ${serverJson['data']}');
    log('=======================================================');
  }

  static void logCustomMessage(String title, String message) {
    log('=======================================================');
    log('$title: $message');
    log('=======================================================');
  }

  static void logSendData(String data) {
    log('=======================================================');
    log('Data enviada: $data');
    log('=======================================================');
  }
}
