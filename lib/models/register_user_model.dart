// To parse this JSON data, do
//
//     final registerUserModel = registerUserModelFromJson(jsonString);

import 'dart:convert';

RegisterUserModel registerUserModelFromJson(String str) =>
    RegisterUserModel.fromJson(json.decode(str));

String registerUserModelToJson(RegisterUserModel data) =>
    json.encode(data.toJson());

class RegisterUserModel {
  final String message;
  final String? token; // Bisa null
  final User? user; // Bisa null

  RegisterUserModel({required this.message, this.token, this.user});

  factory RegisterUserModel.fromJson(Map<String, dynamic> json) =>
      RegisterUserModel(
        message: json["message"] ?? "Success", // Default value
        token: json["token"], // Bisa null
        user: json["user"] != null
            ? User.fromJson(json["user"])
            : null, // Handle null
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "token": token,
    "user": user?.toJson(),
  };
}

class User {
  final int id;
  final String name;
  final String email;
  final dynamic emailVerifiedAt;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    email: json["email"] ?? "",
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"] ?? "",
    updatedAt: json["updated_at"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

// import 'dart:convert';

// RegisterUserModel registerUserModelFromJson(String str) =>
//     RegisterUserModel.fromJson(json.decode(str));

// String registerUserModelToJson(RegisterUserModel data) =>
//     json.encode(data.toJson());

// class RegisterUserModel {
//   String? message;
//   String? token;
//   User? user;

//   RegisterUserModel({this.message, this.token, this.user});

//   factory RegisterUserModel.fromJson(Map<String, dynamic> json) =>
//       RegisterUserModel(
//         message: json["message"],
//         token: json["token"], // Token langsung di root
//         user: json["user"] == null ? null : User.fromJson(json["user"]),
//       );

//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "token": token,
//     "user": user?.toJson(),
//   };
// }

// class User {
//   int? id;
//   String? name;
//   String? email;
//   dynamic emailVerifiedAt;
//   String? createdAt;
//   String? updatedAt;

//   User({
//     this.id,
//     this.name,
//     this.email,
//     this.emailVerifiedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory User.fromJson(Map<String, dynamic> json) => User(
//     id: json["id"],
//     name: json["name"],
//     email: json["email"],
//     emailVerifiedAt: json["email_verified_at"],
//     createdAt: json["created_at"],
//     updatedAt: json["updated_at"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "email": email,
//     "email_verified_at": emailVerifiedAt,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//   };
// }
