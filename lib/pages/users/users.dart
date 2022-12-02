import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:product_manager/pages/users/users_controller.dart';
import '../../app_properties.dart';
import '../../model/user.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  var controller = Get.find<UsersController>();
  TextEditingController searchController = TextEditingController();
  List<User> frequentUsers = [];
  List<User> users = [];

  getFrequentUsers() async {
    // var temp = await ApiService.getUsers(nrUsers: 5);
    var temp = [
      User(
          email: "email",
          password: "password",
          created_at: DateTime.now(),
          updated_at: DateTime.now(),
          profile_id: 1,
          phone: "123456"),
      User(
          email: "email",
          password: "password",
          created_at: DateTime.now(),
          updated_at: DateTime.now(),
          profile_id: 2,
          phone: "123456"),
      User(
          email: "email",
          password: "password",
          created_at: DateTime.now(),
          updated_at: DateTime.now(),
          profile_id: 3,
          phone: "123456"),
      User(
          email: "email",
          password: "password",
          created_at: DateTime.now(),
          updated_at: DateTime.now(),
          profile_id: 4,
          phone: "123456"),
      User(
          email: "email",
          password: "password",
          created_at: DateTime.now(),
          updated_at: DateTime.now(),
          profile_id: 5,
          phone: "123456"),
      User(
          email: "email",
          password: "password",
          created_at: DateTime.now(),
          updated_at: DateTime.now(),
          profile_id: 6,
          phone: "123456"),
      User(
          email: "email",
          password: "password",
          created_at: DateTime.now(),
          updated_at: DateTime.now(),
          profile_id: 7,
          phone: "123456"),
    ];
    setState(() {
      frequentUsers = temp;
    });
  }

  getUsers() async {
    // var temp = await ApiService.getUsers(nrUsers: 5);
    var temp = [
      User(
          email: "email",
          password: "password",
          created_at: DateTime.now(),
          updated_at: DateTime.now(),
          profile_id: 1,
          phone: "123456"),
      User(
          email: "email",
          password: "password",
          created_at: DateTime.now(),
          updated_at: DateTime.now(),
          profile_id: 2,
          phone: "123456"),
      User(
          email: "email",
          password: "password",
          created_at: DateTime.now(),
          updated_at: DateTime.now(),
          profile_id: 3,
          phone: "123456"),
      User(
          email: "email",
          password: "password",
          created_at: DateTime.now(),
          updated_at: DateTime.now(),
          profile_id: 4,
          phone: "123456"),
      User(
          email: "email",
          password: "password",
          created_at: DateTime.now(),
          updated_at: DateTime.now(),
          profile_id: 5,
          phone: "123456"),
      User(
          email: "email",
          password: "password",
          created_at: DateTime.now(),
          updated_at: DateTime.now(),
          profile_id: 6,
          phone: "123456"),
      User(
          email: "email",
          password: "password",
          created_at: DateTime.now(),
          updated_at: DateTime.now(),
          profile_id: 7,
          phone: "123456"),
    ];
    setState(() {
      users = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
    getFrequentUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 16.0),
                height: 56,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 223, 217, 217),
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: TextField(
                    onChanged: (value) {},
                    controller: searchController,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: "Search User",
                      prefixIcon: Icon(Icons.search),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFBDBDBD),
                      ),
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF212121),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
                child: Text(
                  'Recent Users',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: titleColor),
                ),
              ),
              Expanded(
                  child: Center(
                child: frequentUsers.length == 0
                    ? const CupertinoActivityIndicator()
                    : Container(
                        height: 150,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: frequentUsers
                              .map((user) => InkWell(
                                    // onTap: () => Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (_) =>
                                    //             RequestAmountPage(user))),
                                    child: Container(
                                        width: 100,
                                        height: 200,
                                        margin: const EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            CircleAvatar(
                                              maxRadius: 24,
                                              backgroundImage:
                                                  NetworkImage(user.picture!),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      4.0, 16.0, 4.0, 0.0),
                                              child: Text(user.email,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontSize: 14.0,
                                                  )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Text(
                                                user.phone,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 10),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ))
                              .toList(),
                        ),
                      ),
              )),
              const Padding(
                padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                child: Text(
                  'Our Users',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: titleColor),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: users.length == 0
                        ? const CupertinoActivityIndicator()
                        : Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: ListView(
                              children: users
                                  .map((user) => InkWell(
                                        // onTap: () => Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (_) =>
                                        //             RequestAmountPage(user))),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 16.0),
                                                  child: CircleAvatar(
                                                    maxRadius: 24,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            user.picture!),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 16.0),
                                                      child: Text(user.email,
                                                          style: const TextStyle(
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0,
                                                              bottom: 16.0),
                                                      child: Text(
                                                        user.phone,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                const Text(
                                                  'Request',
                                                  style:
                                                      TextStyle(fontSize: 10.0),
                                                )
                                              ],
                                            ),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 64.0),
                                              child: Divider(),
                                            )
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
