import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static Color primary = const Color(0xff0076FF);
  static Color light = Color.fromRGBO(224, 239, 255, 1.0);
  static Color disabled = const Color(0xF6F7F9ff);

  static Color lightGrayText = const Color(0xFF959DA6);
  static Color lightGrayBackground = const Color(0xFFF6F7F9);

  static Color secondaryButtonColor = Colors.white;
  static Color secondaryButtonTextColor = Colors.black;

  static Color secondaryColorRed = Color.fromRGBO(255, 0, 80, 1);
  static Color secondaryColorOrange = Color.fromRGBO(255, 158, 0, 1);
  static Color secondaryColorOrangeWithOpacity = Color.fromRGBO(255, 158, 0, 0.12);

  static TextStyle logo =
      TextStyle(color: primary, fontWeight: FontWeight.w700, fontStyle: FontStyle.italic, fontSize: 21);

  static ThemeData Current = ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.light,
      primaryColor: primary,
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
      textTheme: GoogleFonts.poppinsTextTheme(),
      /*textTheme: TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      )
       */
      );
}
