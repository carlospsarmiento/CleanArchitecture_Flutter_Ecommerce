import 'package:app_flutter/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  static ThemeData lightTheme(BuildContext context){
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: Colors.green,
      textTheme: GoogleFonts.openSansTextTheme().copyWith(
        displayLarge: GoogleFonts.openSans(fontSize: 57, fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.openSans(fontSize: 45, fontWeight: FontWeight.w500),
        displaySmall: GoogleFonts.openSans(fontSize: 36, fontWeight: FontWeight.normal),
        headlineLarge: GoogleFonts.openSans(fontSize: 32, fontWeight: FontWeight.bold),
        headlineMedium: GoogleFonts.openSans(fontSize: 28, fontWeight: FontWeight.w600),
        headlineSmall: GoogleFonts.openSans(fontSize: 24, fontWeight: FontWeight.w400),
        bodyLarge: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.normal),
        bodyMedium: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.normal),
        bodySmall: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.normal),
        labelLarge: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.bold),
        labelMedium: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w500),
        labelSmall: GoogleFonts.openSans(fontSize: 10, fontWeight: FontWeight.w400),
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context){
    return ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.green,
        textTheme: GoogleFonts.openSansTextTheme().copyWith(
          displayLarge: GoogleFonts.openSans(fontSize: 57, fontWeight: FontWeight.bold),
          displayMedium: GoogleFonts.openSans(fontSize: 45, fontWeight: FontWeight.w500),
          displaySmall: GoogleFonts.openSans(fontSize: 36, fontWeight: FontWeight.normal),
          headlineLarge: GoogleFonts.openSans(fontSize: 32, fontWeight: FontWeight.bold),
          headlineMedium: GoogleFonts.openSans(fontSize: 28, fontWeight: FontWeight.w600),
          headlineSmall: GoogleFonts.openSans(fontSize: 24, fontWeight: FontWeight.w400),
          bodyLarge: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.normal),
          bodyMedium: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.normal),
          bodySmall: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.normal),
          labelLarge: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.bold),
          labelMedium: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w500),
          labelSmall: GoogleFonts.openSans(fontSize: 10, fontWeight: FontWeight.w400),
        ),
    );
  }

  static ThemeData lightThemeScaled(BuildContext context) {
    double multiplier = ResponsiveUtils.getMultiplier(context);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: Colors.red,
      /*
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            brightness: Brightness.light
        ).copyWith(
            surface: Colors.white
        ),
     */
      //colorScheme: lightColorScheme,
      /*
      textTheme: GoogleFonts.openSansTextTheme().apply(
          bodyColor: lightColorScheme.onSurface
      )
      */
      textTheme: GoogleFonts.openSansTextTheme().copyWith(
        displayLarge: GoogleFonts.openSans(fontSize: 57 * multiplier, fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.openSans(fontSize: 45 * multiplier, fontWeight: FontWeight.w500),
        displaySmall: GoogleFonts.openSans(fontSize: 36 * multiplier, fontWeight: FontWeight.normal),
        headlineLarge: GoogleFonts.openSans(fontSize: 32 * multiplier, fontWeight: FontWeight.bold),
        headlineMedium: GoogleFonts.openSans(fontSize: 28 * multiplier, fontWeight: FontWeight.w600),
        headlineSmall: GoogleFonts.openSans(fontSize: 24 * multiplier, fontWeight: FontWeight.w400),
        bodyLarge: GoogleFonts.openSans(fontSize: 16 * multiplier, fontWeight: FontWeight.normal),
        bodyMedium: GoogleFonts.openSans(fontSize: 14 * multiplier, fontWeight: FontWeight.normal),
        bodySmall: GoogleFonts.openSans(fontSize: 12 * multiplier, fontWeight: FontWeight.normal),
        labelLarge: GoogleFonts.openSans(fontSize: 14 * multiplier, fontWeight: FontWeight.bold),
        labelMedium: GoogleFonts.openSans(fontSize: 12 * multiplier, fontWeight: FontWeight.w500),
        labelSmall: GoogleFonts.openSans(fontSize: 10 * multiplier, fontWeight: FontWeight.w400),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: GoogleFonts.openSans(
            fontSize: 16 * multiplier,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16 * multiplier,
            vertical: 12 * multiplier,
          ),
          //minimumSize: Size(200 * multiplier, 48 * multiplier),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(
          //vertical: 12 * multiplier, // Ajuste el padding vertical
          //horizontal: 16 * multiplier, // Ajuste el padding horizontal
        ),
        hintStyle: GoogleFonts.openSans(
          fontSize: 14 * multiplier, // Ajuste del tamaño de la pista
          fontWeight: FontWeight.w500,
        ),
        labelStyle: GoogleFonts.openSans(
          fontSize: 16 * multiplier, // Ajuste del tamaño de la etiqueta
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}