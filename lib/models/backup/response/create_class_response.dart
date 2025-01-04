import 'dart:convert';

CreateClassResponse createClassResponseFromJson(String str) =>
    CreateClassResponse.fromJson(json.decode(str));

String createClassResponseToJson(CreateClassResponse data) =>
    json.encode(data.toJson());

class CreateClassResponse {
  String message;
  Data data;

  CreateClassResponse({
    required this.message,
    required this.data,
  });

  factory CreateClassResponse.fromJson(Map<String, dynamic> json) =>
      CreateClassResponse(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String id;
  String clientId;
  String pilatesClassId;
  DateTime date;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.clientId,
    required this.pilatesClassId,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        clientId: json["client_id"],
        pilatesClassId: json["pilates_class_id"],
        date: DateTime.parse(json["date"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "pilates_class_id": pilatesClassId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
