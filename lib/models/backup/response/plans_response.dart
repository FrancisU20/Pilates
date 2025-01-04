import 'dart:convert';

PlansResponse plansResponseFromJson(String str) => PlansResponse.fromJson(json.decode(str));

String plansResponseToJson(PlansResponse data) => json.encode(data.toJson());

class PlansResponse {
    bool success;
    String message;
    List<PlanInfo> data;
    int statusCode;
    dynamic log;

    PlansResponse({
        required this.success,
        required this.message,
        required this.data,
        required this.statusCode,
        this.log,
    });

    factory PlansResponse.fromJson(Map<String, dynamic> json) => PlansResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] != null
            ? List<PlanInfo>.from(json["data"].map((x) => PlanInfo.fromJson(x)))
            : [], // Maneja el caso de un arreglo vacío o nulo.
        statusCode: json["statusCode"],
        log: json["log"], // Permite que log sea nulo.
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "statusCode": statusCode,
        "log": log,
    };
}

class PlanInfo {
    String id;
    DateTime createdDate;
    DateTime updatedDate;
    String name;
    String description;
    String basePrice;
    String pricePerClass;
    int classesCount;
    int classesValidityPeriod;

    PlanInfo({
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

    factory PlanInfo.fromJson(Map<String, dynamic> json) => PlanInfo(
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
}
