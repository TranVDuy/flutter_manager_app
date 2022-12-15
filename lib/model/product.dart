import 'dart:convert';

import 'package:product_manager/model/categoryreal.dart';

class Product {
  String image;
  String name;
  String description;
  String price;
  String id;
  List<CategoryReal> category;

  Product(
      {required this.image,
      required this.name,
      required this.description,
      required this.price,
      required this.id,
      required this.category});



  factory Product.fromJson(Map<String, dynamic> obj) {

    return Product(
        image: obj["image"].toString(),
        name: obj["name"].toString(),
        description: obj["description"].toString(),
        price: obj["price"].toString(),
        id: obj['id'].toString(),
        category: (obj['category'] as List)
        .map((data) => CategoryReal.fromJson(data))
        .toList()
    );
  }
}
