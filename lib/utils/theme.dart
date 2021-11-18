import 'dart:ui';

import 'package:flutter/material.dart';

class MyAppTheme {
  Color backgroundColor;
  Color accent1;
  Color txtColor;

  /// Default constructor
  MyAppTheme(
      {required this.backgroundColor,
      required this.accent1,
      required this.txtColor});

  ThemeData get themeData {
    /// Create a TextTheme and ColorScheme, that we can use to generate ThemeData
    TextTheme txtTheme = ThemeData.dark() as TextTheme;
    Color? txtColor = txtTheme.bodyText1!.color;
    ColorScheme colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: accent1,
      primaryVariant: accent1,
      secondary: accent1,
      secondaryVariant: accent1,
      background: backgroundColor,
      surface: backgroundColor,
      onBackground: txtColor!,
      onSurface: txtColor,
      onError: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      error: Colors.red.shade400,
    );

    /// Now that we have ColorScheme and TextTheme, we can create the ThemeData
    var theme = ThemeData.from(textTheme: txtTheme, colorScheme: colorScheme)
        // We can also add on some extra properties that ColorScheme seems to miss
        .copyWith(
      cursorColor: accent1,
      highlightColor: accent1,
      toggleableActiveColor: accent1,
    );

    /// Return the themeData which MaterialApp can now use
    return theme;
  }
}
