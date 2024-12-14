import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData getThemeData() {
    return ThemeData(
      primaryColor: const Color(0xff2B475E),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          color: Colors.white,
          fontFamily: 'Pacifico',
        ),
        displayMedium: TextStyle(
          fontSize: 25,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 232, 232, 232),
        ),
        bodySmall: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
        labelLarge: TextStyle(
          fontSize: 19,
          color: Color(0xff2B475E),
        ),
        labelMedium: TextStyle(
          fontSize: 21,
          color: Colors.white,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          )
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
      ),
    );
  }
}

/*displaySmall: TextStyle(),
        headlineLarge: TextStyle(),
        headlineMedium: TextStyle(),
        headlineSmall: TextStyle(),
        titleLarge: TextStyle(),
        titleMedium: TextStyle(),
        titleSmall: TextStyle(),
        bodyLarge: TextStyle(),
        bodyMedium: TextStyle(),
        bodySmall: TextStyle(),
        labelLarge: TextStyle(),
        labelMedium: TextStyle(),
        labelSmall: TextStyle(),*/