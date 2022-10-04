import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appTextTheme = GoogleFonts.firaSansTextTheme(_textTheme).apply(
  bodyColor: Colors.black,
  displayColor: Colors.black,
);

const _textTheme = TextTheme(
  headline1: TextStyle(
    fontSize: 48,
    height: 1.16,
    fontWeight: semiBold,
    letterSpacing: -2,
  ),
  headline2: TextStyle(
    fontSize: 40,
    height: 1.2,
    fontWeight: semiBold,
    letterSpacing: -2,
  ),
  headline3: TextStyle(fontSize: 36, height: 1.2, fontWeight: semiBold),
  headline4: TextStyle(fontSize: 28, height: 1.4, fontWeight: semiBold),
  headline5: TextStyle(fontSize: 24, height: 1.3, fontWeight: semiBold),
  headline6: TextStyle(fontSize: 20, height: 1.4, fontWeight: semiBold),
  subtitle1: TextStyle(
    fontSize: 16,
    height: 1.5,
    fontWeight: semiBold,
  ),
  bodyText1: TextStyle(
    fontSize: 16,
    height: 1.5,
    fontWeight: regular,
  ),
  bodyText2: TextStyle(
    fontSize: 14,
    height: 1.5,
    fontWeight: regular,
  ),
  subtitle2: TextStyle(
    fontSize: 14,
    height: 1.5,
    fontWeight: semiBold,
  ),
  button: TextStyle(
    fontSize: 16,
    fontWeight: semiBold,
  ),
);

class ColorPrimary {
  static const primaryColor = Color.fromARGB(255, 147, 48, 106);
  static const primaryDark = Color(0xFF3DA49B);
}

class ColorGradient {
  static const leftColor = Color.fromARGB(255, 145, 30, 91);
  static const rightColor = Color.fromARGB(255, 25, 24, 96);
}

class ColorNeutral {
  static const neutralWhite = Color(0xFFFFFFFF);
  static const neutral1 = Color(0xFFEBEBEB);
  static const neutral2 = Color(0xFFD1D1D1);
  static const neutral3 = Color(0xFF6B6B6B);
  static const neutralBlack = Color(0xFF000000);
}

const SizedBox verticalSpace4 = SizedBox(height: 4);
const SizedBox verticalSpace8 = SizedBox(height: 8);
const SizedBox verticalSpace10 = SizedBox(height: 10);
const SizedBox verticalSpace12 = SizedBox(height: 12);
const SizedBox verticalSpace16 = SizedBox(height: 16);
const SizedBox verticalSpace20 = SizedBox(height: 20);
const SizedBox verticalSpace24 = SizedBox(height: 24);
const SizedBox verticalSpace32 = SizedBox(height: 32);
const SizedBox verticalSpace40 = SizedBox(height: 40);
const SizedBox verticalSpace48 = SizedBox(height: 48);
const SizedBox verticalSpace60 = SizedBox(height: 60);
const SizedBox verticalSpace64 = SizedBox(height: 64);
const SizedBox verticalSpace80 = SizedBox(height: 80);
const SizedBox verticalSpace120 = SizedBox(height: 120);
const SizedBox horizontalSpace4 = SizedBox(width: 4);
const SizedBox horizontalSpace8 = SizedBox(width: 8);
const SizedBox horizontalSpace10 = SizedBox(width: 10);
const SizedBox horizontalSpace12 = SizedBox(width: 12);
const SizedBox horizontalSpace14 = SizedBox(width: 14);
const SizedBox horizontalSpace16 = SizedBox(width: 16);
const SizedBox horizontalSpace20 = SizedBox(width: 20);
const SizedBox horizontalSpace24 = SizedBox(width: 24);
const SizedBox horizontalspace32 = SizedBox(width: 32);
const SizedBox horizontalSpace40 = SizedBox(width: 40);
const SizedBox horizontalSpace48 = SizedBox(width: 48);
const SizedBox horizontalSpace64 = SizedBox(width: 64);
const SizedBox horizontalSpace80 = SizedBox(width: 80);

const regular = FontWeight.w400;
const semiBold = FontWeight.w600;
const bold = FontWeight.bold;
const light = FontWeight.w300;

class SemanticSuccess {
  static const light = Color(0xFFCFE0B8);
  static const dark = Color(0xFF738C53);
}

class SemanticError {
  static const light = Color(0xFFE79393);
  static const dark = Color(0xFFA12F2F);
}

class SemanticWarning {
  static const light = Color(0xFFFFDF90);
  static const dark = Color(0xFFD39A0D);
}

class SemanticInfo {
  static const light = Color(0xFF9FC6EE);
  static const dark = Color(0xFF174C85);
}

class SemanticAlternative {
  static const light = Color(0xFFDAAFF3);
  static const dark = Color(0xFF702D96);
}

class SemanticApproved {
  static const approvedPositive = Color(0xFF318728);
}

final linkInline1 = GoogleFonts.firaSans(
  textStyle: const TextStyle(
    fontSize: 16,
    height: 1.5,
    fontWeight: semiBold,
  ),
);

final bodyText1Light = GoogleFonts.firaSans(
  textStyle: const TextStyle(
    fontSize: 16,
    height: 1.5,
    fontWeight: light,
  ),
);

final bodyText1 = GoogleFonts.firaSans(
  textStyle: const TextStyle(
    fontSize: 20,
    height: 1.5,
    fontWeight: regular,
  ),
);

final labels = GoogleFonts.firaSans(
  textStyle: const TextStyle(
    fontSize: 14,
    height: 1.57,
    fontWeight: light,
  ),
);

final titleLable = GoogleFonts.firaSans(
  textStyle: const TextStyle(
    fontSize: 16,
    height: 1.57,
    fontWeight: bold,
  ),
);

class IconSize {
  static const xs = 16.0;
  static const sm = 20.0;
  static const md = 24.0;
  static const lg = 28.0;
  static const xl = 32.0;
}

//BUTTON

final buttonSmall = GoogleFonts.firaSans(
  textStyle: const TextStyle(
    fontSize: 12,
    fontWeight: bold,
    letterSpacing: 0.5,
  ),
);
final buttonMedium = GoogleFonts.firaSans(
  textStyle: const TextStyle(
    fontSize: 14,
    fontWeight: bold,
    letterSpacing: 1,
  ),
);

// REVISAR

double kSpacing = 25.00;

BorderRadius kBorderRadius = BorderRadius.circular(5.5);
EdgeInsets kHPadding = const EdgeInsets.symmetric(horizontal: 50.00);
EdgeInsets kVPadding = const EdgeInsets.symmetric(horizontal: 20.00);
