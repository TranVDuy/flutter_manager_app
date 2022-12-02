import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_manager/pages/roles/carousel/carousel.dart';
import 'package:product_manager/pages/roles/roles_controller.dart';

class RolesPage extends StatelessWidget {
  var controller = Get.find<RolesController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: const Carousel(),
      ),
    );
  }
}
