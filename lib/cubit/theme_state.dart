import 'package:flutter/material.dart';

class ThemeState {
  final ThemeData themeData;
  final bool isDarkMode;

  ThemeState({required this.themeData, required this.isDarkMode});

  factory ThemeState.lightTheme() {
    return ThemeState(
      themeData: ThemeData.light(),
      isDarkMode: false,
    );
  }

  factory ThemeState.darkTheme() {
    return ThemeState(
      themeData: ThemeData.dark(),
      isDarkMode: true,
    );
  }
}
