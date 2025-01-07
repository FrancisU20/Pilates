import 'dart:convert';

import 'package:pilates/models/schedule/schedule_model.dart';

ClassModel classModelFromJson(String str) =>
    ClassModel.fromJson(json.decode(str));

String classModelToJson(ClassModel data) => json.encode(data.toJson());

class ClassModel {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int availableClasses;
  String classDate;
  ScheduleModel? schedule;

  ClassModel({
    this.id, // Opcional
    this.createdAt, // Opcional
    this.updatedAt, // Opcional
    required this.availableClasses,
    required this.classDate,
    this.schedule,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        availableClasses: json["availableClasses"],
        classDate: json["classDate"],
        schedule: json["schedule"] != null
            ? ScheduleModel.fromJson(json["schedule"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        if (createdAt != null) "createdAt": createdAt!.toIso8601String(),
        if (updatedAt != null) "updatedAt": updatedAt!.toIso8601String(),
        "availableClasses": availableClasses,
        "classDate": classDate,
        if (schedule != null) "schedule": schedule!.toJson(),
      };

  /// Deserializar una lista de objetos JSON en una lista de instancias de `ClassModel`
  static List<ClassModel> listFromJson(dynamic data) {
    return List<ClassModel>.from(
      (data as List<dynamic>).map((item) => ClassModel.fromJson(item)),
    );
  }
}
