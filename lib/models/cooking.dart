class Cooking {
  Cooking({
    required this.id,
    required this.userId,
    required this.gradeId,
    required this.productId,
    required this.thicknessId,
    required this.priceId,
    required this.size,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int? userId;
  int? gradeId;
  int? productId;
  int? thicknessId;
  int? priceId;
  String? size;
  String? quantity;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Cooking.fromJson(Map<String, dynamic> json) => Cooking(
        id: json["id"],
        userId: json["user_id"],
        gradeId: json["grade_id"],
        productId: json["product_id"],
        thicknessId: json["thickness_id"],
        priceId: json["price_id"],
        size: json["size"],
        quantity: json["quantity"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "grade_id": gradeId,
        "product_id": productId,
        "thickness_id": thicknessId,
        "price_id": priceId,
        "size": size,
        "quantity": quantity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
