class Order {
  String order_id;
  String product_id;
  DateTime created_at;
  DateTime updated_at;
  num quantity;
  num price;

  Order(
      {required this.order_id,
      required this.product_id,
      required this.created_at,
      required this.updated_at,
      required this.quantity,
      required this.price}) {}

  factory Order.fromJson(Map<String, dynamic> obj) {
    return Order(
      order_id: obj["order_id"],
      product_id: obj["product_id"],
      created_at: obj["created_at"],
      updated_at: obj["updated_at"],
      quantity: obj["quantity"].toDouble(),
      price: obj["price"].toDouble(),
    );
  }

  // Map<String, dynamic> toJson() => _$UserToJson(this);
}
