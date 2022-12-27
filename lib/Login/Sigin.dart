import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/dashboard/dashboard.dart';
import 'auth_controller.dart';

class Signin extends StatefulWidget {
  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  var isLoading = false;
  var controller = Get.find<authController>();
  final TextEditingController _userName =
      TextEditingController(text: "admin@gmail.com");

  final TextEditingController _password =
      TextEditingController(text: "123456789");

  var _formUserName = GlobalKey<FormState>();

  Login(BuildContext context) async {
    bool check;
    setState(() {
      isLoading = true;
    });
    check = await controller.login(_userName.text, _password.text);
    setState(() {
      isLoading = false;
    });
    if (check) {
      buildFlashMessage("success", 'Đăng Nhập Thành Công!');
      Get.to(Dashboard());
    } else {
      buildFlashMessage("error", 'Đăng Nhập Thất Bại!');
    }
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: BoxDecoration(color: Colors.orange[300]),
          child: Column(
            children: [
              buildWelcome(context),
              const SizedBox(height: 70),
              buildSignForm(context, isLoading),
              const SizedBox(
                height: 92,
              ),
            ],
          ),
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
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50)),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(30, 121, 0, 0),
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

  buildSignForm(BuildContext context, var isLoading) {
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
            //Username
            child: TextFormField(
              controller: _userName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Vui lòng nhập tên đăng nhập";
                } else {
                  if (value.length < 5) {
                    return "Tên đăng nhập phải lớn hơn 5 ký tự";
                  }
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
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Vui lòng nhập mật khẩu";
                } else {
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
                child: isLoading
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.blue),
                      )
                    : ElevatedButton(
                        //handle Login
                        onPressed: () {
                          // GetPage(
                          //   name: "/", page: ()=>Dashboard(),
                          //   binding: DashboardBinding()
                          // );
                          Login(context);
                        },
                        child: const Icon(
                          Icons.arrow_right_alt,
                          size: 40,
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
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
}
