import 'package:attendance_app/ui/attend/attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // PopScope untuk make sure navigasi kembali(back)
    return PopScope(
      canPop: false,
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        _onWillPop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMenuItem(
                  context, 
                  label: 'Attandance Report', 
                  imagePath: '/assets/images/ic_attend.png', 
                  destination: AttendanceScreen() 
                ),
                const SizedBox(height: 40),
                _buildMenuItem(
                  context, 
                  label: 'Attandance History', 
                  imagePath: '/assets/images/ic_attendance_history.png', 
                  destination: AttendanceScreen() 
                ),
                const SizedBox(height: 40),
                _buildMenuItem(
                  context, 
                  label: 'Permission Report', 
                  imagePath: '/assets/images/ic_permission.png', 
                  destination: AttendanceScreen() 
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, 
    {
      required String imagePath,
      required String label,
      required Widget destination
    }
    ) {
    return Container(
                margin: const EdgeInsets.all(10),
                child: Expanded(
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
                    },
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage(imagePath),
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          label,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
      barrierDismissible: false, // harus melakukan confirm, gak bisa tap di luar frame pop up; pop up penting
      context: context, 
      builder: (context) => 
      AlertDialog(
        title: const Text(
          'Information',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        content: const Text(
          "Do you want to exit?",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), 
            child: const Text(
              "No",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14
              ),
            )
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(), // untuk keluar dari screen aplikasi
            child: const Text(
              "Yes",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14
              ),
            )
          )
        ]
      )
      )
      // default value ketika semua kode yang ada di blok AlertDialog tidak tereksekusi karena bbrp hal
    ) ??
    false;
  }
}