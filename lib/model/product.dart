class Product {
  String image;
  String name;
  String description;
  String price;

  Product(
      {required this.image,
      required this.name,
      required this.description,
      required this.price});

  factory Product.fromJson(Map<String, dynamic> obj) {
    return Product(
      image: obj["image"].toString(),
      name: obj["name"].toString(),
      description: obj["description"].toString(),
      price: obj["price"].toString(),
    );
  }
}
