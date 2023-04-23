// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';

Payment paymentFromJson(String str) => Payment.fromJson(json.decode(str));

String paymentToJson(Payment data) => json.encode(data.toJson());

class Payment {
  Payment({
    required this.data,
  });

  List<Pay> data;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        data: List<Pay>.from(json["data"].map((x) => Pay.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Pay {
  Pay({
    this.id,
    this.userId,
    required this.amount,
    this.paymentMethod,
    this.proofImage,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String amount;
  String? paymentMethod;
  dynamic proofImage;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Pay.fromJson(Map<String, dynamic> json) => Pay(
        id: json["id"],
        userId: json["user_id"],
        amount: json["amount"],
        paymentMethod: json["payment_method"],
        proofImage: json["proof_image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "amount": amount,
        "payment_method": paymentMethod,
        "proof_image": proofImage,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
