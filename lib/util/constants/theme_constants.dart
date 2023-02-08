import 'package:flutter/material.dart';

class ThemeConstants {
  static MaterialColor primarySwatchColor = MaterialColor(
    0xFF4CAF50,
    <int, Color>{
      50: Colors.green.shade50, //10%
      100: Colors.green.shade100, //20%
      200: Colors.green.shade200, //30%
      300: Colors.green.shade300, //40%
      400: Colors.green.shade400, //50%
      500: Colors.green.shade400, //60%
      600: Colors.green.shade600, //70%
      700: Colors.green.shade700, //80%
      800: Colors.green.shade800, //90%
      900: Colors.green.shade900, //100%
    },
  );

  static ThemeData themeConfiguration(BuildContext context, bool isDarkTheme) {
    return ThemeData(
      primarySwatch: Colors.green,
      primaryColor: isDarkTheme ? Colors.black : Colors.white,
      backgroundColor: isDarkTheme ? Colors.black : Color(0xffF1F5FB),
      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),
      highlightColor: isDarkTheme ? Color(0xff372901) : null,
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Colors.green,
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
    );
  }
}
