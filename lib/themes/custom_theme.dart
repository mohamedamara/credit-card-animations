import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payment_card_animations/themes/custom_colors.dart';

class CustomTheme {
  static ThemeData getTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: CustomColors.scaffoldBackgroundColor,
      focusColor: Colors.blue.shade50,
      textTheme: GoogleFonts.sourceCodeProTextTheme(
        Theme.of(context).textTheme,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.blue.shade100,
        selectionColor: Colors.blue.shade100,
        selectionHandleColor: Colors.blue.shade100,
      ),
    );
  }
}
