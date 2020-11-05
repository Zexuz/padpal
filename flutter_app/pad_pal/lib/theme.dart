import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// TODO Use theese icons https://pub.dev/packages/cupertino_icons
// https://medium.com/flutter/announcing-flutter-1-22-44f146009e5f

class AppTheme {
  static const Color primary = const Color(0xff0076FF);
  static const Color light = Color.fromRGBO(224, 239, 255, 1.0);
  static const Color disabled = const Color(0xF6F7F9ff);

  static const Color lightGrayText = const Color(0xFF959DA6);
  static const Color lightGrayBackground = const Color(0xFFF6F7F9);

  static const Color secondaryButtonColor = Colors.white;
  static const Color secondaryButtonTextColor = Colors.black;

  static const Color secondaryColorRed = Color.fromRGBO(255, 0, 80, 1);
  static const Color secondaryColorOrange = Color.fromRGBO(255, 158, 0, 1);
  static const Color secondaryColorOrangeWithOpacity = Color.fromRGBO(255, 158, 0, 0.12);

  static const Color customBlack = const Color(0xFF172331);
  static const Color grayIconColor = const Color(0xFFB4BEC9);
  static const Color grayBorder = const Color(0xFFDAE0E7);

  static TextStyle logo =
      TextStyle(color: primary, fontWeight: FontWeight.w700, fontStyle: FontStyle.italic, fontSize: 21);

  static const InputDecoration graySearch = InputDecoration(
    filled: true,
    isDense: true,
    border: const OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        const Radius.circular(10.0),
      ),
      borderSide: BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
    fillColor: lightGrayBackground,
  );

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
      disabledColor: const Color(0XFFF6F7F9),
      height: 36,
    ),
    iconTheme: IconThemeData(
      color: grayIconColor,
    ),
    textTheme: TextTheme(
      headline1: GoogleFonts.poppinsTextTheme()
          .headline1
          .copyWith(color: customBlack, fontWeight: FontWeight.w600, letterSpacing: 0.22, fontSize: 24),
      headline2: GoogleFonts.poppinsTextTheme()
          .headline2
          .copyWith(color: customBlack, fontWeight: FontWeight.w600, letterSpacing: 0.17, fontSize: 18),
      headline3: GoogleFonts.poppinsTextTheme()
          .headline3
          .copyWith(color: customBlack, fontWeight: FontWeight.w600, letterSpacing: 0.13, fontSize: 14),
      headline4: GoogleFonts.poppinsTextTheme()
          .headline4
          .copyWith(color: customBlack, fontWeight: FontWeight.w600, letterSpacing: 0.11, fontSize: 12),
      headline5: GoogleFonts.poppinsTextTheme()
          .headline5
          .copyWith(color: customBlack, fontWeight: FontWeight.w400, letterSpacing: 0.09, fontSize: 10),
      headline6: GoogleFonts.poppinsTextTheme().headline6,
      subtitle1: GoogleFonts.poppinsTextTheme().subtitle1,
      subtitle2: GoogleFonts.poppinsTextTheme().subtitle2,
      bodyText1: GoogleFonts.poppinsTextTheme().bodyText1.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: lightGrayText,
          ),
      bodyText2: GoogleFonts.poppinsTextTheme().bodyText2.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: customBlack,
          ),
      caption: GoogleFonts.poppinsTextTheme().caption,
      button: GoogleFonts.poppinsTextTheme().button.copyWith(fontWeight: FontWeight.w600),
      overline: GoogleFonts.poppinsTextTheme().overline,
    ),
    // inputDecorationTheme: InputDecorationTheme(),
  );
}
