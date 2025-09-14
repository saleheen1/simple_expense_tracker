import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_expense_tracker/core/themes/custom_theme.dart';

class TextUtils {
  static TextStyle title1Bold({color, required context}) {
    return TextStyle(
      color: color ?? CustomTheme.of(context).textColor,
      fontSize: 20,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle title2({color, required context}) {
    return TextStyle(
      color: color ?? CustomTheme.of(context).textColor,
      fontSize: 16,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle title3({color, required context}) {
    return TextStyle(
      color: color ?? CustomTheme.of(context).textColor,
      fontSize: 14,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle b1Regular({color, required context}) {
    return TextStyle(
      color: color ?? CustomTheme.of(context).textColor,
      fontSize: 13,
      fontFamily: GoogleFonts.montserrat().fontFamily,
    );
  }

  static TextStyle b1SemiBold({color, required context}) {
    return TextStyle(
      color: color ?? CustomTheme.of(context).textColor,
      fontSize: 13,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle caption1({color, required context}) {
    return TextStyle(
      color: color ?? Colors.white,
      fontSize: 12,
      fontFamily: GoogleFonts.montserrat().fontFamily,
    );
  }

  static TextStyle captionSemiBold({color, required context}) {
    return TextStyle(
      color: color ?? CustomTheme.of(context).textColor,
      fontSize: 12,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle b1Small({color, required context}) {
    return TextStyle(
      color: color ?? CustomTheme.of(context).textColor,
      fontSize: 10,
      fontFamily: GoogleFonts.montserrat().fontFamily,
    );
  }
}
