import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {
  // inisialissasi Firebase Firestore
  final CollectionReference dataColletcion = FirebaseFirestore.instance.collection('attendance');

  // getData() func untuk get data dari API
  Future<QuerySnapshot> getData() {
    return dataColletcion.get();
  }

  // pake Future karena state awal nilainya 0 
  // ketika menggunakan real API, perlu dipisahkan lagi, service & client. 
  // jika user delete dari history screen, maka data yang di Firebase juga terhapus
  Future<void> deleteData(String docId) {
    return dataColletcion.doc(docId).delete();
  }

}