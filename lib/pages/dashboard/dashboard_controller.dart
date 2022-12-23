import 'package:get/get.dart';

class DashboardController extends GetxController {
  var currentIndex = 0.obs;
  var categoryfilter = 0.obs;
  var reRenderProductPage = false.obs;
  void changeTabIndex(int index, int catefilter) {
    categoryfilter = RxInt(catefilter);
    currentIndex = RxInt(index);
    if (catefilter != 0) reRenderProductPage = RxBool(true);
    update();
  }
}
