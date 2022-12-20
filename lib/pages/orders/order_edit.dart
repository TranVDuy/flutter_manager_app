import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_manager/model/order.dart';
import '../../app_properties.dart';
import 'drawer/drawer_user_controller.dart';
import 'drawer/home_drawer.dart';
import 'orders_controller.dart';

class OrderEdit extends StatefulWidget {
  final num order_id;

  const OrderEdit({
    super.key,
    required this.order_id,
  });

  @override
  State<OrderEdit> createState() => _OrderEditState();
}

class _OrderEditState extends State<OrderEdit> {
  var controller = Get.find<OrdersController>();
  Order? order;

  @override
  void initState() {
    getOrder();
    super.initState();
  }

  getOrder() async {
    var temp = await controller.findOneOrder(widget.order_id) as Order?;
    setState(() {
      order = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DrawerUserController(
        drawerWidth: MediaQuery.of(context).size.width * 0.75,
        screenView: OrdersPage(context),
        //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
      ),
    );
  }

  Widget OrdersPage(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Text(
            order?.firstname ?? "loz",
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
