import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_manager/pages/users/users_controller.dart';

class UsersPage extends StatelessWidget {
  var controller = Get.find<UsersController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            controller.title,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
