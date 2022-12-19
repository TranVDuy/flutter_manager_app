import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_properties.dart';
import 'drawer/drawer_user_controller.dart';
import 'drawer/home_drawer.dart';
import 'orders_controller.dart';

class OrderEdit extends StatefulWidget {
  @override
  State<OrderEdit> createState() => _OrderEditState();
}

class _OrderEditState extends State<OrderEdit> {
  var controller = Get.find<OrdersController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DrawerUserController(
        drawerWidth: MediaQuery.of(context).size.width * 0.75,
        screenView: OrdersPage(),
        //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
      ),
    );
  }
}

class OrdersPage extends StatelessWidget {
  var controller = Get.find<OrdersController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Text(
            "day la noi ma can sua",
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
