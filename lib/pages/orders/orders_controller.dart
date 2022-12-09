import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../app_properties.dart';
import '../../model/order.dart';

class OrdersController extends GetxController {
  final String title = "Orders page!!!";

  Future<List<Order>> getOrders(
      int pageNum, String search, String key, String sort) async {
    var url =
        "${BASE_API}orders?search=$search&key=$key&sort=$sort&page=$pageNum&limit=20";
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonObject = jsonDecode(response.body)['data'];
      var ordersObject = jsonObject as List;
      return ordersObject.map((e) {
        return Order.fromJson(e);
      }).toList();
    } else {
      return [];
    }
  }

  //create

  //update

  void deleteOrder(int pageNum, String orderId, String search, String key,
      String sort) async {
    var url = "${BASE_API}orders/$orderId";
    var response = await http.delete(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    });
    if (response.statusCode == 200) {
      List<Order> result = [];
      for (int i = 1; i <= pageNum; i++) {
        var url =
            "${BASE_API}orders?search=$search&key=$key&sort=$sort&page=$pageNum&limit=20";
        var response = await http.get(url);
        if (response.statusCode == 200) {
          var jsonObject = jsonDecode(response.body)['data'];
          var productsObject = jsonObject as List;
          List<Order> items = productsObject.map((e) {
            return Order.fromJson(e);
          }).toList();
          result.addAll(items);
        }
      }
    }
  }
}
