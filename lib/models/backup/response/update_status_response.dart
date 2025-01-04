// To parse this JSON data, do
//
//     final updateStatusResponse = updateStatusResponseFromJson(jsonString);

import 'dart:convert';

UpdateStatusResponse updateStatusResponseFromJson(String str) => UpdateStatusResponse.fromJson(json.decode(str));

String updateStatusResponseToJson(UpdateStatusResponse data) => json.encode(data.toJson());

class UpdateStatusResponse {
    String message;

    UpdateStatusResponse({
        required this.message,
    });

    factory UpdateStatusResponse.fromJson(Map<String, dynamic> json) => UpdateStatusResponse(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
