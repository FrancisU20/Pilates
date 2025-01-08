import 'dart:convert';

RecoverPasswordModel recoverPasswordModelFromJson(String str) =>
    RecoverPasswordModel.fromJson(json.decode(str));

String recoverPasswordModelToJson(RecoverPasswordModel data) => json.encode(data.toJson());

class RecoverPasswordModel {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String email;
  String code;
  DateTime expiresAt;

  RecoverPasswordModel({
    this.id, // Opcional
    this.createdAt, // Opcional
    this.updatedAt, // Opcional
    required this.email,
    required this.code,
    required this.expiresAt,
  });

  factory RecoverPasswordModel.fromJson(Map<String, dynamic> json) => RecoverPasswordModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        email: json["email"],
        code: json["code"],
        expiresAt: DateTime.parse(json["expiresAt"]),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        if (createdAt != null) "createdAt": createdAt!.toIso8601String(),
        if (updatedAt != null) "updatedAt": updatedAt!.toIso8601String(),
        "email": email,
        "code": code,
        "expiresAt": expiresAt.toIso8601String(),
      };

  /// Deserializar una lista de objetos JSON en una lista de instancias de `RecoverPasswordModel`
  static List<RecoverPasswordModel> listFromJson(dynamic data) {
    return List<RecoverPasswordModel>.from(
      (data as List<dynamic>).map((item) => RecoverPasswordModel.fromJson(item)),
    );
  }
}
