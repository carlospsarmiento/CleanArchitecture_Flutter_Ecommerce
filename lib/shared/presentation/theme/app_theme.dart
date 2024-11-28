import 'package:app_flutter/shared/presentation/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: Colors.green,
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
    textTheme: TextTheme(
      titleLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
      labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
      // Aquí asignas los estilos de texto de Material 3
    ),
    */
      textTheme: GoogleFonts.openSansTextTheme().apply(
          bodyColor: lightColorScheme.onSurface
      )
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.green,
    //colorScheme: darkColorScheme,
      /*
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark
      ).copyWith(
        primary: Colors.red
      ),
       */
    textTheme: GoogleFonts.openSansTextTheme().apply(
      bodyColor: darkColorScheme.onSurface,
      displayColor: darkColorScheme.onSurface,
      decorationColor: darkColorScheme.onSurface
    )
    /*
    textTheme: TextTheme(
      titleLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
      labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
      // Estilos de texto en el tema oscuro
    ),
    */
  );
}