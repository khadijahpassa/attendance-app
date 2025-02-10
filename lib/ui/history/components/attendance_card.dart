import 'dart:math';

import 'package:attendance_app/ui/history/components/delete_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendanceHistoryCard extends StatelessWidget {
  final Map<String, dynamic> data;
  // handler untuk delete activity
  final VoidCallback onDelete;

  const AttendanceHistoryCard({super.key, required this.data, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DeleteDialog(
          documentId: data['id'], 
          dataCollection: FirebaseFirestore.instance.collection('attendance')
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        elevation: 5,
        margin: const EdgeInsets.all(10),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  borderRadius: const BorderRadius.all(Radius.circular(10))
                ),
                // representasi data id yang ada di Firestore
                child: Center(
                  child: Text(
                    data['name'][0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          flex: 4,
                          child: Text(
                            "Name",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            data['name'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Attendance Status",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14
                          ),
                        ),
                        Text(
                          data['description'],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}