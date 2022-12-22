import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
// import 'dart:ffi';
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_manager/model/category.dart';
import 'package:product_manager/model/product.dart';
import 'package:http/http.dart' as http;
import '../../app_properties.dart';
import '../../utils/utils.dart';

class ProductsController extends GetxController {
  final String title = "Products page!!!";
  var categoryFilter = 0.obs;

  void changeCategoryFilter(int index) {
    categoryFilter = RxInt(index);
    update();
  }

  Future<List<Product>> getProducts(int? pageNum, String? search,
      String? column, String? option, List? category) async {
    var url = "";

    if ((option == null || option == "") && (column == null || column == "")) {
      url =
          "${BASE_API}products?search=$search&category=${category.toString()}&page=$pageNum&limit=10";
    } else {
      url =
          "${BASE_API}products?search=$search&column=$column&options=$option&category=${category.toString()}&page=$pageNum&limit=10";
    }
    var response = await http.get(Uri.parse(url));

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

  Future<bool> createProduct(Uint8List? imageCreate, String name,
      String category, String description, num price) async {
    if (name.isNotEmpty && price > 0 && description.isNotEmpty) {
      var url = "${BASE_API}products";
      var request = await http.MultipartRequest("POST", Uri.parse(url));
      request.fields['name'] = name.toString();
      request.fields['description'] = description.toString();
      request.fields['price'] = price.toString();
      request.fields['category'] = category.toString();

      if (imageCreate != null) {
        request.files.add(http.MultipartFile.fromBytes('photo', imageCreate!,
            filename: 'createImage.jpg',
            contentType: new MediaType('image', 'jpg')));
      }
      var response = await request.send();

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future<bool> editProduct(String productId, String idCategory, String name,
      String description, num price, Uint8List? imageUpdate) async {
    if (name.isNotEmpty && price > 0 && description.isNotEmpty) {
      var url = "${BASE_API}products/$productId";

      var request = await http.MultipartRequest("PUT", Uri.parse(url));
      request.fields['name'] = name.toString();
      request.fields['description'] = description.toString();
      request.fields['price'] = price.toString();
      request.fields['category'] = idCategory;

      if (imageUpdate != null) {
        request.files.add(http.MultipartFile.fromBytes('photo', imageUpdate!,
            filename: 'updateImage.jpg',
            contentType: new MediaType('image', 'jpg')));
      }
      var response = await request.send();
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future<int> deleteProduct(String productId) async {
    var url = "${BASE_API}products/$productId";
    var response = await http.delete(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    });
    // if (response.statusCode == 200) {
    //   return true;
    // } else {
    //   return false;
    // }
    return response.statusCode;
  }
}
