import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String dniNumber;
  String name;
  String lastname;
  DateTime birthdate;
  String? password;
  String phone;
  String gender;
  String photo;
  String email;
  String role;
  String? status;

  UserModel({
    this.id, // Opcional
    this.createdAt, // Opcional
    this.updatedAt, // Opcional
    required this.dniNumber,
    required this.name,
    required this.lastname,
    required this.birthdate,
    this.password, // Opcional
    required this.phone,
    required this.gender,
    required this.photo,
    required this.email,
    required this.role,
    this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        dniNumber: json["dni_number"],
        name: json["name"],
        lastname: json["lastname"],
        birthdate: DateTime.parse(json["birthdate"]),
        password: json["password"],
        phone: json["phone"],
        gender: json["gender"],
        photo: json["photo"],
        email: json["email"],
        role: json["role"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        if (createdAt != null) "createdAt": createdAt!.toIso8601String(),
        if (updatedAt != null) "updatedAt": updatedAt!.toIso8601String(),
        "dni_number": dniNumber,
        "name": name,
        "lastname": lastname,
        "birthdate":
            "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
        if (password != null) "password": password,
        "phone": phone,
        "gender": gender,
        "photo": photo,
        "email": email,
        "role": role,
        if (status != null) "status": status,
      };

  /// Deserializar una lista de objetos JSON en una lista de instancias de `UserModel`
  static List<UserModel> listFromJson(dynamic data) {
    return List<UserModel>.from(
      (data as List<dynamic>).map((item) => UserModel.fromJson(item)),
    );
  }
}
