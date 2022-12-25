import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_manager/model/product.dart';
import 'package:product_manager/pages/products/products_controller.dart';
import '../../app_properties.dart';
import '../categories/categories_controller.dart';
import '../users/display_image/display_image.dart';
import 'package:flutter/services.dart';

class ProductEdit extends StatefulWidget {
  final Product product;
  final Function callBack;
  final idCategory;

  const ProductEdit(
      {super.key,
      required this.product,
      required this.callBack,
      required this.idCategory});

  @override
  _ProductEditState createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  var categoriesController = Get.find<CategoriesController>();
  late var Cate = widget.idCategory;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var product_controller = Get.find<ProductsController>();
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerPrice = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();
  final ImagePicker picker = ImagePicker();
  File? pickedImage;
  Uint8List? webImage;
  String imagePath = "";

  buildFlashMessage(String status, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
          height: 70,
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
              color: (status == "success" ? Colors.green : Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                message,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              (status == "success"
                  ? const Icon(Icons.check_circle_outline_outlined,
                      color: Colors.white, size: 20)
                  : const Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 30,
                    ))
            ],
          )),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imagePath = image.path;
        var selected = File(image.path);
        setState(() {
          pickedImage = selected;
        });
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imagePath = "";
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          pickedImage = File("a");
        });
      }
    }
  }

  @override
  void initState() {
    controllerName.text = widget.product.name;
    controllerPrice.text = widget.product.price.toString();
    controllerDescription.text = widget.product.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: darkGrey),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Center(
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Edit Product',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(64, 105, 225, 1),
                        ),
                      ))),
              isLoading
                  ? Opacity(
                      opacity: 0.80,
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.white70,
                        child: const CircularProgressIndicator(),
                      ))
                  : Column(
                      children: [
                        InkWell(
                            child: DisplayImage(
                          imagePath: '${BASE_IMG}${widget.product.image}',
                          callback: _pickImage,
                          canEdit: true,
                          webImage: webImage,
                          pickedImage: pickedImage,
                        )),
                        buildDroplistCategory(Cate),
                        buildProductInfoDisplay(
                            'Name', controllerName, const Icon(Icons.people)),
                        buildProductInfoDisplay(
                            'Price', controllerPrice, const Icon(Icons.money)),
                        buildDescription(controllerDescription),
                        const SizedBox(height: 10),
                        buildSubmit(context)
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget builds the About Me Section
  Widget buildDescription(TextEditingController textController) =>
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 1),
            Container(
                height: 150,
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ))),
                child: Expanded(
                    child: TextFormField(
                  controller: textController,
                  enableSuggestions: false,
                  autocorrect: false,
                  maxLines: 8,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: "Description",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Description is required";
                    } else
                      return null;
                  },
                ))),
          ],
        ),
      );

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildProductInfoDisplay(
          String title, TextEditingController textController, Icon icon) =>
      Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              title == "Price"
                  ? TextFormField(
                      controller: textController,
                      obscureText: title == "Password",
                      enableSuggestions: false,
                      autocorrect: false,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: title.toString(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "$title is required";
                        } else
                          return null;
                      },
                    )
                  : TextFormField(
                      controller: textController,
                      obscureText: title == "Password",
                      enableSuggestions: false,
                      autocorrect: false,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: title.toString(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "$title is required";
                        } else
                          return null;
                      },
                    ),
            ],
          ));

  Widget buildSubmit(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          minimumSize: const Size.fromHeight(50),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          textStyle:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          final name = controllerName.text;
          final price = controllerPrice.text;
          final description = controllerDescription.text;
          setState(() {
            isLoading = true;
          });
          var check = await product_controller.editProduct(
              widget.product.id,
              Cate.toString(),
              name,
              description,
              num.parse(price),
              webImage,
              imagePath);
          setState(() {
            isLoading = false;
          });
          check
              ? buildFlashMessage("success", 'Update thành công!')
              : buildFlashMessage("error", 'Update thất bại!');
          if (check) widget.callBack();
          Navigator.pop(context);
        }
      },
      child: const Text("Update"),
    );
  }

  buildDroplistCategory(var Category) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Category",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10)),
            child: DropdownButtonFormField<int>(
              hint: const Text("Select Category"),
              icon: const Icon(Icons.arrow_drop_down),
              isExpanded: true,
              value: Category,
              onChanged: (newID) {
                setState(() {
                  Cate = newID as int;
                });
              },
              items: categoriesController.categories
                  .map((e) => DropdownMenuItem(
                        child: Text(e.category),
                        value: e.id,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
