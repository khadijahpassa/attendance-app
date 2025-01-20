import 'package:attendance_app/ui/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // inisialisasi Firebase sebelum menggunakan pelayanan yg lain
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      // data diambil dari file google-services.json
      apiKey: "AIzaSyBfg2ap_edbnZrs7MMpmIANopdT1tO0tzg", // current_key
      appId: "1:38021666613:android:d2d2677db2641a4b8ede7c", // mobilesdk_app_id
      messagingSenderId: "38021666613", // project_number
      projectId: "attendance-app-3f137" // project_id
      )
  );
  runApp(const AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance App',
      theme: ThemeData(
        cardTheme: CardTheme(surfaceTintColor: Colors.white),
        dialogTheme: DialogTheme(surfaceTintColor: Colors.white, backgroundColor: Colors.white),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true
      ),

      home: HomeScreen(),
    );
  }
}