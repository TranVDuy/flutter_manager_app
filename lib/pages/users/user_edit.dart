import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_manager/pages/users/users_controller.dart';
import '../../app_properties.dart';
import '../../model/user.dart';
import 'display_image/display_image.dart';

class UserEdit extends StatefulWidget {
  final User user;
  final Function callBack;

  const UserEdit({required this.user, required this.callBack});

  @override
  _UserEditState createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  final _formKey = GlobalKey<FormState>();
  var controller = Get.find<UsersController>();
  final TextEditingController controllerFirstName = TextEditingController();
  final TextEditingController controllerLastName = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerAddress = TextEditingController();

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

  @override
  void initState() {
    controllerEmail.text = widget.user.email;
    controllerPhone.text = widget.user.phone;
    controllerFirstName.text = widget.user.firstname;
    controllerLastName.text = widget.user.lastname;
    controllerAddress.text = widget.user.address;
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
                        'Edit User',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(64, 105, 225, 1),
                        ),
                      ))),
              InkWell(
                  child: DisplayImage(
                imagePath: widget.user.picture!,
                callback: () {},
                canEdit: false,
                webImage: null,
              )),
              buildUserInfoDisplay(
                  'First Name', controllerFirstName, const Icon(Icons.people)),
              buildUserInfoDisplay(
                  'Last Name', controllerLastName, const Icon(Icons.people)),
              buildUserInfoDisplay(
                  'Email', controllerEmail, const Icon(Icons.email)),
              buildUserInfoDisplay(
                  'Phone', controllerPhone, const Icon(Icons.phone)),
              buildUserInfoDisplay(
                  'Address', controllerAddress, const Icon(Icons.house)),
              const SizedBox(height: 10),
              buidSubmit(context)
            ],
          ),
        ),
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(
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
                  } else if (value.length < 2) {
                    return "$title is at least 2 character";
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
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          final firstName = controllerFirstName.text;
          final lastName = controllerLastName.text;
          final email = controllerEmail.text;
          final phone = controllerPhone.text;
          final address = controllerAddress.text;

          var check = await controller.editUser(
              widget.user.id, firstName, lastName, email, phone, address, [57]);
          check
              ? buildFlashMessage("success", 'Sửa user thành công!')
              : buildFlashMessage("error", 'Sửa user thất bại!');
          if (check) await widget.callBack();
          Navigator.pop(context);
        }
      },
      child: const Text("Update"),
    );
  }
}
