import 'dart:convert';

UserPlanCreateModel userPlanCreateModelModelFromJson(String str) =>
    UserPlanCreateModel.fromJson(json.decode(str));

String userPlanCreateModelModelToJson(UserPlanCreateModel data) =>
    json.encode(data.toJson());

class UserPlanCreateModel {
  String userId;
  String planId;
  String paymentPhoto;

  UserPlanCreateModel({
    required this.userId,
    required this.planId,
    required this.paymentPhoto,
  });

  factory UserPlanCreateModel.fromJson(Map<String, dynamic> json) =>
      UserPlanCreateModel(
        userId: json["userId"],
        planId: json["planId"],
        paymentPhoto: json["paymentPhoto"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "planId": planId,
        "paymentPhoto": paymentPhoto,
      };

  /// Deserializar una lista de objetos JSON en una lista de instancias de `UserPlanCreateModel`
  static List<UserPlanCreateModel> listFromJson(dynamic data) {
    return List<UserPlanCreateModel>.from(
      (data as List<dynamic>).map((item) => UserPlanCreateModel.fromJson(item)),
    );
  }
}
