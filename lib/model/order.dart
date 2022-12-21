import 'dart:convert';

class Order {
  num order_id;
  num user_id;
  String create_at;
  String update_at;
  String firstname;
  String total_price;
  String status;
  List<OrderProduct> product;

  Order(
      {required this.order_id,
      required this.user_id,
      required this.create_at,
      required this.update_at,
      required this.firstname,
      required this.total_price,
      required this.status,
      required this.product}) {}

  factory Order.fromJson(Map<String, dynamic> obj) {
    List<OrderProduct> product = [];
    if (obj['product'] != null) {
      product = (obj['product'] as List)
          .map((data) => OrderProduct.fromJson(data))
          .toList();
    }
    return Order(
      order_id: obj["order_id"],
      user_id: obj["user_id"],
      create_at: obj["create_at"].toString(),
      update_at: obj["update_at"].toString(),
      firstname: obj["firstname"],
      total_price: obj["total_price"],
      status: obj["status"],
      product: product,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "product": product.map((e) => e.toJson()).toList(),
    };
  }
}

class OrderProduct {
  int id;
  String name;
  int quantity;
  int price;
  // int subprice;
  String image;

  OrderProduct(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.price,
      // required this.subprice,
      required this.image});

  factory OrderProduct.fromJson(Map<String, dynamic> obj) {
    return OrderProduct(
      id: obj["id"],
      name: obj["name"].toString(),
      quantity: obj["quantity"],
      price: obj["price"],
      image: obj["image"].toString(),
      // subprice: obj["subprice"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "quantity": this.quantity,
    };
  }
}
