import 'dart:convert';

ScheduleModel scheduleModelFromJson(String str) =>
    ScheduleModel.fromJson(json.decode(str));

String scheduleModelToJson(ScheduleModel data) => json.encode(data.toJson());

class ScheduleModel {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String dayCategory;
  String startHour;
  String endHour;

  ScheduleModel({
    this.id, // Opcional
    this.createdAt, // Opcional
    this.updatedAt, // Opcional
    required this.dayCategory,
    required this.startHour,
    required this.endHour,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        dayCategory: json["dayCategory"],
        startHour: json["startHour"],
        endHour: json["endHour"],
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        if (createdAt != null) "createdAt": createdAt!.toIso8601String(),
        if (updatedAt != null) "updatedAt": updatedAt!.toIso8601String(),
        "dayCategory": dayCategory,
        "startHour": startHour,
        "endHour": endHour,
      };

  /// Deserializar una lista de objetos JSON en una lista de instancias de `ScheduleModel`
  static List<ScheduleModel> listFromJson(dynamic data) {
    return List<ScheduleModel>.from(
      (data as List<dynamic>).map((item) => ScheduleModel.fromJson(item)),
    );
  }
}
