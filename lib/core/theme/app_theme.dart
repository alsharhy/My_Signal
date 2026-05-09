import 'package:flutter/material.dart';
import 'package:mysignal/core/config/app_constant.dart';
class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: const Color(AppConstant.primaryColorValue),
    scaffoldBackgroundColor: const Color(AppConstant.scaffoldBackgroundColorValue),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(AppConstant.primaryColorValue),
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
    ),
  );
}