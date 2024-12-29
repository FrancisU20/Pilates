/// Clase principal de la respuesta estándar del servidor
class StandardResponse<T> {
  final bool success;
  final String message;
  final T? data; // Puede ser null, un objeto o una lista
  final int statusCode;
  final dynamic log; // Puede ser null o cualquier otra cosa en caso de error

  StandardResponse({
    required this.success,
    required this.message,
    this.data,
    required this.statusCode,
    this.log,
  });

  /// Método de deserialización genérico
  factory StandardResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic data) fromJsonT,
  ) {
    return StandardResponse<T>(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      statusCode: json['statusCode'],
      log: json['log'],
    );
  }

  /// Método de serialización genérico
  Map<String, dynamic> toJson(
    dynamic Function(T? data) toJsonT,
  ) {
    return {
      "success": success,
      "message": message,
      "data": data != null ? toJsonT(data) : null,
      "statusCode": statusCode,
      "log": log,
    };
  }
}
