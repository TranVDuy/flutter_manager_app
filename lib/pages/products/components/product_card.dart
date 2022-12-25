import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_product_controller.dart';
import 'package:product_manager/pages/products/view_product_page.dart';

import '../../../app_properties.dart';
import '../../../model/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  var controller = Get.find<ViewProductController>();

  ProductCard(this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          controller.handleChangeProductView(product);
        },
        child: Container(
            height: 250,
            width: MediaQuery.of(context).size.width / 2 - 29,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: const Color(0xfffbd085).withOpacity(0.46)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    width: MediaQuery.of(context).size.width / 2 - 64,
                    height: MediaQuery.of(context).size.width / 2 - 64,
                    child: Image.network(
                      '${BASE_IMG}${product.image}',
                    ),
                  ),
                ),
                Flexible(
                  child: Align(
                    alignment: const Alignment(1, 0.5),
                    child: Container(
                        margin: const EdgeInsets.only(left: 16.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: const Color(0xffe0450a).withOpacity(0.51),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        child: Text(
                          product.name,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        )),
                  ),
                )
              ],
            )));
  }
}
