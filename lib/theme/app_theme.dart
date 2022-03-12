import 'package:flutter/material.dart';

class AppTheme {

  static const Color primaryColor = Colors.indigo;

  static TextStyle getTitle(BuildContext context) =>
    Theme.of(context).textTheme.headline5!;

  static TextStyle getSubTitle(BuildContext context) =>
    Theme.of(context).textTheme.subtitle1!;

  static TextStyle getCaption(BuildContext context) =>
    Theme.of(context).textTheme.caption!;
  

  static ThemeData get lightTheme => ThemeData.light().copyWith(
    // Primary color
    primaryColor: primaryColor,

    // AppBar theme
    appBarTheme: const AppBarTheme(
      color: primaryColor,
      elevation: 10,
    ),
    
  );
}