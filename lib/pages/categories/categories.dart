import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_manager/pages/categories/categories_controller.dart';

class CategoriesPage extends GetView<CategoriesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(controller.title),
    );
  }
}
