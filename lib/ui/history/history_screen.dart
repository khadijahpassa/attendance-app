import 'package:attendance_app/services/data_service.dart';
import 'package:attendance_app/ui/history/components/attendance_card.dart';
import 'package:attendance_app/ui/history/components/delete_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  State<AttendanceHistoryScreen> createState() => _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  // class & object
  final DataService dataService = DataService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance History'),
      ),
      // untuk membungkus widget2 menjadi satu-kesatuan, untuk membuat widget menjadi ter-manage well
      // mirip kayak adapter di android development
      body: StreamBuilder(
        // stream untuk inisialisasi dataService
        stream: dataService.dataColletcion.snapshots(), 
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // apakah snapshot punya data/tidak
          // jika tidak ada, akan return Text
          if (!snapshot.hasData) {
            return const Center(
              child: Text('There is no data'),
            );
          }

          // docs adalah referensi/representasi dari SEMUA data di Firebase Firestore
          final data = snapshot.data!.docs;
          // jika ada data
          return ListView.builder(
            itemCount: data.length, // jumlah datanya, bisa nampilin secara spesifik dengan cara indexing
            itemBuilder: (context, index) {
              return AttendanceHistoryCard(
                // untuk mendefinisikan data yang akan muncul di UI berdasarkan index atau posisi yang ada di db
                data: data[index].data() as Map<String, dynamic>, 
                onDelete: () {
                  showDialog(
                    context: context, 
                    builder: (context) => DeleteDialog(
                      // untuk menjadikan index sebagai id dari data yang ada di db
                      documentId: data[index].id, 
                      dataCollection: dataService.dataColletcion, 
                      // digunakan untuk memperbarui state setelah terjadi penghapusan data dari db
                      onConfirm: () { 
                        setState(() {
                          dataService.deleteData(data[index].id);
                          Navigator.pop(context);
                        });
                      },
                    )
                  );
                }
              );
            },
          );
        }
      ),
    );
  }
}