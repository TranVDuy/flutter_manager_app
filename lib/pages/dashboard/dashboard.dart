import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_manager/navigation/navbar.dart';
import 'package:product_manager/pages/categories/categories.dart';
import 'package:product_manager/pages/dashboard/dashboard_controller.dart';
import 'package:product_manager/pages/orders/orders.dart';
import 'package:product_manager/pages/products/products.dart';
import 'package:product_manager/pages/roles/roles.dart';
import 'package:product_manager/pages/users/users.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
    GetBuilder<DashboardController>(
      builder: (controller){
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                CategoriesPage(),
                ProductsPage(),
                RolesPage(),
                OrdersPage(),
                UsersPage()
              ],
            ),
          ),
          bottomNavigationBar: Navbar(),
        );
      },
    );

  }
}
