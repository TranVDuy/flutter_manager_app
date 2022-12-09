import 'dart:async';

import 'package:flutter/material.dart';

import '../../app_properties.dart';
import '../../model/user.dart';
import 'display_image/display_image.dart';

class UserEdit extends StatefulWidget {
  final User user;

  const UserEdit({super.key, required this.user});

  @override
  _UserEditState createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  @override
  void initState() {
    controllerEmail.text = widget.user.email;
    controllerPhone.text = widget.user.phone;
    controllerPassword.text = widget.user.password;
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
                onPressed: () {},
                canEdit: false,
              )),
              buildUserInfoDisplay(
                  'Email', controllerEmail, const Icon(Icons.email)),
              buildUserInfoDisplay(
                  'Phone', controllerPhone, const Icon(Icons.phone)),
              buildUserInfoDisplay(
                  'Password', controllerPassword, const Icon(Icons.key)),
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
          final email = controllerEmail.text;
          final phone = controllerPhone.text;
          final password = controllerPassword.text;
        }
      },
      child: const Text("Update"),
    );
  }
}
