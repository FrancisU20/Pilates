import 'dart:convert';

CreateClientPlanResponse createClientPlanResponseFromJson(String str) =>
    CreateClientPlanResponse.fromJson(json.decode(str));

String createClientPlanResponseToJson(CreateClientPlanResponse data) =>
    json.encode(data.toJson());

class CreateClientPlanResponse {
  String message;
  Data data;

  CreateClientPlanResponse({
    required this.message,
    required this.data,
  });

  factory CreateClientPlanResponse.fromJson(Map<String, dynamic> json) =>
      CreateClientPlanResponse(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  DateTime createdAt;
  DateTime updatedAt;
  String id;
  String clientId;
  String planId;
  DateTime planVigency;
  DateTime planExpiration;
  int attendedClasses;
  String status;

  Data({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.clientId,
    required this.planId,
    required this.planVigency,
    required this.planExpiration,
    required this.attendedClasses,
    required this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        clientId: json["client_id"],
        planId: json["plan_id"],
        planVigency: DateTime.parse(json["plan_vigency"]),
        planExpiration: DateTime.parse(json["plan_expiration"]),
        attendedClasses: json["attended_classes"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "client_id": clientId,
        "plan_id": planId,
        "plan_vigency":
            "${planVigency.year.toString().padLeft(4, '0')}-${planVigency.month.toString().padLeft(2, '0')}-${planVigency.day.toString().padLeft(2, '0')}",
        "plan_expiration":
            "${planExpiration.year.toString().padLeft(4, '0')}-${planExpiration.month.toString().padLeft(2, '0')}-${planExpiration.day.toString().padLeft(2, '0')}",
        "attended_classes": attendedClasses,
        "status": status,
      };
}
