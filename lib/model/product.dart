class Product {
  String image;
  String name;
  String description;
  double price;

  Product(
      {required this.image,
      required this.name,
      required this.description,
      required this.price});

  factory Product.fromJson(Map<String, dynamic> obj) {
    return Product(
      image: obj["image"],
      name: obj["name"],
      description: obj["description"],
      price: obj["price"],
    );
  }
}
