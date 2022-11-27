import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_manager/pages/roles/roles_controller.dart';

class RolesPage extends StatelessWidget {
  var controller = Get.find<RolesController>();
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
