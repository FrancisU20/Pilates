import 'dart:convert';

import 'package:pilates/models/plan/plan_model.dart';
import 'package:pilates/models/user/user_model.dart';

UserPlanModel userPlanModelFromJson(String str) =>
    UserPlanModel.fromJson(json.decode(str));

String userPlanModelToJson(UserPlanModel data) => json.encode(data.toJson());

class UserPlanModel {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserModel user;
  PlanModel plan;
  DateTime planStart;
  DateTime planEnd;
  int scheduledClasses;
  String paymentPhoto;
  String? status;

  UserPlanModel({
    this.id, // Opcional
    this.createdAt, // Opcional
    this.updatedAt, // Opcional
    required this.user,
    required this.plan,
    required this.planStart,
    required this.planEnd,
    required this.scheduledClasses,
    required this.paymentPhoto,
    this.status, // Opcional
  });

  factory UserPlanModel.fromJson(Map<String, dynamic> json) => UserPlanModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        user: UserModel.fromJson(json["user"]),
        plan: PlanModel.fromJson(json["plan"]),
        planStart: DateTime.parse(json["planStart"]),
        planEnd: DateTime.parse(json["planEnd"]),
        scheduledClasses: json["scheduledClasses"],
        paymentPhoto: json["paymentPhoto"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        if (createdAt != null) "createdAt": createdAt!.toIso8601String(),
        if (updatedAt != null) "updatedAt": updatedAt!.toIso8601String(),
        "user": user.toJson(),
        "plan": plan.toJson(),
        "planStart": planStart.toIso8601String(),
        "planEnd": planEnd.toIso8601String(),
        "scheduledClasses": scheduledClasses,
        "paymentPhoto": paymentPhoto,
        if (status != null) "status": status,
      };

  /// Deserializar una lista de objetos JSON en una lista de instancias de `UserPlanModel`
  static List<UserPlanModel> listFromJson(dynamic data) {
    return List<UserPlanModel>.from(
      (data as List<dynamic>).map((item) => UserPlanModel.fromJson(item)),
    );
  }
}
