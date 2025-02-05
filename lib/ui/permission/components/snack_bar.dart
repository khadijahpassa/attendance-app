import 'package:flutter/material.dart';

class SnackBarComponent {
  // static model --> untuk mempertahankan value dari function yang dipanggil
  // snackbar dengan data sesuai error yang ada
  static void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            isError?Icons.error : Icons.check_circle,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            )
          )
        ],
        
      ),
      backgroundColor: isError ? Colors.red : Colors.blueGrey,
      shape:  const StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      )
    );
  }
}