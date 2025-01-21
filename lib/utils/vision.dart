import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class Vision {
  // dibuat private biar gak sembarangan dipake
  Vision._();

  static final Vision instance = Vision._(); // gak termasuk app security (hash)

  FaceDetector faceDetector([FaceDetectorOptions? option]) {
    return FaceDetector(options: option ?? FaceDetectorOptions()); // step untuk menghubungkan FaceDetector dengan google 
  }
}