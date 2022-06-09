import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class ThemeProvider {
  //LightTheme
  ThemeData light = ThemeData.light().copyWith(
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.only(left: 5),
      suffixStyle: TextStyle(
          color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(5),
            backgroundColor: MaterialStateProperty.all(Color(0xff255EDA)))),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Colors.amber),
    appBarTheme: const AppBarTheme(
      color: Color.fromARGB(127, 210, 197, 232),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    primaryColor: Colors.white,
    cardTheme: const CardTheme(color: Colors.white),
    textTheme: TextTheme(
      headline1: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Color(0xffF6F4FB))),
      headline2: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Color(0xff7046e0))),
      headline3: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.grey)),
    ),
  );

  //DarkTheme

  ThemeData getTheme() => light;
}
