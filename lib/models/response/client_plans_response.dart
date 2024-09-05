import 'dart:convert';

List<ClientPlansResponse> clientPlansResponseFromJson(String str) =>
    List<ClientPlansResponse>.from(
        json.decode(str).map((x) => ClientPlansResponse.fromJson(x)));

String clientPlansResponseToJson(List<ClientPlansResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClientPlansResponse {
  String id;
  String planId;
  String planName;
  String planDescription;
  String planPrice;
  int numberOfClasses;
  int classVigency;
  int attendedClasses;
  DateTime planVigency;
  DateTime planExpiration;
  String status;
  String paymentMethod;
  String paymentToken;

  ClientPlansResponse({
    required this.id,
    required this.planId,
    required this.planName,
    required this.planDescription,
    required this.planPrice,
    required this.numberOfClasses,
    required this.classVigency,
    required this.attendedClasses,
    required this.planVigency,
    required this.planExpiration,
    required this.status,
    required this.paymentMethod,
    required this.paymentToken,
  });

  factory ClientPlansResponse.fromJson(Map<String, dynamic> json) =>
      ClientPlansResponse(
        id: json["id"],
        planId: json["plan_id"],
        planName: json["plan_name"],
        planDescription: json["plan_description"],
        planPrice: json["plan_price"],
        numberOfClasses: json["number_of_classes"],
        classVigency: json["class_vigency"],
        attendedClasses: json["attended_classes"],
        planVigency: DateTime.parse(json["plan_vigency"]),
        planExpiration: DateTime.parse(json["plan_expiration"]),
        status: json["status"],
        paymentMethod: json["payment_method"],
        paymentToken: json["payment_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "plan_id": planId,
        "plan_name": planName,
        "plan_description": planDescription,
        "plan_price": planPrice,
        "number_of_classes": numberOfClasses,
        "class_vigency": classVigency,
        "attended_classes": attendedClasses,
        "plan_vigency":
            "${planVigency.year.toString().padLeft(4, '0')}-${planVigency.month.toString().padLeft(2, '0')}-${planVigency.day.toString().padLeft(2, '0')}",
        "plan_expiration":
            "${planExpiration.year.toString().padLeft(4, '0')}-${planExpiration.month.toString().padLeft(2, '0')}-${planExpiration.day.toString().padLeft(2, '0')}",
        "status": status,
        "payment_method": paymentMethod,
        "payment_token": paymentToken,
      };
}
