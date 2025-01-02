import 'dart:convert';

FileAssetModel fileAssetModelFromJson(String str) => FileAssetModel.fromJson(json.decode(str));

String fileAssetModelToJson(FileAssetModel data) => json.encode(data.toJson());

class FileAssetModel {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String path;

  FileAssetModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    required this.path,
  });

  factory FileAssetModel.fromJson(Map<String, dynamic> json) => FileAssetModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        if (createdAt != null) "createdAt": createdAt!.toIso8601String(),
        if (updatedAt != null) "updatedAt": updatedAt!.toIso8601String(),
        "path": path,
      };
  
  static List<FileAssetModel> listFromJson(dynamic data) {
    return List<FileAssetModel>.from(
      (data as List<dynamic>).map((item) => FileAssetModel.fromJson(item)),
    );
  }
}
