import 'package:flutter/material.dart';
import 'colors.dart';

class MyTheme {
  static final ThemeData defaultTheme = _buildMyTheme();
  static ThemeData _buildMyTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      scaffoldBackgroundColor: greyBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: greyBackground,
        iconTheme: IconThemeData(color: mainGreen),
        elevation: 0,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: mainGreen),
        bodyMedium: TextStyle(fontSize: 16),
      ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style:ElevatedButton.styleFrom(
            backgroundColor: mainGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
    );
  }
}
