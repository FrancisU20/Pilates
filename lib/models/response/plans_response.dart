import 'dart:convert';

List<PlanResponse> plansResponseFromJson(String str) => List<PlanResponse>.from(
    json.decode(str).map((x) => PlanResponse.fromJson(x)));

String plansResponseToJson(List<PlanResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

PlanResponse planResponseFromJson(String str) =>
    PlanResponse.fromJson(json.decode(str));

String planResponseToJson(PlanResponse data) => json.encode(data.toJson());

class PlanResponse {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String description;
  double price;
  double classPrice;
  int numberOfClasses;
  int classVigency;

  PlanResponse({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.description,
    required this.price,
    required this.classPrice,
    required this.numberOfClasses,
    required this.classVigency,
  });

  factory PlanResponse.fromJson(Map<String, dynamic> json) => PlanResponse(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        name: json["name"],
        description: json["description"],
        price: double.parse(json["price"].toString()),
        classPrice: double.parse(json["class_price"].toString()),
        numberOfClasses: json["number_of_classes"],
        classVigency: json["class_vigency"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "name": name,
        "description": description,
        "price": price,
        "class_price": classPrice,
        "number_of_classes": numberOfClasses,
        "class_vigency": classVigency,
      };
}
