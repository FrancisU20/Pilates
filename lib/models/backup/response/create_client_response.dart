import 'dart:convert';

CreateClientResponse createClientResponseFromJson(String str) =>
    CreateClientResponse.fromJson(json.decode(str));

String createClientResponseToJson(CreateClientResponse data) =>
    json.encode(data.toJson());

class CreateClientResponse {
  String message;
  Data data;

  CreateClientResponse({
    required this.message,
    required this.data,
  });

  factory CreateClientResponse.fromJson(Map<String, dynamic> json) =>
      CreateClientResponse(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String id;
  String email;
  String password;
  String name;
  String lastname;
  String dniNumber;
  String dniType;
  DateTime birthdate;
  String phone;
  String gender;
  String photo;
  DateTime createdAt;
  DateTime updatedAt;
  String role;
  String statusClient;

  Data({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.lastname,
    required this.dniNumber,
    required this.dniType,
    required this.birthdate,
    required this.phone,
    required this.gender,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.statusClient,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        lastname: json["lastname"],
        dniNumber: json["dni_number"],
        dniType: json["dni_type"],
        birthdate: DateTime.parse(json["birthdate"]),
        phone: json["phone"],
        gender: json["gender"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        role: json["role"],
        statusClient: json["status_client"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "name": name,
        "lastname": lastname,
        "dni_number": dniNumber,
        "dni_type": dniType,
        "birthdate":
            "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
        "phone": phone,
        "gender": gender,
        "photo": photo,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "role": role,
        "status_client": statusClient,
      };
}
