import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final Function callback;
  final bool canEdit;
  final Uint8List? webImage;

  // Constructor
  const DisplayImage({
    Key? key,
    required this.imagePath,
    required this.callback,
    required this.canEdit,
    required this.webImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Color.fromRGBO(64, 105, 225, 1);

    return Center(
        child: Stack(children: [
      buildImage(color),
      this.canEdit == true
          ? Positioned(
              child: buildEditIcon(color),
              right: 4,
              top: 10,
            )
          : Text(""),
    ]));
  }

  // Builds Profile Image
  Widget buildImage(Color color) {
    var image =
        webImage != null ? MemoryImage(webImage!) : NetworkImage(imagePath);

    return CircleAvatar(
      radius: 75,
      backgroundColor: color,
      child: CircleAvatar(
        backgroundImage: image as ImageProvider,
        radius: 70,
      ),
    );
  }

  // Builds Edit Icon on Profile Picture
  Widget buildEditIcon(Color color) => GestureDetector(
        onTap: () async {
          await callback();
        },
        child: buildCircle(
            all: 8,
            child: Icon(
              Icons.edit,
              color: color,
              size: 20,
            )),
      );

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
          child: Container(
        padding: EdgeInsets.all(all),
        color: Colors.white,
        child: child,
      ));
}
