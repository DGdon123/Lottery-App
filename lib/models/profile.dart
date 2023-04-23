// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Post? postFromJson(String str) {
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
  if (json["address"] == null) {
    throw Exception("Invalid 'address' field in JSON data");
  }
  if (json["image"] == null) {
    throw Exception("Invalid 'image' field in JSON data");
  }
  if (json["createdAt"] == null || json["createdAt"] is! String) {
    throw Exception("Invalid 'created_at' field in JSON data");
  }
  if (json["updatedAt"] == null || json["updatedAt"] is! String) {
    throw Exception("Invalid 'updated_at' field in JSON data");
  }
  return Post(
    id: json["id"] as int,
    name: json["name"] as String,
    userType: json["user_Type"] as String,
    email: json["email"] as String,
    phone: json["phone"],
    address: json["address"] as String,
    image: json["image"],
    createdAt: DateTime.parse(json["createdAt"] as String),
    updatedAt: DateTime.parse(json["updatedAt"] as String),
  );
}

String postToJson(Post id, name, userType, email, phone, address, image,
        emailVerifiedAt, createdAt, updatedAt) =>
    json.encode({
      'id': id.toJson(),
      'name': name.toJson(),
      'user_Type': userType.toJson(),
      'email': email.toJson(),
      'phone': phone.toJson(),
      'address': address.toJson(),
      'image': image.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson()
    });

class Post {
  Post({
    this.id,
    this.name,
    this.userType,
    this.email,
    this.phone,
    this.address,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? userType;
  String? email;
  dynamic phone;
  String? address;
  dynamic image;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        name: json["name"],
        userType: json["user_type"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "user_type": userType,
        "email": email,
        "phone": phone,
        "address": address,
        "image": image,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
