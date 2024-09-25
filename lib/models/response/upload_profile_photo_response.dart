import 'dart:convert';

UploadS3Response uploadS3ResponseFromJson(String str) =>
    UploadS3Response.fromJson(json.decode(str));

String uploadS3ResponseToJson(UploadS3Response data) =>
    json.encode(data.toJson());

class UploadS3Response {
  String message;
  String fileUrl;
  Data data;

  UploadS3Response({
    required this.message,
    required this.fileUrl,
    required this.data,
  });

  factory UploadS3Response.fromJson(Map<String, dynamic> json) =>
      UploadS3Response(
        message: json["message"],
        fileUrl: json["fileUrl"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "fileUrl": fileUrl,
        "data": data.toJson(),
      };
}

class Data {
  Metadata metadata;
  String eTag;
  String serverSideEncryption;

  Data({
    required this.metadata,
    required this.eTag,
    required this.serverSideEncryption,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        metadata: Metadata.fromJson(json["\u0024metadata"]),
        eTag: json["ETag"],
        serverSideEncryption: json["ServerSideEncryption"],
      );

  Map<String, dynamic> toJson() => {
        "\u0024metadata": metadata.toJson(),
        "ETag": eTag,
        "ServerSideEncryption": serverSideEncryption,
      };
}

class Metadata {
  int httpStatusCode;
  String requestId;
  String extendedRequestId;
  int attempts;
  int totalRetryDelay;

  Metadata({
    required this.httpStatusCode,
    required this.requestId,
    required this.extendedRequestId,
    required this.attempts,
    required this.totalRetryDelay,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        httpStatusCode: json["httpStatusCode"],
        requestId: json["requestId"],
        extendedRequestId: json["extendedRequestId"],
        attempts: json["attempts"],
        totalRetryDelay: json["totalRetryDelay"],
      );

  Map<String, dynamic> toJson() => {
        "httpStatusCode": httpStatusCode,
        "requestId": requestId,
        "extendedRequestId": extendedRequestId,
        "attempts": attempts,
        "totalRetryDelay": totalRetryDelay,
      };
}
