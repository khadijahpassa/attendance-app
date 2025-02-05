// ignore_for_file: avoid_print

import 'dart:math';
import 'dart:ui';

import 'package:attendance_app/utils/google_ml_kit.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceDetectorComponent {
  final FaceDetector faceDetector = GoogleMlKit.visiion.faceDetector(FaceDetectorOptions(
    enableContours: true,
    enableClassification: true,
    enableTracking: true,
    enableLandmarks: true,
  ));

  Future<void> detectFaces(XFile image) async {
    // ketika gambar diambil
    final inputImage = InputImage.fromFilePath(image.path);
    final faces = await faceDetector.processImage(inputImage);

  // ketika face sudah terdeteksi
    for(Face face in faces) {
      final Rect boundingBox = face.boundingBox; 
      //face.boundingBox = method untuk pengambilan beberapa komponen dari wajah (gambar yang diambil punya titik koordinat 0.0)

      // untuk pengambilan gambar wajah dari angle horizontal dan vertikal
      final double? verticalPosition = face.headEulerAngleY;

      final double? horizontalPosition = face.headEulerAngleZ; //pake konsep ml, jadi untuk horizontal pake sumbu Z

      // perkondisian apabila face landmark sudah aktif, ditandai oleh mulut, mata, pipi, hidung, mulut, telinga?)
      // FaceLandmark? null karena telinga bisa ada dan tidak
      final FaceLandmark? leftEar = face.landmarks[FaceLandmarkType.leftEar];
      // jika telinga terdeteksi, maka akan return posisi telinga tersebut dgn titik koor
      if (leftEar != null) {
        final Point<int> leftEarPosition = leftEar.position;
        print("Left Ear Position: $leftEarPosition");
      }

      // perkondisian apabila klasifikasi wajahnya sudah aktif (ditandai dengan bibir tersenyum)
      if (face.smilingProbability != null) {
        final double? smilingProbability = face.smilingProbability;
        print("Smiling Probability: $smilingProbability");
      }

      // perkondisian apabila fitur tracking wajah sudah aktif
      if (face.trackingId != null) {
        final int? trackingId = face.trackingId;
        print("Tracking ID: $trackingId");
      }
    }
  }
}