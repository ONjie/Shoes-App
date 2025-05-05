import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Color(0xFF53AE71),
    secondary: Color(0xFF111111),
    surface: Color(0xFFFFFFFF),
    tertiary: Color(0xFFEAEAEA),
    error: Color(0xFFB00020),
  ),

  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 22,
      fontWeight: FontWeight.w600,
      fontFamily: 'Caladea',
    ),
    titleMedium: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: 'Caladea',
    ),
    bodyLarge: TextStyle(
      color: Color(0xFF111111),
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamily: 'Caladea',
    ),
    bodyMedium: TextStyle(
      color: Color(0xFF111111),
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamily: 'Caladea',
    ),
    bodySmall: TextStyle(
      color: Color(0xFF111111),
      fontSize: 18,
      fontWeight: FontWeight.w500,
      fontFamily: 'Caladea',
    ),
    labelLarge: TextStyle(
      color: Color(0xFF111111),
      fontSize: 20,
      fontWeight: FontWeight.w700,
      fontFamily: 'Caladea',
    ),
    labelMedium: TextStyle(
      color: Color(0xFF53AE71),
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Caladea',
      decoration: TextDecoration.underline,
      decorationColor: Color(0xFF53AE71),
    ),
  ),


  
);