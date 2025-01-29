import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.blueAccent,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_new_rounded,
        color: Colors.white,
      ),
      onPressed: () => Navigator.of(context).pop(), 
    ),
    title: const Text(
      'Attendance Menu',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}