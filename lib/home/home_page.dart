import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_manager/home/home_controller.dart';

class HomePage extends StatelessWidget {
  var controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          controller.title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
