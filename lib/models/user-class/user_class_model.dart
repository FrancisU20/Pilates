import 'dart:convert';

import 'package:pilates/models/class/class_model.dart';
import 'package:pilates/models/user/user_model.dart';

UserClassModel userClassModelFromJson(String str) =>
    UserClassModel.fromJson(json.decode(str));

String userClassModelToJson(UserClassModel data) =>
    json.encode(data.toJson());

class UserClassModel {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String status;
  UserModel user;
  ClassModel classModel;

  UserClassModel({
    this.id, // Opcional
    this.createdAt, // Opcional
    this.updatedAt, // Opcional
    required this.status,
    required this.user,
    required this.classModel
  });

  factory UserClassModel.fromJson(Map<String, dynamic> json) =>
      UserClassModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        status: json["status"],
        user: UserModel.fromJson(json["user"]),
        classModel: ClassModel.fromJson(json["class"]),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        if (createdAt != null) "createdAt": createdAt!.toIso8601String(),
        if (updatedAt != null) "updatedAt": updatedAt!.toIso8601String(),
        "status": status,
        "user": user.toJson(),
        "class": classModel.toJson(),
      };

  /// Deserializar una lista de objetos JSON en una lista de instancias de `UserClassModel`
  static List<UserClassModel> listFromJson(dynamic data) {
    return List<UserClassModel>.from(
      (data as List<dynamic>)
          .map((item) => UserClassModel.fromJson(item)),
    );
  }
}
