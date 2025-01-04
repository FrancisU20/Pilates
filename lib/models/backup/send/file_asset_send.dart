import 'dart:convert';

FileAssetSend fileAssetSendFromJson(String str) => FileAssetSend.fromJson(json.decode(str));

String fileAssetSendToJson(FileAssetSend data) => json.encode(data.toJson());

class FileAssetSend {
  String path;
  String? userId;
  String? userDniNumber;

  FileAssetSend({
    required this.path,
    this.userId,
    this.userDniNumber,
  });

  factory FileAssetSend.fromJson(Map<String, dynamic> json) => FileAssetSend(
        path: json["path"],
        userId: json["userId"],
        userDniNumber: json["userDniNumber"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {"path": path};
    if (userId != null && userId!.isNotEmpty) {
      data["userId"] = userId;
    }
    if (userDniNumber != null && userDniNumber!.isNotEmpty) {
      data["userDniNumber"] = userDniNumber;
    }
    return data;
  }
}
