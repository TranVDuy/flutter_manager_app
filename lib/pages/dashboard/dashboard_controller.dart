import 'package:get/get.dart';

class DashboardController extends GetxController {
  var currentIndex = 0.obs;
  var categoryfilter = 0.obs;
  void changeTabIndex(int index, int catefilter) {
    categoryfilter = RxInt(catefilter);
    currentIndex = RxInt(index);
    update();
  }
}
