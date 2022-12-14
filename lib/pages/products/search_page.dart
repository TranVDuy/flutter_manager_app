import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product_manager/model/category.dart';
import 'package:product_manager/pages/products/product_edit.dart';
import 'package:product_manager/pages/products/products_controller.dart';
import 'package:product_manager/pages/products/view_product_page.dart';
import 'package:rubber/rubber.dart';
import 'package:get/get.dart';
import '../../app_properties.dart';
import '../../model/product.dart';
import '../categories/categories_controller.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  var controller = Get.find<ProductsController>();
  var categoriesController = Get.find<CategoriesController>();
  bool isLoading = false;

  String selectedPeriod = "";
  String selectedCategory = "";
  String selectedPrice = "";

  List<Product> products = [
    // Product(
    //     image: 'assets/headphones_2.png',
    //     name: 'Skullcandy headset L325',
    //     description:
    //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
    //     price: 102.99),
    // Product(
    //     image: 'assets/headphones_3.png',
    //     name: 'Skullcandy headset X25',
    //     description:
    //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
    //     price: 55.99),
    // Product(
    //     image: 'assets/headphones.png',
    //     name: 'Blackzy PRO hedphones M003',
    //     description:
    //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
    //     price: 152.99),
  ];
  List<Product> searchResults = [];
  int page = 1;

  getListProduct(int Page, String selectedCategory, String search,String Column, String Option) async {
    String sort = "";
    var temp;
    if(Column == "name"){
      sort = Option == "A-Z" ? "asc" : "desc";
    }
    else{
      sort = Option == "Low to High" ? "asc" : "desc";
    }

    if(selectedCategory == "0"){
      temp = await controller.getProducts(Page, search, Column, sort, []);
    }
    else{
      temp = await controller.getProducts(Page, search, Column, sort, [selectedCategory]);
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
    getListProduct(page , selectedCategory, searchValue, "name", selectedPeriod);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
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
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Products List',
              style: TextStyle(
                color: darkGrey,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
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

            //Search-Product

            child: Center(
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  // if (value.isNotEmpty) {
                  //   List<Product> tempList = [];
                  //   products.forEach((product) {
                  //     if (product.name.toLowerCase().contains(value)) {
                  //       tempList.add(product);
                  //     }
                  //   });
                  //   setState(() {
                  //     searchResults = [];
                  //     searchResults.addAll(tempList);
                  //   });
                  //   return;
                  // } else {
                  //   setState(() {
                  //     searchResults = [];
                  //     searchResults.addAll(products);
                  //   });
                  // }
                  // OnSearchChanged(value);
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
          // Flexible(
          //   child: Container(
          //     color: Colors.orange[50],
          //     child: ListView.builder(
          //         itemCount: searchResults.length,
          //         itemBuilder: (_, index) => Padding(
          //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //             child: ListTile(
          //               onTap: () =>
          //                   Navigator.of(context).push(MaterialPageRoute(
          //                       builder: (_) => ViewProductPage(
          //                             product: searchResults[index],
          //                           ))),
          //               title: Text(searchResults[index].name),
          //             ))),
          //   ),
          // ),
          Expanded(
              flex: 2,
              child: Center(
                child: searchResults.length == 0
                    ? Container(
                      alignment: Alignment.center,
                      child: Text(
                        "No Results",
                        style: TextStyle(color: Colors.grey.shade400 ),
                      ),
                    )
                    : Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: isLoading ? Opacity(
                            opacity:  0.80,
                            child: Container(
                              alignment: Alignment.center,
                              color: Colors.white70,
                              child: const CircularProgressIndicator(),
                              )
                            )  : ListView(
                          children: searchResults
                              .map((searchResult) => Slidable(
                                    actionPane:
                                        const SlidableDrawerActionPane(),
                                    actionExtentRatio: 0.25,
                                    secondaryActions: <Widget>[
                                      IconSlideAction(
                                        caption: 'Edit',
                                        color: Colors.blueAccent,
                                        icon: Icons.edit,
                                        onTap: () => Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (_) => ProductEdit(
                                                      product: searchResult,
                                                    ))),
                                      ),
                                      IconSlideAction(
                                        caption: 'Delete',
                                        color: Colors.red,
                                        icon: Icons.delete,
                                        onTap: () => showDeleteAlert(
                                            context, searchResult),
                                      )
                                    ],
                                    child: InkWell(
                                      onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (_) => ViewProductPage(
                                                    product: searchResult,
                                                  ))),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 16.0),
                                                child: CircleAvatar(
                                                  maxRadius: 24,
                                                  backgroundImage: NetworkImage(
                                                      "${BASE_IMG}${searchResult.image}"),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 16.0),
                                                    child: Text(
                                                        searchResult.name.length > 20 ?
                                                        '${searchResult.name.substring(0, 20)}...' :
                                                        searchResult.name
                                                        ,
                                                        style: const TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0,
                                                            bottom: 16.0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          '\$${searchResult.price.toString()}',
                                                            style: const TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.red
                                                            )
                                                        ),
                                                        // const Icon(Icons.money)
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(left: 64.0),
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
//          controller: _scrollController,
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
                      setState(() {
                        selectedPeriod = nameFilter[index];
                        selectedPrice = "";
                        getListProduct(page, selectedCategory, searchValue, "name", selectedPeriod);
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
                      setState(() {
                        selectedCategory = categoryFilter[index].id.toString();
                        if(selectedPeriod != ""){
                          getListProduct(page, selectedCategory, searchValue,"name", selectedPeriod);
                        }
                        else{
                          getListProduct(page, selectedCategory, searchValue,"price", selectedPrice);
                        }
                      });
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 20.0),
                        decoration: selectedCategory == categoryFilter[index].id.toString()
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
                      setState(() {
                        selectedPrice = priceFilter[index];
                        selectedPeriod = "";
                        getListProduct(page, selectedCategory, searchValue ,"price", selectedPrice);
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
//          bottomSheet: ClipRRect(
//            borderRadius: BorderRadius.only(
//                topRight: Radius.circular(25), topLeft: Radius.circular(25)),
//            child: BottomSheet(
//                onClosing: () {},
//                builder: (_) => Container(
//                      padding: EdgeInsets.all(16.0),
//                      child: Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[Text('Filters')]),
//                      color: Colors.white,
//                      width: MediaQuery.of(context).size.height,
//                    )),
//          ),
            body: RubberBottomSheet(
          lowerLayer: _getLowerLayer(), // The underlying page (Widget)
          upperLayer: _getUpperLayer(), // The bottomsheet content (Widget)
          animationController: _controller, // The one we created earlier
        )),
      ),
    );
  }

  //Tìm kiếm sản phẩm
  OnSearchChanged(value){
    if(_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), (){
        if(this.searchValue != searchController.text){
          setState(() {
            searchValue = value;
            if(selectedPeriod != ""){
              getListProduct(page, selectedCategory, searchValue,"name", selectedPeriod);
            }
            else{
              getListProduct(page, selectedCategory, searchValue,"price", selectedPrice);
            }
          });
        }
        this.searchValue = searchController.text;
      }
    );
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
  RerenderList(){
    if(selectedPeriod != ""){
      getListProduct(page, selectedCategory, searchValue,"name", selectedPeriod);
    }
    else{
      getListProduct(page, selectedCategory, searchValue,"price", selectedPrice);
    }
  }

  DeleteProduct(BuildContext context, item) async {
    bool check;
    setState(() {
      isLoading = true;
    });
    check = await controller.deleteProduct(item.id);
    setState(() {
      isLoading = false;
    });
    if(check){
      RerenderList();
      buildFlashMessage("success", 'Xóa thành công!');
    }
    else{
      buildFlashMessage("error", 'Xóa thất bại!');
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
        // deleteUser(item['id']);
        DeleteProduct(context, item);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Message"),
      content: const Text("Would you like to delete this product?"),
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

}




