import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_manager/Login/Signup.dart';
import 'package:product_manager/navigation/navbar.dart';
import 'package:product_manager/navigation/navbar.dart';
import 'package:product_manager/pages/dashboard/dashboard.dart';
import 'package:product_manager/pages/dashboard/dashboard_binding.dart';

class Signin extends StatelessWidget {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();

  var _formUserName = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.orange[300]),
        child: Column(
          children: [
            buildWelcome(context),
            const SizedBox(height: 70),
            buildSignForm(context),
            const SizedBox(
              height: 43,
            ),
            buildTextSignUp(context)
          ],
        ),
      ),
    );
  }

  buildWelcome(BuildContext context) {
    return Container(
      width: 390,
      height: 375,
      decoration: BoxDecoration(
        color: Colors.blue[800],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50)),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 121, 0, 0),
        child: const Text(
          'Welcome \nBack',
          style: TextStyle(
            fontSize: 48,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  buildSignForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Form(
        // key: _formUserName,
        child: Column(children: [
          //Username
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            //Username
            child: TextFormField(
              controller: _userName,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Vui lòng nhập tên đăng nhập";
                else {
                  if (value.length < 5)
                    return "Tên đăng nhập phải lớn hơn 5 ký tự";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Username",
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
          //Password
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            //Username
            child: TextFormField(
              controller: _password,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Vui lòng nhập mật khẩu";
                else {
                  if (value.length < 5) return "Mật khẩu không đúng";
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
                'Sign in',
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
                  onPressed: () {
                    // GetPage(
                    //   name: "/", page: ()=>Dashboard(),
                    //   binding: DashboardBinding()
                    // );
                    Get.to(Dashboard());
                  },
                  child: Icon(
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

  buildTextSignUp(BuildContext context) {
    return  Container(
      padding: EdgeInsets.fromLTRB(30,0,0,0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              //  Chuyển qua signup
                Get.to(Signup());
            },
            child: const Text("Sign up", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              decoration: TextDecoration.underline,
            ),),
          ),
        ],
      ),
    );
  }
}


