import 'package:flutter/material.dart';

AppBar header({bool isAppTitle = false, required String titleText}) {
  return AppBar(
    backgroundColor: Colors.teal,
    title: Text(
      isAppTitle ? 'Chatee' : titleText,
      style: TextStyle(
        color: Colors.white,
        fontFamily: '',
        fontSize: isAppTitle ? 50 : 22,
      ),
    ),
    centerTitle: true,
  );
}
