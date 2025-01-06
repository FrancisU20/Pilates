import 'dart:convert';

import 'package:pilates/models/nutritional-info/nutritional_data_model.dart';
import 'package:pilates/models/user/user_model.dart';

NutritionalInfoModel nutritionalInfoModelFromJson(String str) =>
    NutritionalInfoModel.fromJson(json.decode(str));

String nutritionalInfoModelToJson(NutritionalInfoModel data) =>
    json.encode(data.toJson());

class NutritionalInfoModel {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  NutritionalDataModel nutritionalData;
  UserModel user;

  NutritionalInfoModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    required this.nutritionalData,
    required this.user,
  });

  factory NutritionalInfoModel.fromJson(Map<String, dynamic> json) =>
      NutritionalInfoModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        nutritionalData: nutritionalDataModelFromJson(
            json["userNutritionalData"].toString()),
        user: UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        if (createdAt != null) "createdAt": createdAt!.toIso8601String(),
        if (updatedAt != null) "updatedAt": updatedAt!.toIso8601String(),
        "userNutritionalData": nutritionalData.toJson(),
        "user": user.toJson(),
      };

  /// Deserializar una lista de objetos JSON en una lista de instancias de `NutritionalInfoModel`
  static List<NutritionalInfoModel> listFromJson(dynamic data) {
    return List<NutritionalInfoModel>.from(
      (data as List<dynamic>)
          .map((item) => NutritionalInfoModel.fromJson(item)),
    );
  }
}
