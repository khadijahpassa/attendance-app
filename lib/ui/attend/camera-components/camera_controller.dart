import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraControllerComponent {
  List<CameraDescription>? cameras;
  CameraController? controller;
  bool isBusy = false;

  Future<void> loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null && cameras!.isNotEmpty) {
      controller = CameraController(cameras![0], ResolutionPreset.high); //kamera depan, biar matching data(gak blur)
      await controller!.initialize();
    }
  }

  Widget buildCameraPreview() {
    // kamera gak ready
    if (controller == null || !controller!.value.isInitialized) {
      // aksi apabila kondisi bernilai negatif
      return const Center(child: CircularProgressIndicator());
    }
    // ketika kamera ready (aksi apabila kondisi bernilai positif)
    return CameraPreview(controller!);
  }
}