// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:ffi';

import 'package:meta/meta.dart';
import 'dart:convert';

Account? accountFromJson(String str) {
  Map<String, dynamic> json = jsonDecode(str);
  if (json["id"] == null || json["id"] is! int) {
    throw Exception("Invalid 'id' field in JSON data");
  }
  if (json["user_Id"] == null || json["user_Id"] is! int) {
    throw Exception("Invalid 'user_Id' field in JSON data");
  }
  if (json["company_Name"] == null || json["company_Name"] is! String) {
    throw Exception("Invalid 'company_Name' field in JSON data");
  }
  if (json["credit_Balance"] == null || json["credit_Balance"] is! String) {
    throw Exception("Invalid 'credit_Balance' field in JSON data");
  }
  if (json["credit_Limit"] == null || json["credit_Limit"] is! String) {
    throw Exception("Invalid 'credit_Limit' field in JSON data");
  }
  if (json["discount"] == null || json["discount"] is! String) {
    throw Exception("Invalid 'discount' field in JSON data");
  }
  if (json["delivery_Charge"] == null || json["delivery_Charge"] is! int) {
    throw Exception("Invalid 'delivery_Charge' field in JSON data");
  }
  if (json["paid_Amt"] == null || json["paid_Amt"] is! String) {
    throw Exception("Invalid 'paid_Amt' field in JSON data");
  }
  if (json["address"] == null || json["address"] is! String) {
    throw Exception("Invalid 'paid_Amt' field in JSON data");
  }
  if (json["createdAt"] == null || json["createdAt"] is! String) {
    throw Exception("Invalid 'created_at' field in JSON data");
  }
  if (json["updatedAt"] == null || json["updatedAt"] is! String) {
    throw Exception("Invalid 'updated_at' field in JSON data");
  }
  return Account(
    id: json["id"] as int,
    userId: json["user_Id"] as int,
    companyName: json["company_Name"] as String,
    creditBalance: json["credit_Balance"] as String,
    creditLimit: json["credit_Limit"] as String,
    discount: json["discount"] as String,
    deliveryCharge: json["delivery_Charge"] as int,
    paidAmt: json["paid_Amt"] as String,
    address: json["address"] as String,
    createdAt: DateTime.parse(json["createdAt"] as String),
    updatedAt: DateTime.parse(json["updatedAt"] as String),
  );
}

String accountToJson(
        Account id,
        userId,
        companyName,
        creditBalance,
        creditLimit,
        discount,
        deliveryCharge,
        paidAmt,
        address,
        createdAt,
        updatedAt) =>
    json.encode({
      "id": id.toJson(),
      "user_Id": userId.toJson(),
      "company_Name": userId.toJson(),
      "credit_Balance": creditBalance.toJson(),
      "credit_Limit": creditLimit.toJson(),
      "discount": discount.toJson(),
      "delivery_Charge": deliveryCharge.toJson(),
      "paid_Amt": paidAmt.toJson(),
      "address": address.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson()
    });

class Account {
  Account({
    this.id,
    this.userId,
    required this.companyName,
    required this.creditBalance,
    this.creditLimit,
    required this.discount,
    required this.deliveryCharge,
    this.paidAmt,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String companyName;
  String creditBalance;
  String? creditLimit;
  String discount;
  int deliveryCharge;
  String? paidAmt;
  String? address;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"],
        userId: json["user_id"],
        companyName: json["company_name"],
        creditBalance: json["credit_balance"],
        creditLimit: json["credit_limit"],
        discount: json["discount"],
        deliveryCharge: json["delivery_charge"],
        paidAmt: json["paid_amt"],
        address: json["address"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "company_name": companyName,
        "credit_balance": creditBalance,
        "credit_limit": creditLimit,
        "discount": discount,
        "delivery_charge": deliveryCharge,
        "paid_amt": paidAmt,
        "address": address,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
