import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.orange,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: GNav(
            backgroundColor: Colors.orange,
            color: Colors.white,
            activeColor: Colors.black,
            iconSize: 24,
            tabs: [
              GButton(
                icon: Icons.category,
                onPressed: () {

                },
              ),
              //categories
              GButton(
                icon: Icons.grid_view,
                onPressed: () {

                },
              ),
              //products
              GButton(
                icon: Icons.people_rounded,
                onPressed: () {

                },
              ),
              //roles
              GButton(
                icon: Icons.note_add_rounded,
                onPressed: () {

                },
              ),
              //orders
              GButton(
                icon: Icons.supervised_user_circle,
                onPressed: () {

                },
              ), //Users
            ],
          ),
        ),
      ),
    );
  }
}
