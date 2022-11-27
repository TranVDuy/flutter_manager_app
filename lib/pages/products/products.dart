import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_manager/pages/products/products_controller.dart';

class ProductsPage extends StatelessWidget {
  var controller = Get.find<ProductsController>();
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
