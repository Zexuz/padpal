import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static Color primary = Color.fromRGBO(0, 118, 255, 1);

  static Color secondaryColorRed = Color.fromRGBO(255, 0, 80, 1);
  static Color secondaryColorOrange = Color.fromRGBO(255, 158, 0, 1);

  static ThemeData Current = ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.light,
      primaryColor: Color.fromRGBO(0, 118, 255, 1),
      accentColor: Colors.white,
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        buttonColor: primary,
        textTheme: ButtonTextTheme.accent,
        disabledColor: Color.fromRGBO(246, 247, 249, 1),
      ),

      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: GoogleFonts.poppinsTextTheme()
      /*textTheme: TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      )
       */
      );
}
