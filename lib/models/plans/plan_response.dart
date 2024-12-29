/// Modelo para un PlanResponse individual
class PlanResponse {
  final String id;
  final DateTime createdDate;
  final DateTime updatedDate;
  final String name;
  final String description;
  final String basePrice;
  final String pricePerClass;
  final int classesCount;
  final int classesValidityPeriod;

  PlanResponse({
    required this.id,
    required this.createdDate,
    required this.updatedDate,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.pricePerClass,
    required this.classesCount,
    required this.classesValidityPeriod,
  });

  /// Deserializar un objeto JSON en una instancia de `PlanResponse`
  factory PlanResponse.fromJson(Map<String, dynamic> json) => PlanResponse(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
        name: json["name"],
        description: json["description"],
        basePrice: json["basePrice"],
        pricePerClass: json["pricePerClass"],
        classesCount: json["classesCount"],
        classesValidityPeriod: json["classesValidityPeriod"],
      );

  /// Serializar una instancia de `PlanResponse` a JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate.toIso8601String(),
        "updatedDate": updatedDate.toIso8601String(),
        "name": name,
        "description": description,
        "basePrice": basePrice,
        "pricePerClass": pricePerClass,
        "classesCount": classesCount,
        "classesValidityPeriod": classesValidityPeriod,
      };

  /// Deserializar una lista de objetos JSON en una lista de instancias de `PlanResponse`
  static List<PlanResponse> listFromJson(dynamic data) {
    return List<PlanResponse>.from(
      (data as List<dynamic>).map((item) => PlanResponse.fromJson(item)),
    );
  }
}
