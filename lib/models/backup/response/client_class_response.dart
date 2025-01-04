import 'dart:convert';

List<ClientClassResponse> clienClassResponseFromJson(String str) =>
    List<ClientClassResponse>.from(
        json.decode(str).map((x) => ClientClassResponse.fromJson(x)));

String clienClassResponseToJson(List<ClientClassResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClientClassResponse {
  String id;
  DateTime date;
  Schedule schedule;
  List<String> activities;
  int availableClasses;
  String statusClass;

  ClientClassResponse({
    required this.id,
    required this.date,
    required this.schedule,
    required this.activities,
    required this.availableClasses,
    required this.statusClass,
  });

  factory ClientClassResponse.fromJson(Map<String, dynamic> json) =>
      ClientClassResponse(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        schedule: Schedule.fromJson(json["schedule"]),
        activities: List<String>.from(json["activities"].map((x) => x)),
        availableClasses: json["available_classes"],
        statusClass: json["status_class"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "schedule": schedule.toJson(),
        "activities": List<dynamic>.from(activities.map((x) => x)),
        "available_classes": availableClasses,
        "status_class": statusClass,
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
