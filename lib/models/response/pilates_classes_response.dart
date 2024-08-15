import 'dart:convert';

List<PilatesClassesResponse> pilatesClassesResponseFromJson(String str) =>
    List<PilatesClassesResponse>.from(
        json.decode(str).map((x) => PilatesClassesResponse.fromJson(x)));

String pilatesClassesResponseToJson(List<PilatesClassesResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PilatesClassesResponse {
  String pilatesClassId;
  DateTime date;
  String scheduleId;
  List<Activity> activities;
  int availableClasses;
  Schedule schedule;

  PilatesClassesResponse({
    required this.pilatesClassId,
    required this.date,
    required this.scheduleId,
    required this.activities,
    required this.availableClasses,
    required this.schedule,
  });

  factory PilatesClassesResponse.fromJson(Map<String, dynamic> json) =>
      PilatesClassesResponse(
        pilatesClassId: json["pilates_class_id"],
        date: DateTime.parse(json["date"]),
        scheduleId: json["schedule_id"],
        activities: List<Activity>.from(
            json["activities"].map((x) => Activity.fromJson(x))),
        availableClasses: json["available_classes"],
        schedule: Schedule.fromJson(json["schedule"]),
      );

  Map<String, dynamic> toJson() => {
        "pilates_class_id": pilatesClassId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "schedule_id": scheduleId,
        "activities": List<dynamic>.from(activities.map((x) => x.toJson())),
        "available_classes": availableClasses,
        "schedule": schedule.toJson(),
      };
}

class Activity {
  String id;
  String name; // Ahora es un String simple
  int startMinute;
  int endMinute;
  String photo;

  Activity({
    required this.id,
    required this.name, // String en lugar de Name enum
    required this.startMinute,
    required this.endMinute,
    required this.photo,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["id"],
        name: json["name"], // String desde el JSON
        startMinute: json["start_minute"],
        endMinute: json["end_minute"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name, // Guardar como String
        "start_minute": startMinute,
        "end_minute": endMinute,
        "photo": photo,
      };
}

class Schedule {
  String startHour;
  String endHour;

  Schedule({
    required this.startHour,
    required this.endHour,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        startHour: json["start_hour"],
        endHour: json["end_hour"],
      );

  Map<String, dynamic> toJson() => {
        "start_hour": startHour,
        "end_hour": endHour,
      };
}
