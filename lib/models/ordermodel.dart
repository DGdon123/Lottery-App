// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    required this.data,
  });

  List<Datum> data;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    this.userId,
    this.orderId,
    this.totalAmt,
    this.discountAmt,
    this.deliveryCharge,
    this.address,
    this.phoneNumber,
    this.paymentMethod,
    this.paymentStatus,
    this.deliveryStatus,
    this.orderStatus,
    this.factoryStatus,
    this.factoryMessage,
    this.extraInfo,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int? userId;
  String? orderId;
  String? totalAmt;
  double? discountAmt;
  int? deliveryCharge;
  String? address;
  String? phoneNumber;
  String? paymentMethod;
  String? paymentStatus;
  String? deliveryStatus;
  String? orderStatus;
  String? factoryStatus;
  String? factoryMessage;
  String? extraInfo;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        orderId: json["order_id"],
        totalAmt: json["total_amt"],
        discountAmt: json["discount_amt"],
        deliveryCharge: json["delivery_charge"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        deliveryStatus: json["delivery_status"],
        orderStatus: json["order_status"],
        factoryStatus: json["factory_status"],
        factoryMessage: json["factory_message"],
        extraInfo: json["extra_info"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_id": orderId,
        "total_amt": totalAmt,
        "discount_amt": discountAmt,
        "delivery_charge": deliveryCharge,
        "address": address,
        "phone_number": phoneNumber,
        "payment_method": paymentMethod,
        "payment_status": paymentStatus,
        "delivery_status": deliveryStatus,
        "order_status": orderStatus,
        "factory_status": factoryStatus,
        "factory_message": factoryMessage,
        "extra_info": extraInfo,
        "deleted_at": deletedAt,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
