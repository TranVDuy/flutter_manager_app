import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_manager/Login/Sigin.dart';

class Signup extends StatelessWidget {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.orange[300]),
        child: Column(
          children: [
            buildCreatAccount(context),
            const SizedBox(
              height: 27,
            ),
            buildFormCreateAccount(context),
            const SizedBox(
              height: 5,
            ),
            buildTextSignin(context)
          ],
        ),
      ),
    );
  }

  buildCreatAccount(BuildContext context) {
    return Container(
      width: 390,
      height: 308,
      decoration: BoxDecoration(
        color: Colors.blue[800],
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50)),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(30, 121, 0, 0),
        child: const Text(
          'Create \nAccount',
          style: TextStyle(
            fontSize: 48,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  buildFormCreateAccount(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Form(
        // key: _formUserName,
        child: Column(children: [
          //Username
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            //Email
            child: TextFormField(
              controller: _email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Vui lòng nhập email";
                } else {
                  if (value.length < 5) return "Email không đúng";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Email",
                // prefixIcon: Icon(Icons.person),
                focusColor: Colors.red,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          //Firstname
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            //Firstname
            child: TextFormField(
              controller: _firstname,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Vui lòng nhập Họ";
                } else {
                  if (value.length < 5) return "Mật khẩu không đúng";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Firstname",
                focusColor: Colors.red,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          //Lastname
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            //Lastname
            child: TextFormField(
              controller: _lastname,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Vui lòng nhập Tên";
                } else {
                  if (value.length < 5) return "Tên không đúng";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Lastname",
                focusColor: Colors.red,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          //Password
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            //Password
            child: TextFormField(
              controller: _password,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Vui lòng nhập mật khẩu";
                } else {
                  if (value.length < 5) return "Mật khẩu quá ngắn";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Password",
                focusColor: Colors.red,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          //Signin
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sign up',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              //Button Signin
              SizedBox(
                width: 70,
                height: 70,
                child: ElevatedButton(
                  //handle Login
                  onPressed: () {},
                  child: const Icon(
                    Icons.arrow_right_alt,
                    size: 40,
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35)))),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }

  buildTextSignin(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              //  Chuyển qua signin
              Get.to(Signin());
            },
            child: const Text(
              "Sign in",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
