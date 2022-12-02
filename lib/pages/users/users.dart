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
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      prefixIcon: SvgPicture.asset(
                        'assets/icons/search_icon.svg',
                        fit: BoxFit.scaleDown,
                      )),
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
                child: Text('Frequent Contacts'),
              ),
              Expanded(
                  child: Center(
                child: frequentUsers.length == 0
                    ? CupertinoActivityIndicator()
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
                                        decoration: BoxDecoration(
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
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                  )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Text(
                                                user.phone,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ))
                              .toList(),
                        ),
                      ),
              )),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                child: Text('Your Contacts'),
              ),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: users.length == 0
                        ? CupertinoActivityIndicator()
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
                                                          style: TextStyle(
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
                                                Spacer(),
                                                Text(
                                                  'Request',
                                                  style:
                                                      TextStyle(fontSize: 10.0),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 64.0),
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
