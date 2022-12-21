import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../app_properties.dart';
import '../../model/order.dart';
import '../../model/product.dart';

class OrdersController extends GetxController {
  final String title = "Orders page!!!";
  Order? orderEdit;

  Future<List<Order>> getOrders(
      int pageNum, String search, String key, String sort) async {
    var url =
        "${BASE_API}orders?search=$search&key=$key&sort=$sort&page=$pageNum&limit=10";
    var response = await http.get(Uri.parse(url));

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

  void addOrUpdate(Product product, int unit) async {
    bool ok = true;
    if (orderEdit != null && orderEdit?.product != null) {
      for (int i = 0; i < orderEdit!.product.length; i++) {
        if (orderEdit!.product[i].id.toString() == product.id) {
          ok = false;
          orderEdit!.product[i].quantity += unit;
          if (orderEdit!.product[i].quantity == 0) {
            orderEdit!.product.remove(orderEdit?.product[i]);
            break;
          }
        }
      }
      if (ok) {
        orderEdit!.product.add(OrderProduct(
            id: int.parse(product.id),
            name: product.name,
            quantity: unit,
            price: int.parse(product.price),
            image: product.image));
      }
      orderEdit?.total_price = (int.parse(orderEdit?.total_price ?? "0") +
              unit * int.parse(product.price))
          .toString();
    }
  }

  void addOrUpdate1(OrderProduct product, int unit) async {
    bool ok = true;
    if (orderEdit != null && orderEdit?.product != null) {
      for (int i = 0; i < orderEdit!.product.length; i++) {
        if (orderEdit!.product[i].id == product.id) {
          ok = false;
          orderEdit!.product[i].quantity += unit;
          if (orderEdit!.product[i].quantity == 0) {
            orderEdit!.product.remove(orderEdit?.product[i]);
            break;
          }
        }
      }
      if (ok) {
        orderEdit!.product.add(product);
      }
      orderEdit?.total_price =
          (int.parse(orderEdit?.total_price ?? "0") + unit * product.price)
              .toString();
    }
  }

  Future<Order?> findOneOrder(num orderId) async {
    var url = "${BASE_API}orders/$orderId";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonObject = jsonDecode(response.body)['data'];
      var ordersObject = jsonObject;
      return Order.fromJson(ordersObject);
    } else {
      return null;
    }
  }

  //create

  //update

  Future<bool> deleteOrder(
    num orderId,
  ) async {
    var url = "${BASE_API}orders/$orderId";
    var response = await http.delete(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> payOrder(
    num orderId,
  ) async {
    var url = "${BASE_API}orders/paying/$orderId";
    var response = await http.put(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
