import 'dart:async';

import 'package:flutter/material.dart';

import '../../app_properties.dart';
import '../../model/user.dart';
import 'display_image/display_image.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class UserEdit extends StatefulWidget {
  @override
  _UserEditState createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  final user = User(
      email: "email",
      password: "password",
      created_at: DateTime.now(),
      updated_at: DateTime.now(),
      profile_id: 3,
      phone: "123456");
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  @override
  void initState() {
    super.initState();
    controllerEmail.text = user.email;
    controllerPhone.text = user.phone;
    controllerPassword.text = user.password;
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
        margin: const EdgeInsets.only(top: kToolbarHeight),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: 10,
              ),
              const Center(
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(64, 105, 225, 1),
                        ),
                      ))),
              InkWell(
                  child: DisplayImage(
                imagePath: user.picture!,
                onPressed: () {},
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