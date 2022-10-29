// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class MochigoTheme {
  //color
  static const Color PRIMARY_COLOR = Color.fromARGB(255, 40, 40, 40);
  static const Color FONT_DARK_COLOR = Color(0xFF120e0b);
  static const Color FONT_LIGHT_COLOR = Color(0XFFda943a);
  static const Color COLOR4 = Color(0xFF8f7b8c);
  static const Color COLOR5 = Color(0xFFf6931b);
  static const Color COLOR6 = Color(0xFFab641f);
  static const Color COLOR7 = Color(0xFFb6702e);
  static const Color COLOR8 = Color(0xFFb6702e);
  static const Color COLOR0 = Color.fromARGB(255, 242, 242, 242);

  //theme
  static ThemeData mytheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: PRIMARY_COLOR,
    scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color.fromARGB(255, 255, 255, 255),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
    fontFamily: 'Nunito',
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: FONT_DARK_COLOR,
        fontSize: 30,
        fontWeight: FontWeight.w700,
      ),
      bodyText2: TextStyle(
        color: FONT_DARK_COLOR,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      headline1: TextStyle(
        color: FONT_DARK_COLOR,
        fontSize: 34,
        fontWeight: FontWeight.w800,
      ),
      headline2: TextStyle(
        color: PRIMARY_COLOR,
        fontSize: 18,
        fontWeight: FontWeight.w300,
      ),
      headline3: TextStyle(
        color: FONT_DARK_COLOR,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      headline4: TextStyle(
        color: Colors.grey,
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: FONT_DARK_COLOR),
  );
}
