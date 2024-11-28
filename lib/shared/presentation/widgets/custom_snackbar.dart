import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(
      BuildContext context, {
        required String message,
        Color? backgroundColor,
        Duration duration = const Duration(seconds: 3),
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }
}
