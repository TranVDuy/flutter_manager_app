import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:product_manager/pages/users/user_create.dart';
import 'package:product_manager/pages/users/user_edit.dart';
import 'package:product_manager/pages/users/users_controller.dart';
import '../../app_properties.dart';
import '../../model/user.dart';
import '../../utils/utils.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  var controller = Get.find<UsersController>();
  TextEditingController searchController = TextEditingController();
  List<User> frequentUsers = [];
  // List<User> users = [];
  List<User> searchResults = [];
  var page = 1;
  String deleteResult = "";
  ScrollController scrollController = ScrollController();
  int totalRecord = 0;

  getFrequentUsers() async {
    var temp = await controller.getUsers(page, "");
    setState(() {
      frequentUsers = temp;
    });
  }

  getUsers() async {
    var temp = await controller.getUsers(page, "");
    setState(() {
      searchResults = temp;
    });
  }

  showDeleteAlert(BuildContext context, User item) {
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
          DeleteUser(context, item);
        });

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

  DeleteUser(BuildContext context, item) async {
    bool check;
    check = await controller.deleteUser(item.id);
    check
        ? buildFlashMessage("success", 'Xóa thành công!')
        : buildFlashMessage("error", 'Xóa thất bại!');
    // if (selectedPeriod != "") {
    //   getListProduct(
    //       page, selectedCategory, searchValue, "name", selectedPeriod);
    // } else {
    //   getListProduct(
    //       page, selectedCategory, searchValue, "price", selectedPrice);
    // }
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
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(_scrollListener);
    getUsers();
    getFrequentUsers();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() async {
    if (totalRecord == searchResults.length) {
      return;
    }
    if (scrollController.position.extentAfter <= 0) {
      setState(() {
        page++;
      });
      var url = BASE_API +
          "user?page=" +
          page.toString() +
          "&limit=5&role=[]&search=${searchController.text}";
      var response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          totalRecord = json.decode(response.body)['totalCount'];
        });
        var jsonObject = jsonDecode(response.body)['data'];
        var usersObject = jsonObject as List;
        var items = usersObject.map((e) {
          return User.fromJson(e);
        }).toList();
        setState(() {
          searchResults.addAll(items);
        });
      }
    }
  }

  OnSearchChanged(value) async {
    page = 1;
    var temp = await controller.getUsers(page, value);
    setState(() {
      searchResults = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      // if (value.isNotEmpty) {
                      //   List<User> tempList = [];
                      //   for (var user in users) {
                      //     if (user.email.toLowerCase().contains(value)) {
                      //       tempList.add(user);
                      //     }
                      //   }
                      //   setState(() {
                      //     searchResults = [];
                      //     searchResults.addAll(tempList);
                      //   });
                      // } else {
                      //   setState(() {
                      //     searchResults = [];
                      //     searchResults.addAll(users);
                      //   });
                      // }
                      OnSearchChanged(value);
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
                                              child: Text(
                                                  (user.firstname +
                                                                  " " +
                                                                  user.lastname)
                                                              .length >
                                                          20
                                                      ? '${(user.firstname + " " + user.lastname).substring(0, 20)}...'
                                                      : user.firstname +
                                                          " " +
                                                          user.lastname,
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
                              controller: scrollController,
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
                                                    builder: (_) => UserEdit(
                                                          user: user,
                                                        ))),
                                          ),
                                          IconSlideAction(
                                            caption: 'Delete',
                                            color: Colors.red,
                                            icon: Icons.delete,
                                            onTap: () =>
                                                showDeleteAlert(context, user),
                                          ),
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
                                                        child: Text(
                                                            (user.firstname +
                                                                            " " +
                                                                            user
                                                                                .lastname)
                                                                        .length >
                                                                    20
                                                                ? '${(user.firstname + " " + user.lastname).substring(0, 20)}...'
                                                                : user.firstname +
                                                                    " " +
                                                                    user
                                                                        .lastname,
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
