import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// TODO Use theese icons https://pub.dev/packages/cupertino_icons
// https://medium.com/flutter/announcing-flutter-1-22-44f146009e5f

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
      height: 36,
    ),
    textTheme: TextTheme(
      headline1: GoogleFonts.poppinsTextTheme().headline1,
      headline2: GoogleFonts.poppinsTextTheme().headline2,
      headline3: GoogleFonts.poppinsTextTheme().headline3,
      headline4: GoogleFonts.poppinsTextTheme().headline4,
      headline5: GoogleFonts.poppinsTextTheme().headline5,
      headline6: GoogleFonts.poppinsTextTheme().headline6,
      subtitle1: GoogleFonts.poppinsTextTheme().subtitle1,
      subtitle2: GoogleFonts.poppinsTextTheme().subtitle2,
      bodyText1: GoogleFonts.poppinsTextTheme().bodyText1,
      bodyText2: GoogleFonts.poppinsTextTheme().bodyText2,
      caption: GoogleFonts.poppinsTextTheme().caption,
      button: GoogleFonts.poppinsTextTheme().button.copyWith(fontWeight: FontWeight.w600),
      overline: GoogleFonts.poppinsTextTheme().overline,
    ),
  );
}
