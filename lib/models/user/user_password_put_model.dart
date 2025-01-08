import 'dart:convert';

UserPasswordPutModel userPasswordPutModelFromJson(String str) =>
    UserPasswordPutModel.fromJson(json.decode(str));

String userPasswordPutModelToJson(UserPasswordPutModel data) =>
    json.encode(data.toJson());

class UserPasswordPutModel {
  String email;
  String password;

  UserPasswordPutModel({required this.password, required this.email});

  factory UserPasswordPutModel.fromJson(Map<String, dynamic> json) =>
      UserPasswordPutModel(
        password: json["password"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "email": email,
      };

  /// Deserializar una lista de objetos JSON en una lista de instancias de `UserPasswordPutModel`
  static List<UserPasswordPutModel> listFromJson(dynamic data) {
    return List<UserPasswordPutModel>.from(
      (data as List<dynamic>)
          .map((item) => UserPasswordPutModel.fromJson(item)),
    );
  }
}
