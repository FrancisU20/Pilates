import 'dart:convert';

CreateClientPlanSend createClientPlanSendFromJson(String str) =>
    CreateClientPlanSend.fromJson(json.decode(str));

String createClientPlanSendToJson(CreateClientPlanSend data) =>
    json.encode(data.toJson());

class CreateClientPlanSend {
  String clientId;
  String planId;
  DateTime planVigency;
  DateTime planExpiration;
  int attendedClasses;
  String status;
  String paymentMethod;
  String paymentToken;

  CreateClientPlanSend({
    required this.clientId,
    required this.planId,
    required this.planVigency,
    required this.planExpiration,
    required this.attendedClasses,
    required this.status,
    required this.paymentMethod,
    required this.paymentToken,
  });

  factory CreateClientPlanSend.fromJson(Map<String, dynamic> json) =>
      CreateClientPlanSend(
        clientId: json["clientId"],
        planId: json["planId"],
        planVigency: DateTime.parse(json["planVigency"]),
        planExpiration: DateTime.parse(json["planExpiration"]),
        attendedClasses: json["attendedClasses"],
        status: json["status"],
        paymentMethod: json["paymentMethod"],
        paymentToken: json["paymentToken"],
      );

  Map<String, dynamic> toJson() => {
        "clientId": clientId,
        "planId": planId,
        "planVigency":
            "${planVigency.year.toString().padLeft(4, '0')}-${planVigency.month.toString().padLeft(2, '0')}-${planVigency.day.toString().padLeft(2, '0')}",
        "planExpiration":
            "${planExpiration.year.toString().padLeft(4, '0')}-${planExpiration.month.toString().padLeft(2, '0')}-${planExpiration.day.toString().padLeft(2, '0')}",
        "attendedClasses": attendedClasses,
        "status": status,
        "paymentMethod": paymentMethod,
        "paymentToken": paymentToken,
      };
}
