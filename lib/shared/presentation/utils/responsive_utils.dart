import 'package:flutter/material.dart';

class ResponsiveUtils{

  static double getMultiplier(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      return 1.5; // Tablets
    } else {
      return 1.0;
    }
  }
}