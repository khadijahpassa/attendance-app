import 'package:attendance_app/services/attendance_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Container buildSubmitButton(
  BuildContext context, 
  Size size, 
  XFile? image, 
  TextEditingController controllerName, 
  String address, 
  String status, 
  String timeStamp) {

  return Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.all(10),
    child: Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: size.width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blueAccent,
          child: InkWell(
            splashColor: Colors.blue,
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              if (image == null || controllerName.text.isEmpty) {
                showSnackBar(context, "Please fill all the forms!");
              } else {
                submitAttandanceReport(context, address, controllerName.text.toString(), status, timeStamp);
              }
            },
            child: const Text(
              "Submit Now",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      children: [
        const Icon(Icons.info_outline_rounded, color: Colors.white),
        const SizedBox(width: 10),
        Text(
          message, 
          style: const TextStyle(color: Colors.white)
        )
      ],
    ),
    backgroundColor: Colors.blueGrey,
    shape: const StadiumBorder(),
    behavior: SnackBarBehavior.floating, 
    )
  );
}