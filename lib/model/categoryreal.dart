class CategoryReal {
  int id;
  String name;

  CategoryReal({required this.id, required this.name});

  factory CategoryReal.fromJson(Map<String, dynamic> obj){
    return CategoryReal(id: obj["id"], name: obj["name"].toString());
  }
}
