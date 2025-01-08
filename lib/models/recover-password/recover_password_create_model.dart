import 'dart:convert';

RecoverPasswordCreateModel recoverPasswordCreateModelFromJson(String str) =>
    RecoverPasswordCreateModel.fromJson(json.decode(str));

String recoverPasswordCreateModelToJson(RecoverPasswordCreateModel data) => json.encode(data.toJson());

class RecoverPasswordCreateModel {
  String email;

  RecoverPasswordCreateModel({
    required this.email,
  });

  factory RecoverPasswordCreateModel.fromJson(Map<String, dynamic> json) => RecoverPasswordCreateModel(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };

  /// Deserializar una lista de objetos JSON en una lista de instancias de `RecoverPasswordCreateModel`
  static List<RecoverPasswordCreateModel> listFromJson(dynamic data) {
    return List<RecoverPasswordCreateModel>.from(
      (data as List<dynamic>).map((item) => RecoverPasswordCreateModel.fromJson(item)),
    );
  }
}
