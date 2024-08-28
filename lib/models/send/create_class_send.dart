import 'dart:convert';

CreateClassSend createClassSendFromJson(String str) =>
    CreateClassSend.fromJson(json.decode(str));

String createClassSendToJson(CreateClassSend data) =>
    json.encode(data.toJson());

class CreateClassSend {
  String clientId;
  String pilatesClassId;
  DateTime date;

  CreateClassSend({
    required this.clientId,
    required this.pilatesClassId,
    required this.date,
  });

  factory CreateClassSend.fromJson(Map<String, dynamic> json) =>
      CreateClassSend(
        clientId: json["clientId"],
        pilatesClassId: json["pilatesClassId"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "clientId": clientId,
        "pilatesClassId": pilatesClassId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}
