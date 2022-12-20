import 'package:flutter/material.dart';
import 'package:product_manager/app_properties.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product_manager/model/category.dart';
import 'package:product_manager/pages/products/product_edit.dart';
import 'package:product_manager/pages/products/product_create.dart';
import 'package:product_manager/pages/products/products_controller.dart';
import 'package:product_manager/pages/products/view_product_page.dart';
import 'package:rubber/rubber.dart';
import 'package:get/get.dart';

import '../../../model/product.dart';
import '../../categories/categories_controller.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({
    Key? key,
    this.iconAnimationController,
  }) : super(key: key);

  final AnimationController? iconAnimationController;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer>
    with SingleTickerProviderStateMixin {
  var controller = Get.find<ProductsController>();
  var categoriesController = Get.find<CategoriesController>();
  bool isLoading = false;
  ScrollController scrollController = ScrollController();
  // int totalRecord = 0;

  String selectedPeriod = "";
  String selectedCategory = "";
  String selectedPrice = "";

  List<Product> searchResults = [];
  int page = 1;

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
      // products = temp;
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
    categoryFilter.addAll(categoriesController.categories);
    selectedPeriod = "A-Z";
    selectedPrice = "";
    selectedCategory = "0";
    searchValue = "";
    page = 1;
    getListProduct(page, selectedCategory, searchValue, "name", selectedPeriod);
    scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  getMoreProducts(int Page, String selectedCategory, String search,
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
      var items;
      if (selectedPeriod != "") {
        items = await getMoreProducts(
            page, selectedCategory, searchValue, "name", selectedPeriod);
      } else {
        items = await getMoreProducts(
            page, selectedCategory, searchValue, "price", selectedPrice);
      }
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
          Container(
            padding: const EdgeInsets.only(left: 16.0),
            height: 56,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 223, 217, 217),
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),

            //Search-Product

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
                  hintText: "Search Product",
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
                                    .map((searchResult) => Container(
                                          child: InkWell(
                                            onTap: () => Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (_) =>
                                                        ViewProductPage(
                                                          product: searchResult,
                                                        ))),
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
                                                                    "${BASE_IMG}${searchResult.image}"),
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
                                                                  searchResult.name
                                                                              .length >
                                                                          15
                                                                      ? '${searchResult.name.substring(0, 15)}...'
                                                                      : searchResult
                                                                          .name,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 1,
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
                                                                      '\$${searchResult.price.toString()}'.length > 15
                                                                          ? '${'\$${searchResult.price.toString()}'.substring(0, 15)}...'
                                                                          : '\$${searchResult.price.toString()}',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          1,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16.0,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.red)),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Icon(Icons.add),
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

          //Sort name A-Z or Z-A
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
                        selectedPrice = "";
                        getListProduct(page, selectedCategory, searchValue,
                            "name", selectedPeriod);
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

          //Filter by category
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
                        selectedCategory = categoryFilter[index].id.toString();
                        if (selectedPeriod != "") {
                          getListProduct(page, selectedCategory, searchValue,
                              "name", selectedPeriod);
                        } else {
                          getListProduct(page, selectedCategory, searchValue,
                              "price", selectedPrice);
                        }
                      });
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 20.0),
                        decoration: selectedCategory ==
                                categoryFilter[index].id.toString()
                            ? const BoxDecoration(
                                color: Color(0xffFDB846),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45)))
                            : const BoxDecoration(),
                        child: Text(
                          categoryFilter[index].category,
                          style: const TextStyle(fontSize: 16.0),
                        ))),
              )),
              itemCount: categoryFilter.length,
              scrollDirection: Axis.horizontal,
            ),
          ),

          //Sort by Price Low to high OR High to low
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
                        selectedPrice = priceFilter[index];
                        selectedPeriod = "";
                        getListProduct(page, selectedCategory, searchValue,
                            "price", selectedPrice);
                      });
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 20.0),
                        decoration: selectedPrice == priceFilter[index]
                            ? const BoxDecoration(
                                color: Color(0xffFDB846),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45)))
                            : const BoxDecoration(),
                        child: Text(
                          priceFilter[index],
                          style: const TextStyle(fontSize: 16.0),
                        ))),
              )),
              itemCount: priceFilter.length,
              scrollDirection: Axis.horizontal,
            ),
          )
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
          if (selectedPeriod != "") {
            getListProduct(
                page, selectedCategory, searchValue, "name", selectedPeriod);
          } else {
            getListProduct(
                page, selectedCategory, searchValue, "price", selectedPrice);
          }
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
    if (selectedPeriod != "") {
      getListProduct(
          page, selectedCategory, searchValue, "name", selectedPeriod);
    } else {
      getListProduct(
          page, selectedCategory, searchValue, "price", selectedPrice);
    }
  }
}
