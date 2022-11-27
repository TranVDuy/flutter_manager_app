import 'package:get/get.dart';
import 'package:product_manager/pages/categories/categories_controller.dart';
import 'package:product_manager/pages/dashboard/dashboard_controller.dart';
import 'package:product_manager/pages/orders/orders_controller.dart';
import 'package:product_manager/pages/products/products_controller.dart';
import 'package:product_manager/pages/roles/roles_controller.dart';
import 'package:product_manager/pages/users/users_controller.dart';

class DashboardBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<DashboardController>(()=>DashboardController());
    Get.lazyPut<CategoriesController>(()=>CategoriesController());
    Get.lazyPut<OrdersController>(()=>OrdersController());
    Get.lazyPut<ProductsController>(()=>ProductsController());
    Get.lazyPut<RolesController>(()=>RolesController());
    Get.lazyPut<UsersController>(()=>UsersController());
  }
}