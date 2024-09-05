import 'dart:convert';

AvailableClientClassResponse availableClientClassResponseFromJson(String str) =>
    AvailableClientClassResponse.fromJson(json.decode(str));

String availableClientClassResponseToJson(AvailableClientClassResponse data) =>
    json.encode(data.toJson());

class AvailableClientClassResponse {
  String message;
  Data data;

  AvailableClientClassResponse({
    required this.message,
    required this.data,
  });

  factory AvailableClientClassResponse.fromJson(Map<String, dynamic> json) =>
      AvailableClientClassResponse(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  DateTime planExpiration;
  int availableClasses;

  Data({
    required this.planExpiration,
    required this.availableClasses,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        planExpiration: DateTime.parse(json["plan_expiration"]),
        availableClasses: json["available_classes"],
      );

  Map<String, dynamic> toJson() => {
        "plan_expiration":
            "${planExpiration.year.toString().padLeft(4, '0')}-${planExpiration.month.toString().padLeft(2, '0')}-${planExpiration.day.toString().padLeft(2, '0')}",
        "available_classes": availableClasses,
      };
}
