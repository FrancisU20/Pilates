import 'dart:convert';

UserClassCreateModel userClassCreateModelFromJson(String str) =>
    UserClassCreateModel.fromJson(json.decode(str));

String userClassCreateModelToJson(UserClassCreateModel data) =>
    json.encode(data.toJson());

class UserClassCreateModel {
  String userId;
  String classId;

  UserClassCreateModel({
    required this.userId,
    required this.classId,
  });

  factory UserClassCreateModel.fromJson(Map<String, dynamic> json) =>
      UserClassCreateModel(
        userId: json["userId"],
        classId: json["classId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "classId": classId,
      };

  /// Deserializar una lista de objetos JSON en una lista de instancias de `UserClassCreateModel`
  static List<UserClassCreateModel> listFromJson(dynamic data) {
    return List<UserClassCreateModel>.from(
      (data as List<dynamic>)
          .map((item) => UserClassCreateModel.fromJson(item)),
    );
  }
}
