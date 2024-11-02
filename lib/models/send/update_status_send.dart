// To parse this JSON data, do
//
//     final updateStatusSend = updateStatusSendFromJson(jsonString);

import 'dart:convert';

UpdateStatusSend updateStatusSendFromJson(String str) => UpdateStatusSend.fromJson(json.decode(str));

String updateStatusSendToJson(UpdateStatusSend data) => json.encode(data.toJson());

class UpdateStatusSend {
    String statusClient;

    UpdateStatusSend({
        required this.statusClient,
    });

    factory UpdateStatusSend.fromJson(Map<String, dynamic> json) => UpdateStatusSend(
        statusClient: json["status_client"],
    );

    Map<String, dynamic> toJson() => {
        "status_client": statusClient,
    };
}
