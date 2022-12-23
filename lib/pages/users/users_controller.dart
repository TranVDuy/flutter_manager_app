import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../app_properties.dart';
import '../../model/user.dart';
import '../../utils/utils.dart';

class UsersController extends GetxController {
  final String title = "Users page!!!";

  Future<List<User>> getUsers(int pageNum, String search) async {
    var url =
        "${BASE_API}user?page=${pageNum.toString()}&limit=10&role=[]&search=${search.toString()}";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonObject = jsonDecode(response.body)['data'];
      var usersObject = jsonObject as List;
      return usersObject.map((e) {
        return User.fromJson(e);
      }).toList();
    } else {
      return [];
    }
  }

  Future<bool> createUser(String firstName, String lastName, String email,
      String phone, String address, List roles) async {
    if (firstName.isNotEmpty &&
        email.isNotEmpty &&
        lastName.isNotEmpty &&
        phone.isNotEmpty &&
        address.isNotEmpty) {
      var url = "${BASE_API}user";
      var bodyData = jsonEncode({
        "firstname": firstName.toString(),
        "lastname": lastName.toString(),
        "email": email.toString(),
        "phone": phone.toString(),
        "address": address.toString(),
        "roles": roles,
      });
      var response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: bodyData);
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future<bool> editUser(
    String userId,
    String firstName,
    String lastName,
    String email,
    String phone,
    String address,
    List roles,
  ) async {
    if (firstName.isNotEmpty &&
        email.isNotEmpty &&
        lastName.isNotEmpty &&
        phone.isNotEmpty &&
        address.isNotEmpty) {
      var url = "${BASE_API}user/$userId";
      var bodyData = jsonEncode({
        "firstname": firstName.toString(),
        "lastname": lastName.toString(),
        "email": email.toString(),
        "phone": phone.toString(),
        "address": address.toString(),
        "roles": roles,
      });
      var response = await http.put(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: bodyData);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }
    return true;
  }

  Future<bool> deleteUser(String userId) async {
    var url = "${BASE_API}user/$userId";
    var response = await http.delete(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    });
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['statusCode'] != null) return false;
      return true;
    } else {
      return false;
    }
  }
}
