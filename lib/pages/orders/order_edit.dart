import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_properties.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: darkGrey),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Text(
            controller.title,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
