import 'dart:convert';

LoginSend loginSendFromJson(String str) => LoginSend.fromJson(json.decode(str));

String loginSendToJson(LoginSend data) => json.encode(data.toJson());

class LoginSend {
  String email;
  String password;

  LoginSend({
    required this.email,
    required this.password,
  });

  factory LoginSend.fromJson(Map<String, dynamic> json) => LoginSend(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
