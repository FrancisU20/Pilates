import 'dart:convert';

MostPopularPlanResponse mostPopularPlanResponseFromJson(String str) =>
    MostPopularPlanResponse.fromJson(json.decode(str));

String mostPopularPlanResponseToJson(MostPopularPlanResponse data) =>
    json.encode(data.toJson());

class MostPopularPlanResponse {
  String planId;
  String total;

  MostPopularPlanResponse({
    required this.planId,
    required this.total,
  });

  factory MostPopularPlanResponse.fromJson(Map<String, dynamic> json) =>
      MostPopularPlanResponse(
        planId: json["plan_id"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "plan_id": planId,
        "total": total,
      };
}
