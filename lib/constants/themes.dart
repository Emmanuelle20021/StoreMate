import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color _primaryColor = Color.fromARGB(255, 195, 88, 23);
const Color _secondaryColor = Colors.orange;
const Color _lightColor = Color.fromARGB(255, 238, 238, 240);
const Color _darkColor = Color.fromARGB(255, 9, 9, 41);
const Color _secondaryDarkColor = Color.fromARGB(255, 26, 26, 50);
const Color _successColor = Color.fromARGB(224, 254, 113, 19);
const Color _errorColor = Colors.red;

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: _primaryColor,
  hintColor: _secondaryColor,
  scaffoldBackgroundColor: _lightColor,
  appBarTheme: AppBarTheme(
    color: _primaryColor,
    iconTheme: const IconThemeData(color: _lightColor),
    toolbarTextStyle: const TextTheme(
      titleLarge: TextStyle(
        color: _lightColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ).bodyMedium,
    titleTextStyle: const TextTheme(
      titleLarge: TextStyle(
        color: _lightColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ).titleLarge,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: _darkColor),
    bodyMedium: TextStyle(color: _darkColor),
  ),
  colorScheme: const ColorScheme(
    primary: _primaryColor,
    secondary: _successColor,
    surface: _lightColor,
    background: _lightColor,
    error: _errorColor,
    onPrimary: _lightColor,
    onSecondary: _darkColor,
    onSurface: _darkColor,
    onBackground: _darkColor,
    onError: _lightColor,
    brightness: Brightness.light,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: _primaryColor,
  hintColor: _secondaryColor,
  scaffoldBackgroundColor: _darkColor,
  appBarTheme: AppBarTheme(
    color: _secondaryDarkColor,
    iconTheme: const IconThemeData(color: _lightColor),
    systemOverlayStyle: SystemUiOverlayStyle.light,
    toolbarTextStyle: const TextTheme(
      titleLarge: TextStyle(
        color: _lightColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ).bodyMedium,
    titleTextStyle: const TextTheme(
      titleLarge: TextStyle(
        color: _lightColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ).titleLarge,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: _lightColor),
    bodyMedium: TextStyle(color: _lightColor),
  ),
  colorScheme: const ColorScheme(
    primary: _primaryColor,
    secondary: _successColor,
    surface: _secondaryDarkColor,
    background: _darkColor,
    error: _errorColor,
    onPrimary: _lightColor,
    onSecondary: _darkColor,
    onSurface: _lightColor,
    onBackground: _lightColor,
    onError: _lightColor,
    brightness: Brightness.dark,
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: _secondaryDarkColor,
    indicatorColor: _primaryColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: _secondaryDarkColor,
    selectedItemColor: _primaryColor,
    unselectedItemColor: _lightColor,
  ),
);
