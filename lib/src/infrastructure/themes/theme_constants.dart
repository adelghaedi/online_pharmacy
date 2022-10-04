import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.indigo,
  brightness: Brightness.light,
  fontFamily: 'IranSans',
  scaffoldBackgroundColor: Colors.grey.shade200,
  dividerColor: Colors.black,
  iconTheme: const IconThemeData(color: Colors.indigo),
  listTileTheme: ListTileThemeData(
    shape: RoundedRectangleBorder(
      side: BorderSide(width: 1.5, color: Colors.indigo.withOpacity(0.8)),
      borderRadius: const BorderRadius.all(
        Radius.circular(12.0),
      ),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.indigo.withOpacity(0.8),
    foregroundColor: Colors.white,
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Colors.indigo.withOpacity(
      0.8,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
      side: MaterialStateProperty.all<BorderSide>(
        const BorderSide(
          width: 1.5,
          color: Colors.indigo,
        ),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(
        Colors.black,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.indigo.withOpacity(
            0.8,
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))))),
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: const TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.grey.shade200,
    iconTheme: const IconThemeData(
      size: 30,
      color: Colors.black,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: Colors.indigo.withOpacity(0.8)),
      borderRadius: const BorderRadius.all(
        Radius.circular(12.0),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red.withOpacity(0.8),
        width: 1.5,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(12.0),
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red.withOpacity(0.8),
        width: 1.5,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(12.0),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: Colors.indigo.withOpacity(0.8)),
      borderRadius: const BorderRadius.all(
        Radius.circular(12.0),
      ),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'IranSans',
  primarySwatch: Colors.indigo,
  scaffoldBackgroundColor: Colors.grey.shade900,
  dividerColor: Colors.white,
  iconTheme: const IconThemeData(color: Colors.indigo),
  listTileTheme: ListTileThemeData(
    shape: RoundedRectangleBorder(
      side: BorderSide(width: 1.5, color: Colors.indigo.withOpacity(0.6)),
      borderRadius: const BorderRadius.all(
        Radius.circular(12.0),
      ),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.indigo.withOpacity(0.6),
    foregroundColor: Colors.white,
  ),
  progressIndicatorTheme:
      ProgressIndicatorThemeData(color: Colors.indigo.withOpacity(0.6)),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      side: MaterialStateProperty.all<BorderSide>(
        BorderSide(
          width: 1.5,
          color: Colors.indigo.withOpacity(0.6),
        ),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(
        Colors.white,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        Colors.indigo.withOpacity(
          0.6,
        ),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: const TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.grey.shade900,
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 30,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: Colors.indigo.withOpacity(0.8)),
      borderRadius: const BorderRadius.all(
        Radius.circular(12.0),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red.withOpacity(0.6),
        width: 1.5,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(12.0),
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red.withOpacity(0.6),
        width: 1.5,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(12.0),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.5,
        color: Colors.indigo.withOpacity(0.6),
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(12.0),
      ),
    ),
  ),
);
