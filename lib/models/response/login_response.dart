import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  Client client;
  String token;

  LoginResponse({
    required this.client,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        client: Client.fromJson(json["client"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "client": client.toJson(),
        "token": token,
      };
}

class Client {
  String id;
  String dniType;
  String dniNumber;
  String name;
  String lastname;
  String password;
  DateTime birthdate;
  String phone;
  String gender;
  String photo;
  DateTime createdAt;
  DateTime updatedAt;
  String email;
  String role;

  Client({
    required this.id,
    required this.dniType,
    required this.dniNumber,
    required this.name,
    required this.lastname,
    required this.password,
    required this.birthdate,
    required this.phone,
    required this.gender,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
    required this.email,
    required this.role,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        dniType: json["dni_type"],
        dniNumber: json["dni_number"],
        name: json["name"],
        lastname: json["lastname"],
        password: json["password"],
        birthdate: DateTime.parse(json["birthdate"]),
        phone: json["phone"],
        gender: json["gender"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        email: json["email"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
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
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "email": email,
        "role": role,
      };
}
