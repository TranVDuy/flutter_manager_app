import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../app_properties.dart';
import '../../model/user.dart';
import '../../utils/utils.dart';

class authController extends GetxController {
  Future<bool> login(String email, String password) async {
    var url = "${BASE_API}auth/login";
    var bodyData = jsonEncode({
      "email": email,
      "password": password,
    });
    var response = await http.post(Uri.parse(url),
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
}
