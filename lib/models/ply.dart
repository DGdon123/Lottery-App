// To parse this JSON data, do
//
//     final ply = plyFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Ply plyFromJson(String str) => Ply.fromJson(json.decode(str));

String plyToJson(Ply data) => json.encode(data.toJson());

class Ply {
  Ply({
    required this.success,
    required this.grade,
    required this.product,
    required this.thickness,
    required this.price,
    required this.size,
    required this.message,
  });

  bool success;
  List<Grade> grade;
  List<Product> product;
  List<Thickness> thickness;
  List<Price> price;
  List<Size> size;
  String message;

  factory Ply.fromJson(Map<String, dynamic> json) => Ply(
        success: json["success"],
        grade: List<Grade>.from(json["grade"].map((x) => Grade.fromJson(x))),
        product:
            List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
        thickness: List<Thickness>.from(
            json["thickness"].map((x) => Thickness.fromJson(x))),
        price: List<Price>.from(json["price"].map((x) => Price.fromJson(x))),
        size: List<Size>.from(json["size"].map((x) => Size.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "grade": List<dynamic>.from(grade.map((x) => x.toJson())),
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
        "thickness": List<dynamic>.from(thickness.map((x) => x.toJson())),
        "price": List<dynamic>.from(price.map((x) => x.toJson())),
        "size": List<dynamic>.from(size.map((x) => x.toJson())),
        "message": message,
      };
}

class Grade {
  Grade({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String title;
  DateTime createdAt;
  DateTime updatedAt;

  factory Grade.fromJson(Map<String, dynamic> json) => Grade(
        id: json["id"],
        title: json["title"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Price {
  Price({
    required this.id,
    required this.gradeId,
    required this.productId,
    required this.thicknessId,
    required this.ftPrice,
    required this.mtrPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int gradeId;
  int productId;
  int thicknessId;
  int ftPrice;
  int mtrPrice;
  DateTime createdAt;
  DateTime updatedAt;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        id: json["id"],
        gradeId: json["grade_id"],
        productId: json["product_id"],
        thicknessId: json["thickness_id"],
        ftPrice: json["ft_price"],
        mtrPrice: json["mtr_price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "grade_id": gradeId,
        "product_id": productId,
        "thickness_id": thicknessId,
        "ft_price": ftPrice,
        "mtr_price": mtrPrice,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Product {
  Product({
    required this.id,
    required this.gradeId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int gradeId;
  String title;
  dynamic description;
  DateTime createdAt;
  DateTime updatedAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        gradeId: json["grade_id"],
        title: json["title"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "grade_id": gradeId,
        "title": title,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Size {
  Size({
    required this.id,
    required this.title,
    required this.sqft,
    required this.sqmtr,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String title;
  int sqft;
  double sqmtr;
  DateTime createdAt;
  DateTime updatedAt;

  factory Size.fromJson(Map<String, dynamic> json) => Size(
        id: json["id"],
        title: json["title"],
        sqft: json["sqft"],
        sqmtr: json["sqmtr"].toDouble(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "sqft": sqft,
        "sqmtr": sqmtr,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Thickness {
  Thickness({
    required this.id,
    required this.gradeId,
    required this.productId,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int gradeId;
  int productId;
  String title;
  DateTime createdAt;
  DateTime updatedAt;

  factory Thickness.fromJson(Map<String, dynamic> json) => Thickness(
        id: json["id"],
        gradeId: json["grade_id"],
        productId: json["product_id"],
        title: json["title"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "grade_id": gradeId,
        "product_id": productId,
        "title": title,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
