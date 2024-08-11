// const Color kColorSeed = Colors.deepOrangeAccent;
// const Color _primaryColor = Color.fromARGB(255, 195, 88, 23);
// const Color _secondaryColor = Colors.orange;
// const Color _lightColor = Color.fromARGB(255, 238, 238, 240);
// const Color _darkColor = Color.fromARGB(255, 9, 9, 41);
// const Color _secondaryDarkColor = Color.fromARGB(255, 26, 26, 50);
// const Color _successColor = Color.fromARGB(224, 254, 113, 19);
// const Color _errorColor = Colors.red;

// final ThemeData lightTheme = ThemeData(
//   brightness: Brightness.light,
//   primaryColor: _primaryColor,
//   hintColor: _secondaryColor,
//   scaffoldBackgroundColor: _lightColor,
//   appBarTheme: AppBarTheme(
//     color: _primaryColor,
//     iconTheme: const IconThemeData(color: _lightColor),
//     toolbarTextStyle: const TextTheme(
//       titleLarge: TextStyle(
//         color: _lightColor,
//         fontSize: 20.0,
//         fontWeight: FontWeight.bold,
//       ),
//     ).bodyMedium,
//     titleTextStyle: const TextTheme(
//       titleLarge: TextStyle(
//         color: _lightColor,
//         fontSize: 20.0,
//         fontWeight: FontWeight.bold,
//       ),
//     ).titleLarge,
//     systemOverlayStyle: SystemUiOverlayStyle.dark,
//   ),
//   textTheme: const TextTheme(
//     bodyLarge: TextStyle(color: _darkColor),
//     bodyMedium: TextStyle(color: _darkColor),
//   ),
//   colorScheme: const ColorScheme(
//     primary: _primaryColor,
//     secondary: _successColor,
//     surface: _lightColor,
//     background: _lightColor,
//     error: _errorColor,
//     onPrimary: _lightColor,
//     onSecondary: _darkColor,
//     onSurface: _darkColor,
//     onBackground: _darkColor,
//     onError: _lightColor,
//     brightness: Brightness.light,
//   ),
// );

// final ThemeData darkTheme = ThemeData(
//   brightness: Brightness.dark,
//   primaryColor: _primaryColor,
//   hintColor: _secondaryColor,
//   scaffoldBackgroundColor: _darkColor,
//   appBarTheme: AppBarTheme(
//     color: _secondaryDarkColor,
//     iconTheme: const IconThemeData(color: _lightColor),
//     systemOverlayStyle: SystemUiOverlayStyle.light,
//     toolbarTextStyle: const TextTheme(
//       titleLarge: TextStyle(
//         color: _lightColor,
//         fontSize: 20.0,
//         fontWeight: FontWeight.bold,
//       ),
//     ).bodyMedium,
//     titleTextStyle: const TextTheme(
//       titleLarge: TextStyle(
//         color: _lightColor,
//         fontSize: 20.0,
//         fontWeight: FontWeight.bold,
//       ),
//     ).titleLarge,
//   ),
//   textTheme: const TextTheme(
//     bodyLarge: TextStyle(color: _lightColor),
//     bodyMedium: TextStyle(color: _lightColor),
//   ),
//   colorScheme: const ColorScheme(
//     primary: _primaryColor,
//     secondary: _successColor,
//     surface: _secondaryDarkColor,
//     background: _darkColor,
//     error: _errorColor,
//     onPrimary: _lightColor,
//     onSecondary: _darkColor,
//     onSurface: _lightColor,
//     onBackground: _lightColor,
//     onError: _lightColor,
//     brightness: Brightness.dark,
//   ),
//   navigationBarTheme: const NavigationBarThemeData(
//     backgroundColor: _secondaryDarkColor,
//     indicatorColor: _primaryColor,
//   ),
//   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//     backgroundColor: _secondaryDarkColor,
//     selectedItemColor: _primaryColor,
//     unselectedItemColor: _lightColor,
//   ),
// );

import 'package:flutter/material.dart';

const Color kPrimary = Color(0xFFFF5000);
const Color kOnPrimary = Color(0xFFF5F5F5);
const Color kSecondary = Color(0xFFFFD700);
const Color kOnSecondary = Color(0xFF333333);
const Color kSurface = Color(0xFFF5F5F5);
const Color kContainer = Color(0xFFFFFFFF);
const Color kTextColor = Color(0xFF333333);
const Color kLightTextColor = Color(0xFF666666);
const Color kBackground = Color(0xFFF5F5F5);
const Color kOnBackground = Color(0xFF333333);
const Color kError = Color(0xFFB00020);
const Color kCheckColor = Color(0xFF008000);
const Color kOnError = Color(0xFFFFFFFF);
const Color kOnSurface = Color(0xFF333333);
const Color kPrimarylight = Color(0x33FF5000);
Color kCircleDecorationLargeColor = const Color(0x4DFFE4B5);
Color kCircleDecorationMediumColor = const Color(0x33FFDAB9);
Color kCircleDecorationSmallColor = const Color(0x33FFA07A);
const String kFontFamily = 'Roboto';
const double kCircleDecorationLargeSize = 150.0;
const double kCircleDecorationMediumSize = 100.0;
const double kCircleDecorationSmallSize = 50.0;
const double kDefaultButtonRadius = 15.0;
const double kNone = 0.0;
const double kDefaultPadding = 15.0;
const double kDefaultOverlayOpacity = 0.1;
const double kDefaultGap = 20;
const double kMediumText = 18;
const double kSmallText = 16;
const double kExtraSmallText = 14;
const double kLargeText = 20;
const double kExtraLargeText = 24;
const double kFocusTextSize = 28;
const double kDefaultDecorationOpacity = 0 - 3;
const double kMinimunPaddingSize = 5;

Icon kMenuIcon = const Icon(
  Icons.menu,
  color: kOnPrimary,
);
Icon kBackIcon = const Icon(
  Icons.arrow_back,
  color: kOnPrimary,
);
Icon kCloseIcon = const Icon(
  Icons.close,
  color: kOnPrimary,
);
const Color kNoColor = Colors.transparent;

final ThemeData lightTheme = ThemeData(
  actionIconTheme: ActionIconThemeData(
    drawerButtonIconBuilder: (context) => kMenuIcon,
    endDrawerButtonIconBuilder: (context) => kMenuIcon,
    backButtonIconBuilder: (context) => kBackIcon,
    closeButtonIconBuilder: (context) => kCloseIcon,
  ),
  fontFamily: kFontFamily,
  drawerTheme: const DrawerThemeData(
    backgroundColor: kPrimary,
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: kPrimary,
    onPrimary: kOnPrimary,
    secondary: kSecondary,
    onSecondary: kOnSecondary,
    error: kError,
    onError: kOnError,
    background: kBackground,
    onBackground: kOnBackground,
    surface: kSurface,
    onSurface: kOnSurface,
  ),
  scaffoldBackgroundColor: kSurface,
  datePickerTheme: const DatePickerThemeData(
    backgroundColor: kBackground,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: kTextColor),
      hintStyle: TextStyle(color: kLightTextColor),
    ),
  ),
);
