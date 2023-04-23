// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

Cart? cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart? data) => json.encode(data!.toJson());

class Cart {
  Cart({
    this.data,
  });

  Data? data;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.userId,
    this.gradeId,
    this.productId,
    this.thicknessId,
    this.sizeId,
    this.quantity,
    this.unit,
    this.totalAmt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  int? gradeId;
  int? productId;
  int? thicknessId;
  int? sizeId;
  String? quantity;
  String? unit;
  int? totalAmt;

  DateTime? updatedAt;
  DateTime? createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        gradeId: json["grade_id"],
        productId: json["product_id"],
        thicknessId: json["thickness_id"],
        sizeId: json["size_id"],
        quantity: json["quantity"],
        unit: json["unit"],
        totalAmt: json["total_amt"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
