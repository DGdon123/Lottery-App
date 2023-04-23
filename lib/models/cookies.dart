// To parse this JSON data, do
//
//     final cookies = cookiesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Cookies> cookiesFromJson(String str) =>
    List<Cookies>.from(json.decode(str).map((x) => Cookies.fromJson(x)));

String cookiesToJson(List<Cookies> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cookies {
  Cookies({
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
  int? gradeId;
  int? productId;
  int? thicknessId;
  int? sizeId;
  String? quantity;
  String? unit;
  double totalAmt;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Cookies.fromJson(Map<String, dynamic> json) => Cookies(
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
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
