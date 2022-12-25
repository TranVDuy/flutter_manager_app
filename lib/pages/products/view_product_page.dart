import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view_product_controller.dart';

import '../../app_properties.dart';
import '../../model/product.dart';
import 'components/color_list.dart';
import 'components/more_products.dart';
import 'components/product_options.dart';
import 'components/rating_bottomSheet.dart';

class ViewProductPage extends StatefulWidget {

  @override
  _ViewProductPageState createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  var controller = Get.find<ViewProductController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int active = 0;
  ///list of product colors
  List<Widget> colors() {
    List<Widget> list = [];
    for (int i = 0; i < 5; i++) {
      list.add(
        InkWell(
          onTap: () {
            setState(() {
              active = i;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Transform.scale(
              scale: active == i ? 1.2 : 1,
              child: Card(
                elevation: 3,
                color: Colors.primaries[i],
                child: const SizedBox(
                  height: 32,
                  width: 32,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    Widget description = Padding(
      padding: const EdgeInsets.all(24.0),
      child: Text(
        controller.productView.description,
        maxLines: 5,
        semanticsLabel: '...',
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.white),
      ),
    );

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: yellow,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: darkGrey),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                // ProductOption(
                //   _scaffoldKey,
                //   // product: controller.productView,
                // ),
              SizedBox(
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
            ),
                description,
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Flexible(
                      child: ColorList(const [
                        Colors.red,
                        Colors.blue,
                        Colors.purple,
                        Colors.green,
                        Colors.yellow
                      ]),
                    ),
                    RawMaterialButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return RatingBottomSheet(product: controller.productView);
                          },
                          elevation: 0,
                          backgroundColor: Colors.transparent
                        );
                      },
                      constraints:
                          const BoxConstraints(minWidth: 45, minHeight: 45),
                      child: Icon(Icons.favorite,
                          color: Color.fromRGBO(255, 137, 147, 1)),
                      elevation: 0.0,
                      shape: const CircleBorder(),
                      fillColor: const Color.fromRGBO(255, 255, 255, 0.4),
                    ),
                  ]),
                ),
                MoreProducts(
                  // product: controller.productView,
                )
              ],
            ),
          ),
        ));
  }
}
