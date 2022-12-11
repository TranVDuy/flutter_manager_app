import 'dart:async';

import 'package:flutter/material.dart';
import 'package:product_manager/model/product.dart';
import '../../app_properties.dart';
import '../users/display_image/display_image.dart';

class ProductEdit extends StatefulWidget {
  final Product product;

  const ProductEdit({super.key, required this.product});

  @override
  _ProductEditState createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerPrice = TextEditingController();
  final TextEditingController controllerImage = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();
  @override
  void initState() {
    controllerName.text = widget.product.name;
    controllerPrice.text = widget.product.price.toString();
    controllerImage.text = widget.product.image;
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
              InkWell(
                  child: DisplayImage(
                imagePath: '${BASE_IMG}${widget.product.image}',
                onPressed: () {},
                canEdit: true,
              )),
              buildProductInfoDisplay(
                  'Name', controllerName, const Icon(Icons.people)),
              buildProductInfoDisplay(
                  'Price', controllerPrice, const Icon(Icons.money)),
              // buildProductInfoDisplay(
              //     'Password', controllerImage, const Icon(Icons.key)),
              buildDescription(controllerDescription),
              const SizedBox(height: 10),
              buidSubmit(context)
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
                width: 350,
                height: 200,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          hintText: "Description",
                        )))),
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
              TextFormField(
                controller: textController,
                obscureText: title == "Password",
                enableSuggestions: false,
                autocorrect: false,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: title.toString(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "$title is required";
                  } else if (value.length < 6) {
                    return "$title is at least 6 character";
                  }
                  return null;
                },
              ),
            ],
          ));

  Widget buidSubmit(BuildContext context) {
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
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          final name = controllerName.text;
          final price = controllerPrice.text;
          final description = controllerDescription.text;
          final image = controllerImage.text;
        }
      },
      child: const Text("Update"),
    );
  }
}
