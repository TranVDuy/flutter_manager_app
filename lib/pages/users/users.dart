import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:product_manager/pages/users/user_create.dart';
import 'package:product_manager/pages/users/user_edit.dart';
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
  List<User> searchResults = [];

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
          email: "email1",
          password: "password",
          created_at: DateTime.now(),
          updated_at: DateTime.now(),
          profile_id: 1,
          phone: "123456"),
      User(
          email: "email2",
          password: "password",
          created_at: DateTime.now(),
          updated_at: DateTime.now(),
          profile_id: 2,
          phone: "123456"),
      User(
          email: "email3",
          password: "password",
          created_at: DateTime.now(),
          updated_at: DateTime.now(),
          profile_id: 3,
          phone: "123456"),
      User(
          email: "email4",
          password: "password",
          created_at: DateTime.now(),
          updated_at: DateTime.now(),
          profile_id: 4,
          phone: "123456"),
      User(
          email: "email5",
          password: "password",
          created_at: DateTime.now(),
          updated_at: DateTime.now(),
          profile_id: 5,
          phone: "123456"),
      User(
          email: "email6",
          password: "password",
          created_at: DateTime.now(),
          updated_at: DateTime.now(),
          profile_id: 6,
          phone: "123456"),
      User(
          email: "email7",
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
    searchResults = users;
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
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        List<User> tempList = [];
                        for (var user in users) {
                          if (user.email.toLowerCase().contains(value)) {
                            tempList.add(user);
                          }
                        }
                        setState(() {
                          searchResults = [];
                          searchResults.addAll(tempList);
                        });
                      } else {
                        setState(() {
                          searchResults = [];
                          searchResults.addAll(users);
                        });
                      }
                    },
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
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
                child: Text(
                  'Recent User',
                  style: TextStyle(
                    color: darkGrey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                  child: Center(
                child: frequentUsers.length == 0
                    ? const CupertinoActivityIndicator()
                    : Container(
                        height: 150,
                        padding: const EdgeInsets.only(
                            top: 0.0, bottom: 0.0, right: 16.0),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Users List',
                      style: TextStyle(
                        color: darkGrey,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.add,
                        size: 22,
                      ),
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => UserCreate())),
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: searchResults.length == 0
                        ? const CupertinoActivityIndicator()
                        : Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: ListView(
                              children: searchResults
                                  .map((user) => Slidable(
                                        actionPane:
                                            const SlidableDrawerActionPane(),
                                        actionExtentRatio: 0.25,
                                        secondaryActions: <Widget>[
                                          IconSlideAction(
                                            caption: 'Edit',
                                            color: Colors.blueAccent,
                                            icon: Icons.edit,
                                            onTap: () => Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (_) =>
                                                        UserEdit())),
                                          ),
                                          IconSlideAction(
                                            caption: 'Delete',
                                            color: Colors.red,
                                            icon: Icons.delete,
                                            onTap: () =>
                                                showDeleteAlert(context, user),
                                          )
                                        ],
                                        child: InkWell(
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
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
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 8.0,
                                                                bottom: 16.0),
                                                        child: Text(
                                                          user.phone,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 64.0),
                                                child: Divider(),
                                              )
                                            ],
                                          ),
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

showDeleteAlert(BuildContext context, item) {
  // set up the buttons
  Widget noButton = TextButton(
    child: const Text(
      "No",
      style: TextStyle(color: Colors.blue),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  Widget yesButton = TextButton(
    child: const Text("Yes", style: TextStyle(color: Colors.red)),
    onPressed: () {
      Navigator.pop(context);
      // deleteUser(item['id']);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Message"),
    content: const Text("Would you like to delete this user?"),
    actions: [
      noButton,
      yesButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
