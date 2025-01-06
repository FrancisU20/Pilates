import 'dart:convert';

NutritionalInfoCreateModel nutritionalInfoCreateFromJson(String str) =>
    NutritionalInfoCreateModel.fromJson(json.decode(str));

String nutritionalInfoCreateToJson(NutritionalInfoCreateModel data) =>
    json.encode(data.toJson());

class NutritionalInfoCreateModel {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? nutritionalData;
  String userId;

  NutritionalInfoCreateModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.nutritionalData,
    required this.userId,
  });

  factory NutritionalInfoCreateModel.fromJson(Map<String, dynamic> json) =>
      NutritionalInfoCreateModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        nutritionalData: json["userNutritionalData"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        if (createdAt != null) "createdAt": createdAt!.toIso8601String(),
        if (updatedAt != null) "updatedAt": updatedAt!.toIso8601String(),
        "userNutritionalData": nutritionalData,
        "userId": userId,
      };

  /// Deserializar una lista de objetos JSON en una lista de instancias de `NutritionalInfoCreateModel`
  static List<NutritionalInfoCreateModel> listFromJson(dynamic data) {
    return List<NutritionalInfoCreateModel>.from(
      (data as List<dynamic>)
          .map((item) => NutritionalInfoCreateModel.fromJson(item)),
    );
  }
}
