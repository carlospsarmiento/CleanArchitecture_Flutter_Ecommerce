import 'package:flutter/material.dart';

class ResponsiveUtils{

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 && MediaQuery.of(context).size.width < 1200;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getMultiplier(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      return 1.0; // Tablets
    } else {
      return 1.0;
    }
  }

  // Método para obtener un tamaño de fuente escalado en SP
  static double getSp(BuildContext context, double fontSize) {

    // Obtener el tamaño de la pantalla en píxeles lógicos
    double screenWidth = MediaQuery.of(context).size.width;

    // Establecer un tamaño base para la pantalla (típicamente 360.0)
    double baseScreenWidth = 360.0;

    // Obtener el devicePixelRatio, para compensar la densidad de píxeles
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    // Cálculo del tamaño de la fuente escalado
    double scaleFactor = screenWidth / baseScreenWidth;
    double scaledFontSize = fontSize * scaleFactor * devicePixelRatio;

    return scaledFontSize;
  }
}