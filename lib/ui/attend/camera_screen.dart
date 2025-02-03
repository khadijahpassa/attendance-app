import 'package:attendance_app/ui/attend/camera-components/camera_controller.dart';
import 'package:attendance_app/ui/attend/camera-components/face_detector.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with TickerProviderStateMixin {
  late CameraControllerComponent cameraControllerComponent;
  late FaceDetectorComponent faceDetectorComponent;

  @override
  void initState() {
    super.initState();
    cameraControllerComponent = CameraControllerComponent();
    faceDetectorComponent = FaceDetectorComponent();
    cameraControllerComponent.loadCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cameraControllerComponent.buildCameraPreview(),
    );
  }
}