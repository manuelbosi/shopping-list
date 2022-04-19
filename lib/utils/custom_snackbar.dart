import 'package:flutter/material.dart';
import 'package:shopping_list/config/colors.dart';

class CustomSnackBar {
  static showError({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 2,
        content: Text(message),
        duration: const Duration(seconds: 5),
        backgroundColor: ColorPalette.danger,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static showSuccess({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 2,
        content: Text(message),
        duration: const Duration(seconds: 5),
        backgroundColor: ColorPalette.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
