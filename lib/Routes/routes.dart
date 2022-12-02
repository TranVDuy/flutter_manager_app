import 'package:get/get.dart';
import 'package:product_manager/Login/Sigin.dart';

class RoutesClass {
  static String categories = "/categories";

  static String getCategories() => categories;

  static List<GetPage> routes = [
    GetPage(name: categories, page: () => Signin()),
  ];
}
