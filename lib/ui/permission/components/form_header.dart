import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget{
  final String title;
  final IconData icon;

  const FormHeader({required this.title, required this.icon});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10)
        ),
        color: Colors.blueAccent
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white, 
            ),
          )
        ],
      ),
    );
  }


}