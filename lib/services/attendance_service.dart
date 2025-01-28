import 'package:attendance_app/ui/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// file yang handle pengiriman data ke firebase
// An entry point for submitting the attandance report
final CollectionReference dataCollection = FirebaseFirestore.instance.collection('attendance');
 
// proses reporting
Future<void> submitAttandanceReport(
  BuildContext context, 
  String address, 
  String name, 
  String attendanceStatus, 
  String timeStamp) async {
    showLoaderDialog(context);
    // collect data
    dataCollection.add(
      {
        'address': address,
        'name': name,
        'description': attendanceStatus,
        'time': timeStamp,
      }
    // kemudian ketika resultnya sudah ada:
    ).then((result) {
      Navigator.of(context).pop();
      try {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                "Attendance submitted successfully.",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          backgroundColor: Colors.orange,
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
        ));
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.info_outline_rounded,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Ups! $e",
                  style: const TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ));
      }
    });
}

void showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        // loading indicator
        const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: const Text('Checking the data...'),
        )
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    }
  );
}