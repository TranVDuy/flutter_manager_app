import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/category.dart';

class CategoriesController extends GetxController {
  final String title = "Categories page!!!";

  final List<Category> categories = [
    Category(
      const Color(0xffF123C4),
      const Color(0xff668CEA),
      1,
      'Appliances',
      'assets/appliances.png',
    ),
    Category(
      const Color(0xffFCE183),
      const Color(0xffF68D7F),
      2,
      'Headphone',
      'assets/headphone.png',
    ),
    Category(
      const Color(0xffF749A2),
      const Color(0xffFF7375),
      3,
      'Clothes',
      'assets/jeans_3.png',
    ),
    Category(
      const Color(0xff00E9DA),
      const Color(0xff5189EA),
      5,
      'Shoes',
      'assets/shoeman.png',
    ),
    Category(
      const Color(0xffAF2D68),
      const Color(0xff632376),
      6,
      'Caps',
      'assets/cap.png',
    ),
    Category(
      const Color(0xff36E892),
      const Color(0xff33B2B9),
      7,
      'Bags',
      'assets/bag.png',
    ),

  ];
}
