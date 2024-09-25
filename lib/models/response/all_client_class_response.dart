import 'dart:convert';

List<AllClientsPlansResponse> allClientsPlansResponseFromJson(String str) =>
    List<AllClientsPlansResponse>.from(
        json.decode(str).map((x) => AllClientsPlansResponse.fromJson(x)));

String allClientsPlansResponseToJson(List<AllClientsPlansResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllClientsPlansResponse {
  String id;
  String clientId;
  String clientDniNumber;
  String clientName;
  String clientLastname;
  String clientEmail;
  String clientPhone;
  DateTime clientBirthdate;
  String planId;
  String planName;
  String planDescription;
  String planPrice;
  int numberOfClasses;
  int classVigency;
  int attendedClasses;
  DateTime planVigency;
  DateTime planExpiration;
  String paymentMethod;
  String paymentToken;
  String status;

  AllClientsPlansResponse({
    required this.id,
    required this.clientId,
    required this.clientDniNumber,
    required this.clientName,
    required this.clientLastname,
    required this.clientEmail,
    required this.clientPhone,
    required this.clientBirthdate,
    required this.planId,
    required this.planName,
    required this.planDescription,
    required this.planPrice,
    required this.numberOfClasses,
    required this.classVigency,
    required this.attendedClasses,
    required this.planVigency,
    required this.planExpiration,
    required this.paymentMethod,
    required this.paymentToken,
    required this.status,
  });

  factory AllClientsPlansResponse.fromJson(Map<String, dynamic> json) =>
      AllClientsPlansResponse(
        id: json["id"],
        clientId: json["client_id"],
        clientDniNumber: json["client_dni_number"],
        clientName: json["client_name"],
        clientLastname: json["client_lastname"],
        clientEmail: json["client_email"],
        clientPhone: json["client_phone"],
        clientBirthdate: DateTime.parse(json["client_birthdate"]),
        planId: json["plan_id"],
        planName: json["plan_name"],
        planDescription: json["plan_description"],
        planPrice: json["plan_price"],
        numberOfClasses: json["number_of_classes"],
        classVigency: json["class_vigency"],
        attendedClasses: json["attended_classes"],
        planVigency: DateTime.parse(json["plan_vigency"]),
        planExpiration: DateTime.parse(json["plan_expiration"]),
        paymentMethod: json["payment_method"],
        paymentToken: json["payment_token"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "client_dni_number": clientDniNumber,
        "client_name": clientName,
        "client_lastname": clientLastname,
        "client_email": clientEmail,
        "client_phone": clientPhone,
        "client_birthdate":
            "${clientBirthdate.year.toString().padLeft(4, '0')}-${clientBirthdate.month.toString().padLeft(2, '0')}-${clientBirthdate.day.toString().padLeft(2, '0')}",
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
        "payment_method": paymentMethod,
        "payment_token": paymentToken,
        "status": status,
      };
}
