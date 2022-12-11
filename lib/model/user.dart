import 'package:product_manager/model/role.dart';

class User {
  num? id;
  String email;
  String firstname;
  String lastname;
  String phone;
  String address;
  String? password;
  List<Role>? roles;
  String created_at;
  String updated_at;
  String? picture;

  User(
      {required this.email,
      required this.firstname,
      required this.lastname,
      required this.phone,
      required this.address,
      required this.created_at,
      required this.updated_at}) {
    this.picture = "https://robohash.org/${this.firstname}";
  }

  factory User.fromJson(Map<String, dynamic> obj) {
    return User(
      email: obj["email"].toString(),
      firstname: obj["firstname"].toString(),
      lastname: obj["lastname"].toString(),
      phone: obj["phone"].toString(),
      address: obj["address"].toString(),
      created_at: obj["created_at"].toString(),
      updated_at: obj["updated_at"].toString(),
    );
  }

  // Map<String, dynamic> toJson() => _$UserToJson(this);
}
