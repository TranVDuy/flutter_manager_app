import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'orders_controller.dart';

class OrdersPage extends StatelessWidget {
  var controller = Get.find<OrdersController>();
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
