import 'package:attendance_app/ui/permission/components/snack_bar.dart';
import 'package:flutter/material.dart';

class ErrorHandler {
  static void handleError(BuildContext context, dynamic error) {
    SnackBarComponent.showSnackBar(
      context,
      error,
      isError: true
    );
    Navigator.of(context).pop();
  }

  // TODO: implement exception handling if, the permission is denied
}