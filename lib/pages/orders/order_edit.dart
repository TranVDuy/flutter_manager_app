import 'dart:math';

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
    controller.orderEdit = temp;
    setState(() {
      order = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DrawerUserController(
        title: "${order?.firstname} - ${order?.order_id}",
        drawerWidth: MediaQuery.of(context).size.width * 0.9,
        screenView: OrdersPage(context),
        //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
      ),
    );
  }

  Widget OrdersPage(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: const Color(0xffebebeb),
        child: Column(
          children: [
            buildOrderProductInfo(size),
            Expanded(child: buildOrderProductSlider(size)),
            buildSubmit(context)
          ],
        ),
      ),
    );
  }

  Padding buildOrderProductInfo(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.035,
        vertical: size.height * 0.025,
      ),
      child: Container(
        height: size.height * 0.19,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: InkWell(
          onTap: () {},
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.023,
                    horizontal: size.width * 0.025,
                  ),
                  child: Image.asset(
                    "duytran.jpg",
                    errorBuilder: (context, error, stackTrace) {
                      return const CircularProgressIndicator.adaptive();
                    },
                    height: 70,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: size.width * 0.88,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.01,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.orderEdit?.firstname ?? "",
                          style: TextStyle(
                            fontSize: size.width * 0.036,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${controller.orderEdit?.total_price}\$".toString() ??
                              "",
                          style: TextStyle(
                            fontSize: size.width * 0.036,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.88,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: size.height * 0.01,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.orderEdit?.status ?? "",
                          style: TextStyle(
                            fontSize: size.width * 0.03,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        Text(
                          "Created at:  ${controller.orderEdit?.create_at}",
                          style: TextStyle(
                            fontSize: size.width * 0.03,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildOrderProductSlider(Size size) {
    return SizedBox(
      width: size.width,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: controller.orderEdit?.product.length,
        itemBuilder: (context, i) {
          return buidOrderProduct(size, i);
        },
      ),
    );
  }

  Padding buidOrderProduct(Size size, int i) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
        vertical: size.height * 0.015,
      ),
      child: Container(
        height: size.height * 0.08,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: InkWell(
          onTap: () {
            // Get.to(
            //   DetailsPage(
            //     name: shoes[i]['name'],
            //     userName: shoes[i]['userName'],
            //     userFollowers: shoes[i]['userFollowers'],
            //     description: shoes[i]['description'],
            //     price: shoes[i]['price'],
            //     size: shoes[i]['size'],
            //     isRotated: shoes[i]['isRotated'],
            //     userImage: shoes[i]['userImage'],
            //     image: shoes[i]['image'],
            //   ),
            // );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02,
            ),
            child: Row(
              children: [
                true
                    ? Image.network(
                        "${BASE_IMG}${controller.orderEdit?.product[i].image ?? ""}",
                        errorBuilder: (context, error, stackTrace) {
                          return const CircularProgressIndicator.adaptive();
                        },
                        width: size.width * 0.18,
                      )
                    : Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(pi),
                        child: Image.network(
                          "${BASE_IMG}${controller.orderEdit?.product[i].image ?? ""}",
                          errorBuilder: (context, error, stackTrace) {
                            return const CircularProgressIndicator.adaptive();
                          },
                          width: size.width * 0.18,
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.06,
                    vertical: size.height * 0.019,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${controller.orderEdit?.product[i].name ?? ""}"
                                    .length >
                                20
                            ? "${controller.orderEdit?.product[i].name.substring(0, 20) ?? ""}..."
                            : "${controller.orderEdit?.product[i].name ?? ""}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: size.width * 0.035,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        controller.orderEdit?.product[i].price.toString() ?? "",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: size.width * 0.03,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.019,
                    horizontal: size.width * 0.012,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${controller.orderEdit?.product[i].price}\$"
                            .toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: size.width * 0.035,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "x ${controller.orderEdit?.product[i].quantity}"
                            .toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: size.width * 0.03,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSubmit(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            minimumSize: const Size.fromHeight(50),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        onPressed: () async {
          // if (_formKey.currentState!.validate()) {
          //   final name = controllerName.text;
          //   final price = controllerPrice.text;
          //   final description = controllerDescription.text;
          //   setState(() {
          //     isLoading = true;
          //   });
          //   var check = await product_controller.editProduct(widget.product.id,
          //       Cate.toString(), name, description, num.parse(price), webImage);
          //   setState(() {
          //     isLoading = false;
          //   });
          //   check
          //       ? buildFlashMessage("success", 'Update thành công!')
          //       : buildFlashMessage("error", 'Update thất bại!');
          //   if (check) widget.callBack();
          //   Navigator.pop(context);
          // }
          Navigator.pop(context);
        },
        child: const Text("Update"),
      ),
    );
  }
}
