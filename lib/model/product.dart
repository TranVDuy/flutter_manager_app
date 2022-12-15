import 'dart:convert';

class Product {
  String image;
  String name;
  String description;
  String price;
  String id;
  String category;

  Product(
      {required this.image,
      required this.name,
      required this.description,
      required this.price,
      required this.id,
      required this.category});



  factory Product.fromJson(Map<String, dynamic> obj) {
    var temp = jsonDecode(obj["category"].toString());
    return Product(
        image: obj["image"].toString(),
        name: obj["name"].toString(),
        description: obj["description"].toString(),
        price: obj["price"].toString(),
        id: obj['id'].toString(),
        category: temp["id"].toString()
    );
  }
}
