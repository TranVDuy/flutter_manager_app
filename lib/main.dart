import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_manager/Login/Sigin.dart';
import 'package:product_manager/home/home_controller.dart';
import 'package:product_manager/pages/categories/categories_controller.dart';
import 'package:product_manager/pages/dashboard/dashboard_controller.dart';
import 'package:product_manager/pages/orders/orders_controller.dart';
import 'package:product_manager/pages/roles/roles_controller.dart';
import 'package:product_manager/pages/users/users_controller.dart';

import 'Login/auth_controller.dart';
import 'pages/products/products_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(GetMaterialApp(debugShowCheckedModeBanner: false, home: Signin()));
}

Future<void> init() async {
  Get.lazyPut<DashboardController>(() => DashboardController());
  Get.lazyPut<HomeController>(() => HomeController());
  Get.lazyPut<CategoriesController>(() => CategoriesController());
  Get.lazyPut<OrdersController>(() => OrdersController());
  Get.lazyPut<ProductsController>(() => ProductsController());
  Get.lazyPut<RolesController>(() => RolesController());
  Get.lazyPut<UsersController>(() => UsersController());
  Get.lazyPut<authController>(() => authController());
}
