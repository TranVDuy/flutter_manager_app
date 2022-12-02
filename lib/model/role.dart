import 'package:flutter/cupertino.dart';

class Role {
  String? name;
  String? image;

  Role({this.name, this.image});
}

List<Role> roles = [
  Role(name: 'Client', image: "assets/client.jpg"),
  Role(name: 'Employee', image: "assets/employee.jpg"),
  Role(name: 'Admin', image: "assets/admin.jpg"),
];