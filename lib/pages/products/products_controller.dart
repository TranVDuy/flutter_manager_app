import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_manager/model/product.dart';
import 'package:http/http.dart' as http;
import '../../app_properties.dart';
import '../../utils/utils.dart';

class ProductsController extends GetxController {
  final String title = "Products page!!!";

  Future<List<Product>> getProducts(int? pageNum, String? search, String? column,
      String? option, List? category) async {
    var url = "";

    if((option == null || option == "") && (column==null || column == "")){
      url = "${BASE_API}products?search=$search&category=[]&page=$pageNum&limit=20";
    }
    else{
      url = "${BASE_API}products?search=$search&column=$column&options=$option&category=[]&page=$pageNum&limit=20";
    }

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonObject = jsonDecode(response.body)['data'];
      var productsObject = jsonObject as List;
      return productsObject.map((e) {
        return Product.fromJson(e);
      }).toList();
    } else {
      return [];
    }
  }

  Future<Widget> createProduct(BuildContext context, String photo, String name,
      String description, num price) async {
    if (photo.isNotEmpty && name.isNotEmpty && description.isNotEmpty) {
      var url = "${BASE_API}products";
      var bodyData = jsonEncode({
        "photo": photo.toString(),
        "name": name.toString(),
        "description": description.toString(),
        "price": price,
      });
      var response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: bodyData);
      if (response.statusCode == 201) {
        var message = json.decode(response.body)['message'];
        return showMessage(context, message);
      } else {
        var messageError = "Can not create new product!!";
        return showMessage(context, messageError);
      }
    }
    return showMessage(context, "All fields is required");
  }

  Future<Widget> editProduct(BuildContext context, String productId,
      String photo, String name, String description, num price) async {
    if (photo.isNotEmpty && name.isNotEmpty && description.isNotEmpty) {
      var url = "${BASE_API}products/$productId";
      var bodyData = jsonEncode({
        "photo": photo.toString(),
        "name": name.toString(),
        "description": description.toString(),
        "price": price,
      });
      var response = await http.put(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: bodyData);
      if (response.statusCode == 200) {
        var message = json.decode(response.body)['message'];
        return showMessage(context, message);
      } else {
        var messageError = "Can not update this product!!";
        return showMessage(context, messageError);
      }
    }
    return showMessage(context, "All fields is required");
  }

  void deleteProduct(int pageNum, String productId, String search,
      String column, String option, List category) async {
    var url = "${BASE_API}products/$productId";
    var response = await http.delete(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    });
    if (response.statusCode == 200) {
      List<Product> result = [];
      for (int i = 1; i <= pageNum; i++) {
        var url =
            "${BASE_API}products?search=$search&column=$column&options=$option&category=$category&page=$pageNum&limit=20";
        var response = await http.get(url);
        if (response.statusCode == 200) {
          var jsonObject = jsonDecode(response.body)['data'];
          var productsObject = jsonObject as List;
          List<Product> items = productsObject.map((e) {
            return Product.fromJson(e);
          }).toList();
          result.addAll(items);
        }
      }
    }
  }
}
