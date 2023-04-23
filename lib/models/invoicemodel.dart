// To parse this JSON data, do
//
//     final invoice = invoiceFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Invo? invoFromJson(String str) {
  Map<String, dynamic> json = jsonDecode(str);
  if (json['order'] == null ||
      json['orderItem'] == null ||
      json['order'].isEmpty ||
      json['orderItem'].isEmpty) {
    return null;
  }
  return Invo.fromJson(json);
}

String invoToJson(Invo order, orderItem) => json.encode({
      'order': order.toJson(),
      'orderItem': orderItem.toJson(),
    });

class Invo {
  Invo({
    required this.order,
    required this.orderItem,
  });

  Invoicing order;
  List<OrderItem> orderItem;

  factory Invo.fromJson(Map<String, dynamic> json) => Invo(
        order: Invoicing.fromJson(json["order"]),
        orderItem: List<OrderItem>.from(
            json["orderItem"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order": order.toJson(),
        "order_item": List<dynamic>.from(orderItem.map((x) => x.toJson())),
      };
}

class Invoicing {
  Invoicing({
    required this.id,
    required this.userId,
    required this.orderId,
    required this.totalAmt,
    required this.discountAmt,
    required this.deliveryCharge,
    required this.address,
    required this.phoneNumber,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.deliveryStatus,
    required this.orderStatus,
    required this.extraInfo,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  String orderId;
  double totalAmt;
  double discountAmt;
  int deliveryCharge;
  String address;
  String phoneNumber;
  String paymentMethod;
  String paymentStatus;
  String deliveryStatus;
  String orderStatus;
  String extraInfo;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Invoicing.fromJson(Map<String, dynamic> json) => Invoicing(
        id: json["id"],
        userId: json["user_id"],
        orderId: json["order_id"],
        totalAmt: json["total_amt"].toDouble(),
        discountAmt: json["discount_amt"].toDouble(),
        deliveryCharge: json["delivery_charge"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        deliveryStatus: json["delivery_status"],
        orderStatus: json["order_status"],
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
        "extra_info": extraInfo,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class OrderItem {
  OrderItem({
    required this.id,
    required this.orderId,
    required this.cartId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int orderId;
  int cartId;
  DateTime createdAt;
  DateTime updatedAt;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json['id'] ?? '',
        orderId: json["order_id"],
        cartId: json["cart_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "cart_id": cartId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
