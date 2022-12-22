import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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
              const Align(
                alignment: Alignment(-1, 0),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: const Text(
                    'Category List',
                    style: TextStyle(
                      color: darkGrey,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
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
                          if (category.category.toLowerCase().contains(value)) {
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
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: "Search Category",
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
}
