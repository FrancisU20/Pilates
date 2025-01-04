import 'dart:convert';

UploadS3Response uploadS3ResponseFromJson(String str) => UploadS3Response.fromJson(json.decode(str));

String uploadS3ResponseToJson(UploadS3Response data) => json.encode(data.toJson());

class UploadS3Response {
    bool success;
    String message;
    Data data;
    int statusCode;
    dynamic log;

    UploadS3Response({
        required this.success,
        required this.message,
        required this.data,
        required this.statusCode,
        required this.log,
    });

    factory UploadS3Response.fromJson(Map<String, dynamic> json) => UploadS3Response(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        statusCode: json["statusCode"],
        log: json["log"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
        "statusCode": statusCode,
        "log": log,
    };
}

class Data {
    String path;
    User? user;
    String id;
    DateTime createdAt;
    DateTime updatedAt;

    Data({
        required this.path,
        this.user,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        path: json["path"],
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "path": path,
        "user": user?.toJson(),
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class User {
    String id;
    String dniNumber;
    String name;
    String lastname;
    String password;
    DateTime birthdate;
    String phone;
    String gender;
    String photo;
    String email;
    String role;
    String status;
    DateTime createdAt;
    DateTime updatedAt;

    User({
        required this.id,
        required this.dniNumber,
        required this.name,
        required this.lastname,
        required this.password,
        required this.birthdate,
        required this.phone,
        required this.gender,
        required this.photo,
        required this.email,
        required this.role,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        dniNumber: json["dni_number"],
        name: json["name"],
        lastname: json["lastname"],
        password: json["password"],
        birthdate: DateTime.parse(json["birthdate"]),
        phone: json["phone"],
        gender: json["gender"],
        photo: json["photo"],
        email: json["email"],
        role: json["role"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "dni_number": dniNumber,
        "name": name,
        "lastname": lastname,
        "password": password,
        "birthdate": "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
        "phone": phone,
        "gender": gender,
        "photo": photo,
        "email": email,
        "role": role,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
