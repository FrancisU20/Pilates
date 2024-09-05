import 'dart:convert';

UploadS3Response uploadProfilePhotoResponseFromJson(String str) =>
    UploadS3Response.fromJson(json.decode(str));

String uploadProfilePhotoResponseToJson(UploadS3Response data) =>
    json.encode(data.toJson());

class UploadS3Response {
  String message;
  Data data;

  UploadS3Response({
    required this.message,
    required this.data,
  });

  factory UploadS3Response.fromJson(Map<String, dynamic> json) =>
      UploadS3Response(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String eTag;
  String serverSideEncryption;
  String location;
  String dataKey;
  String key;
  String bucket;

  Data({
    required this.eTag,
    required this.serverSideEncryption,
    required this.location,
    required this.dataKey,
    required this.key,
    required this.bucket,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        eTag: json["ETag"],
        serverSideEncryption: json["ServerSideEncryption"],
        location: json["Location"],
        dataKey: json["key"],
        key: json["Key"],
        bucket: json["Bucket"],
      );

  Map<String, dynamic> toJson() => {
        "ETag": eTag,
        "ServerSideEncryption": serverSideEncryption,
        "Location": location,
        "key": dataKey,
        "Key": key,
        "Bucket": bucket,
      };
}
