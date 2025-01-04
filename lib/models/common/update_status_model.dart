import 'dart:convert';


UpdateStatusModel updateStatusModelModelFromJson(String str) =>
    UpdateStatusModel.fromJson(json.decode(str));

String updateStatusModelModelToJson(UpdateStatusModel data) =>
    json.encode(data.toJson());

class UpdateStatusModel {
  String status;

  UpdateStatusModel({
    required this.status, // Opcional
  });

  factory UpdateStatusModel.fromJson(Map<String, dynamic> json) =>
      UpdateStatusModel(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };

  /// Deserializar una lista de objetos JSON en una lista de instancias de `UpdateStatusModel`
  static List<UpdateStatusModel> listFromJson(dynamic data) {
    return List<UpdateStatusModel>.from(
      (data as List<dynamic>).map((item) => UpdateStatusModel.fromJson(item)),
    );
  }
}
