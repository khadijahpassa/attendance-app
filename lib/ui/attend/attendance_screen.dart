import 'dart:io';

import 'package:attendance_app/ui/attend/camera_screen.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  final XFile? image;

  const AttendanceScreen({super.key, required this.image});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState(this.image);
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  _AttendanceScreenState(this.image);

  XFile? image;
  // "address" geolocator akan digunakan untuk record alamat secara otomatis
  String address = "", date = "", time = "", dateTime = "", status = "Attend";
  bool isLoading = false;
  double lat = 0.0, long = 0.0;
  int dateHours = 0, minute = 0;
  final controller = TextEditingController();
  final CollectionReference dataCollection = FirebaseFirestore.instance.collection('attendance');//manggil key di firestore

  // @override = anotation
  @override
  void initState() {
    handleLocationPermission();
    setDateTime();
    setAttendStatus();

    if (image != null) {
      isLoading = true;
      getGeoLocationPosition();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(), 
        ),
        title: const Text(
          "Attendance Report",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)
                  ),
                ),
                color: Colors.blueAccent,
                child: const Row(
                  children: [
                    SizedBox(width: 12),
                    Icon(Icons.face_retouching_natural_outlined),
                    SizedBox(width: 12),
                    Text(
                      "Please Scan Your Face!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
                child: Text(
                  "Capture Image",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const CameraScreen())
                  );
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  width: size.width,
                  height: 150,
                  child: DottedBorder(
                    radius: const Radius.circular(10),
                    borderType: BorderType.RRect,
                    color: Colors.blueAccent,
                    strokeWidth: 1,
                    dashPattern: [5, 5],
                    child: SizedBox.expand(
                      child: FittedBox(
                        child: image != null
                        ? Image.file(File(image!.path), fit: BoxFit.cover)
                        : const Icon(Icons.camera_enhance_outlined)
                      ),
                    )
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}