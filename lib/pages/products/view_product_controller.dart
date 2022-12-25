import 'package:get/get.dart';
import 'package:product_manager/model/product.dart';

class ViewProductController extends GetxController{
  Product productView = Product(image: ""
      , name: ""
      , description: ""
      , price: "0"
      , id: "0"
      , category: []);
  bool reRenderViewProductPage = false;
  void handleChangeProductView(Product p){
    productView = p;
    update();
  }
}