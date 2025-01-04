import 'dart:convert';

CreateClientSend createClientSendFromJson(String str) =>
    CreateClientSend.fromJson(json.decode(str));

String createClientSendToJson(CreateClientSend data) =>
    json.encode(data.toJson());

class CreateClientSend {
  String dniType;
  String dniNumber;
  String name;
  String lastname;
  String password;
  DateTime birthdate;
  String phone;
  String gender;
  String photo;
  String email;
  String statusClient;

  CreateClientSend({
    required this.dniType,
    required this.dniNumber,
    required this.name,
    required this.lastname,
    required this.password,
    required this.birthdate,
    required this.phone,
    required this.gender,
    required this.photo,
    required this.email,
    required this.statusClient,
  });

  factory CreateClientSend.fromJson(Map<String, dynamic> json) =>
      CreateClientSend(
        dniType: json["dni_type"],
        dniNumber: json["dni_number"],
        name: json["name"],
        lastname: json["lastname"],
        password: json["password"],
        birthdate: DateTime.parse(json["birthdate"]),
        phone: json["phone"],
        gender: json["gender"],
        photo: json["photo"],
        email: json["email"],
        statusClient: json["status_client"],
      );

  Map<String, dynamic> toJson() => {
        "dni_type": dniType,
        "dni_number": dniNumber,
        "name": name,
        "lastname": lastname,
        "password": password,
        "birthdate":
            "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
        "phone": phone,
        "gender": gender,
        "photo": photo,
        "email": email,
        "status_client": statusClient,
      };
}
