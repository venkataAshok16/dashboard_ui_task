import 'package:flutter/material.dart';
import 'font_size_constants.dart';

class StyleConstants {
  static late TextStyle headingGreen;
  static late TextStyle headingPrimary;
  static late TextStyle headingSecondary;

  static late TextStyle titleGreen;
  static late TextStyle titleGrey;
  static late TextStyle titlePrimary;
  static late TextStyle titleSecondary;

  static void assignTextStyleBasedOnTheme(BuildContext context) {
    headingGreen = TextStyle(fontSize: FontSizeConstants.primary, fontWeight: FontWeight.w800, color: Colors.green);
    headingPrimary = TextStyle(
        fontSize: FontSizeConstants.primary,
        fontWeight: FontWeight.bold,
        color: (Theme.of(context).brightness == Brightness.light) ? Colors.white : Colors.black);
    headingSecondary = TextStyle(
        fontSize: FontSizeConstants.primary,
        fontWeight: FontWeight.bold,
        color: (Theme.of(context).brightness == Brightness.light) ? Colors.black : Colors.white);

    titleGreen = TextStyle(fontSize: FontSizeConstants.secondary, fontWeight: FontWeight.bold, color: Colors.green);
    titleGrey = TextStyle(fontSize: FontSizeConstants.secondary, fontWeight: FontWeight.bold, color: Colors.grey);
    titlePrimary = TextStyle(
        fontSize: FontSizeConstants.secondary,
        fontWeight: FontWeight.bold,
        color: (Theme.of(context).brightness == Brightness.light) ? Colors.white : Colors.black);
    titleSecondary = TextStyle(
        fontSize: FontSizeConstants.secondary,
        fontWeight: FontWeight.bold,
        color: (Theme.of(context).brightness == Brightness.light) ? Colors.black : Colors.white);
  }
}
