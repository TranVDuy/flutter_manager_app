class Order {
  num order_id;
  num user_id;
  String created_at;
  String updated_at;
  String firstname;
  String total_price;
  String payment;

  Order(
      {required this.order_id,
      required this.user_id,
      required this.created_at,
      required this.updated_at,
      required this.firstname,
      required this.total_price,
      required this.payment}) {}

  factory Order.fromJson(Map<String, dynamic> obj) {
    return Order(
      order_id: obj["order_id"],
      user_id: obj["user_id"],
      created_at: obj["created_at"].toString(),
      updated_at: obj["updated_at"].toString(),
      firstname: obj["firstname"],
      total_price: obj["total_price"],
      payment: obj["payment"],
    );
  }

  // Map<String, dynamic> toJson() => _$UserToJson(this);
}
