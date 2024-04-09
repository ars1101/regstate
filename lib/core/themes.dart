import 'package:flutter/material.dart';

var Themes = ThemeData(
    filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
            backgroundColor: Color(0xFF7576D6),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            disabledBackgroundColor: Color(0xFFA7A7A7),
            foregroundColor: Colors.white,
            disabledForegroundColor: Colors.white)),
    inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
            color: Color.fromARGB(255, 167, 167, 167),
            fontSize: 14,
            fontWeight: FontWeight.w500)),
    fontFamily: 'Roboto',
    textTheme: TextTheme(
        titleLarge: TextStyle(
            fontSize: 24,
            color: Color(0xFF3A3A3A),
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto'),
        titleSmall: TextStyle(
            color: Color(0xFF5C636A),
            fontSize: 14,
            fontWeight: FontWeight.w500)),
    checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          return (states.contains(MaterialState.selected))
              ? const Color(0xFF0560FA)
              : const Color(0xFFFFFFFF);
        }),
        side: const BorderSide(
          color: Color(0xFF006CEC),
        )));

Color accent = Color(0xFF7576D6);