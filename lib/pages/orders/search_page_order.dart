import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product_manager/model/category.dart';
import 'package:product_manager/model/order.dart';
import 'package:product_manager/pages/orders/orders_controller.dart';
import 'package:product_manager/pages/products/product_edit.dart';
import 'package:product_manager/pages/products/product_create.dart';
import 'package:product_manager/pages/products/products_controller.dart';
import 'package:product_manager/pages/products/view_product_page.dart';
import 'package:rubber/rubber.dart';
import 'package:get/get.dart';
import '../../app_properties.dart';
import '../../model/product.dart';
import '../categories/categories_controller.dart';
import 'order_edit.dart';

class SearchPageOrder extends StatefulWidget {
  @override
  _SearchPageOrderState createState() => _SearchPageOrderState();
}

class _SearchPageOrderState extends State<SearchPageOrder>
    with SingleTickerProviderStateMixin {
  var controller = Get.find<OrdersController>();
  bool isLoading = false;
  ScrollController scrollController = ScrollController();
  // int totalRecord = 0;
  String selectedPeriod = "";

  List<Order> searchResults = [];
  int page = 1;

  getListOrder(int Page, String search, String Column, String Option) async {
    String sort = Option == "A-Z" ? "asc" : "desc";

    var temp = await controller.getOrders(
      Page,
      search,
      Column,
      sort,
    );
    setState(() {
      searchResults = temp;
    });
  }

  List<String> nameFilter = [
    'A-Z',
    'Z-A',
  ];

  List<Category> categoryFilter = [
    Category(
      const Color(0xffFCE183),
      const Color(0xffF68D7F),
      0,
      'All',
      '',
    ),
  ];

  List<String> priceFilter = ['Low to High', 'High to Low'];

  TextEditingController searchController = TextEditingController();
  Timer? _debounce;
  String searchValue = "";

  late RubberAnimationController _controller;

  @override
  void initState() {
    _controller = RubberAnimationController(
        vsync: this,
        halfBoundValue: AnimationControllerValue(percentage: 0.4),
        upperBoundValue: AnimationControllerValue(percentage: 0.4),
        lowerBoundValue: AnimationControllerValue(pixel: 50),
        duration: const Duration(milliseconds: 200));
    selectedPeriod = "A-Z";
    searchValue = "";
    page = 1;
    getListOrder(page, searchValue, "firstname", selectedPeriod);
    scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  getMoreOrders(int Page, String search, String Column, String Option) async {
    String sort = Option == "A-Z" ? "asc" : "desc";

    var temp = await controller.getOrders(
      Page,
      search,
      Column,
      sort,
    );

    return temp;
  }

  void _scrollListener() async {
    // if (totalRecord == searchResults.length) {
    //   return;
    // }
    if (scrollController.position.extentAfter <= 0) {
      setState(() {
        page++;
      });
      var items =
          await getMoreOrders(page, searchValue, "firstname", selectedPeriod);

      setState(() {
        searchResults.addAll(items);
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _expand() {
    _controller.expand();
  }

  Widget _getLowerLayer() {
    return Container(
      margin: const EdgeInsets.only(top: kToolbarHeight),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Order List',
                  style: TextStyle(
                    color: darkGrey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16.0),
            height: 56,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 223, 217, 217),
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),

            //Search-Order

            child: Center(
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  OnSearchChanged(value);
                },
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: "Search Order",
                  prefixIcon: Icon(Icons.search),
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFBDBDBD),
                  ),
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF212121),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Center(
                child: searchResults.length == 0
                    ? Container(
                        alignment: Alignment.center,
                        child: Text(
                          "No Results",
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                      )
                    : Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: isLoading
                            ? Opacity(
                                opacity: 0.80,
                                child: Container(
                                  alignment: Alignment.center,
                                  color: Colors.white70,
                                  child: const CircularProgressIndicator(),
                                ))
                            : ListView(
                                controller: scrollController,
                                children: searchResults
                                    .map((searchResult) => Slidable(
                                          actionPane:
                                              const SlidableDrawerActionPane(),
                                          actionExtentRatio: 0.25,
                                          secondaryActions: <Widget>[
                                            IconSlideAction(
                                                caption: 'Pay',
                                                color: searchResult.status !=
                                                        "payment"
                                                    ? Colors.green
                                                    : Colors.grey,
                                                icon: Icons.payment,
                                                onTap: () {
                                                  if (searchResult.status !=
                                                      "payment") {
                                                    showPayAlert(
                                                        context, searchResult);
                                                  }
                                                }),
                                            IconSlideAction(
                                              caption: 'Edit',
                                              color: Colors.blueAccent,
                                              icon: Icons.edit,
                                              // onTap: () => Navigator.of(context)
                                              //     .push(MaterialPageRoute(
                                              //         builder: (_) =>
                                              //             ProductEdit(
                                              //               product:
                                              //                   searchResult,
                                              //               callBack:
                                              //                   editCallBack,
                                              //               idCategory:
                                              //                   searchResult
                                              //                       .category[0]
                                              //                       .id,
                                              //             ))),
                                              onTap: () => Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                      builder: (_) => OrderEdit(
                                                          order_id: searchResult
                                                              .order_id))),
                                            ),
                                            IconSlideAction(
                                                caption: 'Delete',
                                                color: searchResult.status !=
                                                        "payment"
                                                    ? Colors.red
                                                    : Colors.grey,
                                                icon: Icons.delete,
                                                onTap: () {
                                                  if (searchResult.status !=
                                                      "payment") {
                                                    showDeleteAlert(
                                                        context, searchResult);
                                                  }
                                                })
                                          ],
                                          child: InkWell(
                                            // onTap: () => Navigator.of(context)
                                            //     .push(MaterialPageRoute(
                                            //         builder: (_) =>
                                            //             ViewProductPage(
                                            //               product: searchResult,
                                            //             ))),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 16.0),
                                                          child: CircleAvatar(
                                                            maxRadius: 24,
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    "https://robohash.org/${searchResult.user_id}"),
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          16.0),
                                                              child: Text(
                                                                  "${searchResult.firstname} - ${searchResult.order_id}"
                                                                              .length >
                                                                          20
                                                                      ? '${"${searchResult.firstname} - ${searchResult.order_id}".substring(0, 20)}...'
                                                                      : "${searchResult.firstname} - ${searchResult.order_id}",
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          16.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 8.0,
                                                                      bottom:
                                                                          16.0),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                      '\$${searchResult.total_price}',
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16.0,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.red)),
                                                                  // const Icon(Icons.money)
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Text(searchResult.status,
                                                        style: const TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 64.0),
                                                  child: Divider(),
                                                )
                                              ],
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                      ),
              )),
        ],
      ),
    );
  }

  Widget _getUpperLayer() {
    return Container(
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                offset: Offset(0, -3),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(24), topLeft: Radius.circular(24)),
          color: Colors.white),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        //  controller: _scrollController,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Filters',
                style: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 32.0, top: 16.0, bottom: 16.0),
              child: Text(
                'Sort By',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),

          //Sort firstname A-Z or Z-A
          Container(
            height: 50,
            child: ListView.builder(
              itemBuilder: (_, index) => Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: InkWell(
                    onTap: () {
                      page = 1;
                      setState(() {
                        selectedPeriod = nameFilter[index];
                        getListOrder(
                            page, searchValue, "firstname", selectedPeriod);
                      });
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 20.0),
                        decoration: selectedPeriod == nameFilter[index]
                            ? const BoxDecoration(
                                color: Color(0xffFDB846),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45)))
                            : const BoxDecoration(),
                        child: Text(
                          nameFilter[index],
                          style: const TextStyle(fontSize: 16.0),
                        ))),
              )),
              itemCount: nameFilter.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
            body: RubberBottomSheet(
          lowerLayer: _getLowerLayer(), // The underlying page (Widget)
          upperLayer: _getUpperLayer(), // The bottomsheet content (Widget)
          animationController: _controller, // The one we created earlier
        )),
      ),
    );
  }

  //Tìm kiếm sản phẩm
  OnSearchChanged(value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (this.searchValue != searchController.text) {
        page = 1;
        setState(() {
          searchValue = value;
          getListOrder(page, searchValue, "firstname", selectedPeriod);
        });
      }
      this.searchValue = searchController.text;
    });
  }

  //Show Snackbar
  buildFlashMessage(String status, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
          height: 70,
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
              color: (status == "success" ? Colors.green : Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                message,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              (status == "success"
                  ? const Icon(Icons.check_circle_outline_outlined,
                      color: Colors.white, size: 20)
                  : const Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 30,
                    ))
            ],
          )),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  //Load list product
  RerenderList() {
    getListOrder(page, searchValue, "firstname", selectedPeriod);
  }

  DeleteOrder(BuildContext context, Order item) async {
    bool check;
    setState(() {
      isLoading = true;
    });
    check = await controller.deleteOrder(item.order_id);
    setState(() {
      isLoading = false;
    });
    if (check) {
      buildFlashMessage("success", 'Xóa thành công!');
      RerenderList();
    } else {
      buildFlashMessage("error", 'Xóa thất bại!');
    }
  }

  PayOrder(BuildContext context, Order item) async {
    bool check;
    setState(() {
      isLoading = true;
    });
    check = await controller.payOrder(item.order_id);
    setState(() {
      isLoading = false;
    });
    if (check) {
      buildFlashMessage("success", 'Thanh toán thành công!');
      RerenderList();
    } else {
      buildFlashMessage("error", 'Thanh toán thất bại!');
    }
  }

  showDeleteAlert(BuildContext context, item) {
    // set up the buttons
    Widget noButton = TextButton(
      child: const Text(
        "No",
        style: TextStyle(color: Colors.blue),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget yesButton = TextButton(
      child: const Text("Yes", style: TextStyle(color: Colors.red)),
      onPressed: () {
        Navigator.pop(context);
        DeleteOrder(context, item);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Message"),
      content: const Text("Would you like to delete this order?"),
      actions: [
        noButton,
        yesButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showPayAlert(BuildContext context, item) {
    // set up the buttons
    Widget noButton = TextButton(
      child: const Text(
        "No",
        style: TextStyle(color: Colors.blue),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget yesButton = TextButton(
      child: const Text("Yes", style: TextStyle(color: Colors.red)),
      onPressed: () {
        Navigator.pop(context);
        PayOrder(context, item);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Message"),
      content: const Text(
          "Would you like to change status of this order to payment?"),
      actions: [
        noButton,
        yesButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void editCallBack() {
    RerenderList();
  }
}
