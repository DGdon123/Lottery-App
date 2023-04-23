// To parse this JSON data, do
//
//     final items = itemsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Items itemsFromJson(String str) => Items.fromJson(json.decode(str));

String itemsToJson(Items data) => json.encode(data.toJson());

class Items {
  Items({
    required this.items,
  });

  List<Item> items;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    required this.id,
    required this.userId,
    required this.gradeId,
    required this.productId,
    required this.thicknessId,
    required this.sizeId,
    required this.quantity,
    required this.unit,
    required this.totalAmt,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  int gradeId;
  int productId;
  int thicknessId;
  int sizeId;
  String quantity;
  String unit;
  double totalAmt;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        userId: json["user_id"],
        gradeId: json["grade_id"],
        productId: json["product_id"],
        thicknessId: json["thickness_id"],
        sizeId: json["size_id"],
        quantity: json["quantity"],
        unit: json["unit"],
        totalAmt: json["total_amt"].toDouble(),
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "grade_id": gradeId,
        "product_id": productId,
        "thickness_id": thicknessId,
        "size_id": sizeId,
        "quantity": quantity,
        "unit": unit,
        "total_amt": totalAmt,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
