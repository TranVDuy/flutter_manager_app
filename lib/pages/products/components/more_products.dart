import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_manager/pages/products/components/product_card.dart';

import '../../../app_properties.dart';
import '../../../model/product.dart';
import '../products_controller.dart';

class MoreProducts extends StatefulWidget {
  final Product product;
  MoreProducts({required this.product});

  @override
  State<MoreProducts> createState() => _MoreProductsState();
}

class _MoreProductsState extends State<MoreProducts> {
  late List<Product> products = [];
  var controller = Get.find<ProductsController>();

  getListProduct(int Page, String selectedCategory, String search,
      String Column, String Option) async {
    String sort = "";
    var temp;
    if (Column == "name") {
      sort = Option == "A-Z" ? "asc" : "desc";
    } else {
      sort = Option == "Low to High" ? "asc" : "desc";
    }

    if (selectedCategory == "0") {
      temp = await controller.getProducts(Page, search, Column, sort, []);
    } else {
      temp = await controller
          .getProducts(Page, search, Column, sort, [selectedCategory]);
    }

    setState(() {
      products = temp;
    });
  }

  @override
  initState() {
    getListProduct(
        1, widget.product.category[0].id.toString(), "", "name", "0");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 24.0, bottom: 8.0),
          child: Text(
            'More products',
            style: TextStyle(color: Colors.white, shadows: shadow),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 20.0),
          height: 250,
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (_, index) {
              return Padding(

                  ///calculates the left and right margins
                  ///to be even with the screen margin
                  padding: index == 0
                      ? const EdgeInsets.only(left: 24.0, right: 8.0)
                      : index == 4
                          ? const EdgeInsets.only(right: 24.0, left: 8.0)
                          : const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ProductCard(products[index]));
            },
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }
}
