import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:product_manager/Login/Sigin.dart';
import 'package:product_manager/model/category.dart';
import 'package:product_manager/pages/categories/categories_controller.dart';
import 'package:product_manager/pages/categories/staggered_category_card.dart';

import '../../app_properties.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<Category> searchResults = [];
  var controller = Get.find<CategoriesController>();
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchResults = controller.categories;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xffF9F9F9),
      child: SafeArea(
        top: true,
        bottom: false,
        child: Container(
          margin: const EdgeInsets.only(top: kToolbarHeight),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
               Align(
                alignment: const Alignment(-1, 0),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     const Text(
                        'Category List',
                        style: TextStyle(
                          color: darkGrey,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Text("Sign out"),
                          IconButton(onPressed: (){
                            showSignOutAlert();
                          }
                          , icon: const Icon(FontAwesomeIcons.arrowRightFromBracket)
                          ),
                        ],
                      )
                    ],
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
                child: Center(
                  child: TextField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        List<Category> tempList = [];
                        for (var category in controller.categories) {
                          if (category.category.toLowerCase().contains(value.toLowerCase())) {
                            tempList.add(category);
                          }
                        }
                        setState(() {
                          searchResults = [];
                          searchResults.addAll(tempList);
                        });
                      } else {
                        setState(() {
                          searchResults = [];
                          searchResults.addAll(controller.categories);
                        });
                      }
                    },
                    controller: searchController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: "Search Category",
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: isSearching ?
                      SizedBox(child: CupertinoActivityIndicator(), height: 15, width: 15) :
                      ((searchController.text != "") ? IconButton(
                        hoverColor: Colors.transparent,
                        iconSize: 20,
                        icon: Icon(FontAwesomeIcons.circleXmark),
                        onPressed: () {
                          setState(() {
                            searchController.text = "";
                            searchResults = [];
                            searchResults.addAll(controller.categories);
                          });
                        },
                      ) : null)
                      ,
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
              Flexible(
                child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: StaggeredCardCard(
                      begin: searchResults[index].begin,
                      end: searchResults[index].end,
                      categoryName: searchResults[index].category,
                      assetPath: searchResults[index].image,
                      id: searchResults[index].id
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showSignOutAlert() {
    // set up the buttons
    Widget noButton = TextButton(
      child: const Text(
        "No",
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget yesButton = TextButton(
      child: const Text("Yes", style: TextStyle(color: Colors.blue)),
      onPressed: () {
        Navigator.pop(context);
        Get.to(Signin());
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Sign out"),
      content: const Text("Đăng xuất hệ thống?"),
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
