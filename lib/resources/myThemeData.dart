import 'package:flutter/material.dart';

class MyThemeData {
  static final defaultLight = ThemeData.light();
  static final defaultDark = ThemeData.dark();
  static final defaultLerp =
  ThemeData.lerp(ThemeData.fallback(), defaultDark, 2);
  static final darkBlue = ThemeData(
    primaryColorDark: Color(0x881F2D3A),
    primaryColor: Color(0xff1F2D3A),
    primaryColorLight: Color(0xff1F2D45),
    backgroundColor: Color(0x661D2735),
    scaffoldBackgroundColor: Color(0xff1D2731),
    floatingActionButtonTheme:
    FloatingActionButtonThemeData(backgroundColor: Color(0xff5EA3DE)),
    iconTheme: IconThemeData(color: Color(0xffFBFDFF)),
    cardColor: Color(0x881A2741),
    cardTheme: CardTheme(color: Color(0x881A2741)),
    textTheme: TextTheme(
        title: TextStyle(
            color: Color(0xffFBFDFF),
            fontWeight: FontWeight.bold,
            fontSize: 20),
        subtitle: TextStyle(
            color: Color(0xffFBFDFF),
            fontWeight: FontWeight.bold,
            fontSize: 18),
        button: TextStyle(color: Color(0xffFBFDFF)),
        body2: TextStyle(
          color: Color(0xffFBFDFF),
          fontSize: 18,
        ),
        body1: TextStyle(color: Color(0xffFBFDFF), fontSize: 16),
        caption: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w200,
            fontSize: 14)),
    buttonColor: Color(0xff5EA3DE),
    dialogBackgroundColor: Color(0x881F2D3A),
    dividerColor: Colors.blueGrey, );
}
