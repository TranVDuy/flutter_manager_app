import 'package:flutter/material.dart';
import 'package:product_manager/pages/dashboard/dashboard.dart';

showMessage(BuildContext context, String contentMessage) {
  Widget yesButton = TextButton(
    child: Text("OK", style: TextStyle(color: Colors.blue)),
    onPressed: () {
      Navigator.pop(context);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Dashboard()),
          (Route<dynamic> route) => false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Message"),
    content: Text(contentMessage),
    actions: [
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
