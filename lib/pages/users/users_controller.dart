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
        "${BASE_API}user?page=${pageNum.toString()}&limit=20&role=[]&search=${search.toString()}";
    print(url);
    var response = await http.get(url);

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

  Future<Widget> createUser(
      BuildContext context,
      String firstName,
      String lastName,
      String email,
      String phone,
      String address,
      List roles) async {
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
        var messageError = "Can not create new user!!";
        return showMessage(context, messageError);
      }
    }
    return showMessage(context, "All fields is required");
  }

  Future<Widget> editUser(
    BuildContext context,
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
      var response = await http.put(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: bodyData);
      if (response.statusCode == 200) {
        var messageSuccess = json.decode(response.body)['message'];
        showMessage(context, messageSuccess);
      } else {
        var messageError = "Can not update this user!!";
        showMessage(context, messageError);
      }
    }
    return showMessage(context, "All fields is required");
  }

  Future<String> deleteUser(String userId) async {
    var url = "${BASE_API}user/$userId";
    var response = await http.delete(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    });
    if (response.statusCode == 200) {
      return "";
    } else {
      return json.decode(response.body)['message'];
    }
  }
}
