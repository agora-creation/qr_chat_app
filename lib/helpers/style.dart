import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData themeData() {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF7F6EB),
    fontFamily: 'SourceHanSerif-Regular',
    appBarTheme: const AppBarTheme(
      color: Color(0xFFF7F6EB),
      elevation: 0,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: TextStyle(
        color: Color(0xFF333333),
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'SourceHanSerif-Bold',
      ),
      iconTheme: IconThemeData(color: Color(0xFF333333)),
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Color(0xFF333333)),
      bodyText2: TextStyle(color: Color(0xFF333333)),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

const TextStyle kTitleStyle = TextStyle(
  color: Color(0xFF333333),
  fontSize: 40,
  fontWeight: FontWeight.bold,
  fontFamily: 'SourceHanSerif-Bold',
  letterSpacing: 1,
);
