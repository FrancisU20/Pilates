/// Modelo para un PlanModel individual
class PlanModel {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String name;
  final String description;
  final String basePrice;
  final String pricePerClass;
  final int classesCount;
  final int classesValidityPeriod;

  PlanModel({
    this.id, // Opcional
    this.createdAt, // Opcional
    this.updatedAt, // Opcional
    required this.name,
    required this.description,
    required this.basePrice,
    required this.pricePerClass,
    required this.classesCount,
    required this.classesValidityPeriod,
  });

  /// Deserializar un objeto JSON en una instancia de `PlanModel`
  factory PlanModel.fromJson(Map<String, dynamic> json) => PlanModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        name: json["name"],
        description: json["description"],
        basePrice: json["basePrice"],
        pricePerClass: json["pricePerClass"],
        classesCount: json["classesCount"],
        classesValidityPeriod: json["classesValidityPeriod"],
      );

  /// Serializar una instancia de `PlanModel` a JSON
  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        if (createdAt != null) "createdAt": createdAt!.toIso8601String(),
        if (updatedAt != null) "updatedAt": updatedAt!.toIso8601String(),
        "name": name,
        "description": description,
        "basePrice": basePrice,
        "pricePerClass": pricePerClass,
        "classesCount": classesCount,
        "classesValidityPeriod": classesValidityPeriod,
      };

  /// Deserializar una lista de objetos JSON en una lista de instancias de `PlanModel`
  static List<PlanModel> listFromJson(dynamic data) {
    return List<PlanModel>.from(
      (data as List<dynamic>).map((item) => PlanModel.fromJson(item)),
    );
  }
}
