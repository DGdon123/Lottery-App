// To parse this JSON data, do
//
//     final posting = postingFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Posting? postingFromJson(String str) {
  Map<String, dynamic> json = jsonDecode(str);
  if (json["id"] == null || json["id"] is! int) {
    throw Exception("Invalid 'id' field in JSON data");
  }
  if (json["name"] == null || json["name"] is! String) {
    throw Exception("Invalid 'name' field in JSON data");
  }
  if (json["user_Type"] == null || json["user_Type"] is! String) {
    throw Exception("Invalid 'user_Type' field in JSON data");
  }
  if (json["email"] == null || json["email"] is! String) {
    throw Exception("Invalid 'email' field in JSON data");
  }
  if (json["phone"] == null) {
    throw Exception("Invalid 'phone' field in JSON data");
  }
  if (json["image"] == null) {
    throw Exception("Invalid 'image' field in JSON data");
  }
  if (json["emailVerifiedAt"] == null || json["emailVerifiedAt"] is! String) {
    throw Exception("Invalid 'email_verified_at' field in JSON data");
  }
  if (json["createdAt"] == null || json["createdAt"] is! String) {
    throw Exception("Invalid 'created_at' field in JSON data");
  }
  if (json["updatedAt"] == null || json["updatedAt"] is! String) {
    throw Exception("Invalid 'updated_at' field in JSON data");
  }
  return Posting(
    id: json["id"] as int,
    name: json["name"] as String,
    userType: json["user_Type"] as String,
    email: json["email"] as String,
    phone: json["phone"],
    image: json["image"],
    emailVerifiedAt: DateTime.parse(json["emailVerifiedAt"] as String),
    createdAt: DateTime.parse(json["createdAt"] as String),
    updatedAt: DateTime.parse(json["updatedAt"] as String),
  );
}

String postingToJson(Posting id, name, userType, email, phone, image,
        emailVerifiedAt, createdAt, updatedAt) =>
    json.encode({
      'id': id.toJson(),
      'name': name.toJson(),
      'userType': userType.toJson(),
      'email': email.toJson(),
      'phone': phone.toJson(),
      'image': image.toJson(),
      'emailVerifiedAt': emailVerifiedAt.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson()
    });

class Posting {
  Posting({
    this.id,
    this.name,
    this.userType,
    this.email,
    this.phone,
    this.image,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? userType;
  String? email;
  dynamic phone;
  dynamic image;
  DateTime? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Posting.fromJson(Map<String, dynamic> json) => Posting(
        id: json["id"],
        name: json["name"],
        userType: json["user_type"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "user_type": userType,
        "email": email,
        "phone": phone,
        "image": image,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
