import 'package:flutter/material.dart';

import '../../../app_properties.dart';
import '../../../model/product.dart';

class ShopProduct extends StatelessWidget {
  final Product product;

  const ShopProduct(
    this.product,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          children: <Widget>[
            ShopProductDisplay(product),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: darkGrey,
                ),
              ),
            ),
            Text(
              '\$${product.price}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: darkGrey, fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ],
        ));
  }
}

class ShopProductDisplay extends StatelessWidget {
  final Product product;

  const ShopProductDisplay(
    this.product,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 200,
      child: Stack(children: <Widget>[
        Positioned(
          left: 25,
          top: 30,
          child: SizedBox(
            height: 150,
            width: 150,
            child: Transform.scale(
              scale: 1.2,
              child: Image.asset('assets/bottom_yellow.png'),
            ),
          ),
        ),
        Positioned(
          left: 50,
          top: 5,
          child: SizedBox(
            height: 100,
            width: 100,
            child: Image.network(
              '${BASE_IMG}${product.image}',
              height: 100,
              width: 100,
            ),
          ),
        ),
      ]),
    );
  }
}
