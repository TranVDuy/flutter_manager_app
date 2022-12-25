import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_properties.dart';
import '../../../model/product.dart';
import '../view_product_controller.dart';
import 'shop_bottomSheet.dart';

class ProductOption extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  var controller = Get.find<ViewProductController>();
  // final Product product;
  ProductOption(
    this.scaffoldKey);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 16.0,
            child: Image.network(
              '${BASE_IMG}${controller.productView.image}',
              height: 200,
              width: 200,
            ),
          ),
          Positioned(
            right: 0.0,
            child: Container(
              height: 180,
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(controller.productView.name,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: shadow)),
                  ),
                  InkWell(
                    onTap: () async {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (_) => CheckOutPage()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          gradient: mainButton,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0))),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: Text(
                          '\$${controller.productView.price.toString()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
