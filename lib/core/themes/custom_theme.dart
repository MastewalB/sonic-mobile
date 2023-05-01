import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get DarkTheme {
    return ThemeData(
      primaryColor: Colors.purple.shade400,
      scaffoldBackgroundColor: const Color.fromARGB(255, 20, 20, 30),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.white,
        contentTextStyle: const TextStyle(
          color: Colors.black,
        ),
        elevation: 10,
        closeIconColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      canvasColor: Colors.purple.shade200,
      indicatorColor: Colors.purple.shade50,
      primaryIconTheme: const IconThemeData(
        color: Colors.white,
        opacity: 1.0,
        size: 6.0,
      ),
      textTheme: const TextTheme(
          displayLarge: TextStyle(
        color: Colors.white,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        letterSpacing: -1.0,
      )),
      appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: Color.fromARGB(255, 47, 49, 66),
          toolbarHeight: 65,
          elevation: 10,
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w400,
          )),
      fontFamily: 'Poppins',
      buttonTheme: ButtonThemeData(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: const Color.fromARGB(200, 93, 84, 143),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        backgroundColor: Color.fromARGB(255, 47, 49, 66),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        selectedIconTheme: IconThemeData(size: 20),
        unselectedIconTheme: IconThemeData(
          size: 18,
        ),
        selectedLabelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        elevation: 10,
        color: Color.fromARGB(245, 45, 45, 40),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Color.fromARGB(200, 93, 84, 143)),
      )),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(200, 93, 84, 143),
      ),
    );
  }
}
