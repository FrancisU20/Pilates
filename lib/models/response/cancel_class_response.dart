import 'dart:convert';

CancelClassResponse cancelClassResponseFromJson(String str) =>
    CancelClassResponse.fromJson(json.decode(str));

String cancelClassResponseToJson(CancelClassResponse data) =>
    json.encode(data.toJson());

class CancelClassResponse {
  bool canceled;
  String message;

  CancelClassResponse({
    required this.canceled,
    required this.message,
  });

  factory CancelClassResponse.fromJson(Map<String, dynamic> json) =>
      CancelClassResponse(
        canceled: json["canceled"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "canceled": canceled,
        "message": message,
      };
}
