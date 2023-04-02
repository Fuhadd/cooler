import 'package:cooler/Helpers/colors.dart';
import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      fontFamily: 'Lato',
      primaryColor: kMainColor,
      iconTheme: const IconThemeData(color: kMainColor),
      secondaryHeaderColor: Colors.deepPurple,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.bold,
          fontSize: 36,
        ),
        displayMedium: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
        displaySmall: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        headlineMedium: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.bold,
          fontSize: 19,
        ),
        headlineSmall: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        titleLarge: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.yellow)
          .copyWith(secondary: const Color(0xfff4a50C))
          .copyWith(background: background));
}
