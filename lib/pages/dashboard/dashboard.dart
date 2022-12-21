import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:product_manager/pages/categories/categories.dart';
import 'package:product_manager/pages/dashboard/dashboard_controller.dart';
import 'package:product_manager/pages/orders/search_page_order.dart';
import 'package:product_manager/pages/products/search_page_product.dart';
import 'package:product_manager/pages/roles/roles.dart';
import 'package:product_manager/model/product.dart';

import '../../home/home_page.dart';

import '../../navigation/custom_animated_bottom_bar.dart';
import '../products/view_product_page.dart';
import '../users/users.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  final _inactiveColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();
    return Scaffold(
        body: getBody(), bottomNavigationBar: _buildBottomBar(controller));
  }

  Widget _buildBottomBar(DashboardController controller) {
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => {
        controller.changeTabIndex(index),
        setState(() => _currentIndex = index)
      },
      items: <BottomNavyBarItem>[
        // BottomNavyBarItem(
        //   icon: const Icon(Icons.apps),
        //   title: const Text('Home'),
        //   activeColor: Colors.green,
        //   inactiveColor: _inactiveColor,
        //   textAlign: TextAlign.center,
        // ),
        BottomNavyBarItem(
          icon: const Icon(FontAwesomeIcons.shirt),
          title: const Text(
            'Categories ',
          ),
          activeColor: Colors.pink,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(FontAwesomeIcons.boxOpen),
          title: const Text(
            'Products ',
          ),
          activeColor: Colors.blueAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(FontAwesomeIcons.clipboard),
          title: const Text(
            'Orders ',
          ),
          activeColor: Colors.green,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(FontAwesomeIcons.users),
          title: const Text('Users'),
          activeColor: Colors.purpleAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(FontAwesomeIcons.gear),
          title: const Text('Roles'),
          activeColor: Colors.blue,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      // HomePage(),
      CategoriesPage(),
      SearchPageProduct(),
      SearchPageOrder(),
      UsersPage(),
      RolesPage()
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
}
