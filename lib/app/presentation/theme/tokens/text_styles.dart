import 'package:flutter/material.dart';

import '../theme.exports.dart';

//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

class DesignSystem {
  final ThemeTextStyle displayExtraLargeLIGHT = PocTextStyleTokens.displayExtraLarge;
}

abstract class IThemeTextStylesTokensPOC {
  ThemeTextStyle get displayExtraLarge;
}

class PocTextStyleTokens {
  PocTextStyleTokens();

  static const TextStyle _parent = TextStyle(
    fontFamily: "Poppins",
  );

  static ThemeTextStyle displayExtraLarge = ThemeTextStyle.style(
    PocTextStyleTokens._parent.copyWith(
      fontSize: 30,
      fontWeight: FontWeight.w900,
      color: const Color.fromARGB(255, 21, 21, 21),
    ),
  );
}

//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

class ThemeTextStylesTokensLight implements IThemeTextStylesTokens {
  ThemeTextStylesTokensLight();

  static const TextStyle _parent = TextStyle(
    fontFamily: "Poppins",
  );

  //----------------------------------------- DISPLAY -----------------------------------------

  @override
  final ThemeTextStyle displayExtraLarge = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 30,
      fontWeight: FontWeight.w900,
      color: const Color.fromARGB(255, 21, 21, 21),
    ),
  );

  @override
  final ThemeTextStyle displayLarge = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 28,
      fontWeight: FontWeight.w900,
      color: const Color.fromARGB(255, 29, 29, 29),
    ),
  );

  @override
  ThemeTextStyle displayMedium = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      color: const Color.fromARGB(255, 29, 29, 29),
    ),
  );

  @override
  ThemeTextStyle displaySmall = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: const Color.fromARGB(255, 29, 29, 29),
    ),
  );

  //------------------------------------------ HEADING ------------------------------------------

  @override
  ThemeTextStyle headingLarge = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: const Color.fromARGB(255, 29, 29, 29),
    ),
  );

  @override
  ThemeTextStyle headingMedium = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: const Color.fromARGB(255, 29, 29, 29),
    ),
  );

  @override
  ThemeTextStyle headingSmall = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: const Color.fromARGB(255, 29, 29, 29),
    ),
  );

  @override
  ThemeTextStyle headingExtraSmall = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: const Color.fromARGB(255, 29, 29, 29),
    ),
  );

  //-------------------------------------------- BODY --------------------------------------------

  @override
  ThemeTextStyle bodyLarge = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      // height: 1.18,
      color: const Color.fromARGB(255, 145, 145, 145),
    ),
  );

  @override
  ThemeTextStyle bodyMedium = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      // height: 1.18,
      color: const Color.fromARGB(255, 21, 21, 21),
    ),
  );

  @override
  ThemeTextStyle bodySmall = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 13.5,
      fontWeight: FontWeight.w400,
      // height: 1.18,
      color: Colors.grey[600],
    ),
  );

  @override
  ThemeTextStyle bodyMediumBold = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w800,
      height: 1.18,
      color: Colors.grey[200],
    ),
  );

  //-------------------------------------------- LABEL --------------------------------------------

  @override
  ThemeTextStyle labelMedium = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      height: 1.18,
      color: const Color.fromARGB(255, 206, 206, 206),
    ),
  );

  @override
  ThemeTextStyle labelSmall = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      height: 1.18,
      color: const Color.fromARGB(255, 206, 206, 206),
    ),
  );

  @override
  ThemeTextStyle labelExtraSmall = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 10,
      fontWeight: FontWeight.w300,
      height: 1.18,
      color: Colors.grey[500],
    ),
  );
}

///
///
//==================================================================================================================
//==================================================================================================================
//==================================================================================================================
///

class ThemeTextStylesTokensDark implements IThemeTextStylesTokens {
  ThemeTextStylesTokensDark();

  static const TextStyle _parent = TextStyle(
    fontFamily: "Poppins",
  );

  //----------------------------------------- DISPLAY -----------------------------------------

  @override
  final ThemeTextStyle displayExtraLarge = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 30,
      fontWeight: FontWeight.w900,
      color: Colors.white,
    ),
  );

  @override
  final ThemeTextStyle displayLarge = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 28,
      fontWeight: FontWeight.w900,
      color: Colors.white,
    ),
  );

  @override
  ThemeTextStyle displayMedium = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      color: Colors.white,
    ),
  );

  @override
  ThemeTextStyle displaySmall = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
  );

  //------------------------------------------ HEADING ------------------------------------------

  @override
  ThemeTextStyle headingLarge = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: const Color.fromARGB(255, 205, 205, 205),
    ),
  );

  @override
  ThemeTextStyle headingMedium = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: const Color.fromARGB(255, 205, 205, 205),
    ),
  );

  @override
  ThemeTextStyle headingSmall = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: const Color.fromARGB(255, 205, 205, 205),
    ),
  );

  @override
  ThemeTextStyle headingExtraSmall = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: const Color.fromARGB(255, 205, 205, 205),
    ),
  );

  //-------------------------------------------- BODY --------------------------------------------

  @override
  ThemeTextStyle bodyLarge = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      // height: 1.18,
      color: const Color.fromARGB(255, 198, 198, 198),
    ),
  );

  @override
  ThemeTextStyle bodyMedium = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      // height: 1.18,
      color: const Color.fromARGB(255, 198, 198, 198),
    ),
  );

  @override
  ThemeTextStyle bodySmall = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      // height: 1.18,
      color: const Color.fromARGB(255, 198, 198, 198),
    ),
  );

  @override
  ThemeTextStyle bodyMediumBold = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w800,
      height: 1.18,
      color: const Color.fromARGB(255, 198, 198, 198),
    ),
  );

  //-------------------------------------------- LABEL --------------------------------------------

  @override
  ThemeTextStyle labelMedium = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      height: 1.18,
      color: const Color.fromARGB(255, 109, 109, 109),
    ),
  );

  @override
  ThemeTextStyle labelSmall = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      height: 1.18,
      color: const Color.fromARGB(255, 85, 85, 85),
    ),
  );

  @override
  ThemeTextStyle labelExtraSmall = ThemeTextStyle.style(
    _parent.copyWith(
      fontSize: 10,
      fontWeight: FontWeight.w300,
      height: 1.18,
      color: const Color.fromARGB(255, 109, 109, 109),
    ),
  );
}

// class ThemeTextStyle extends TextStyle {
//   // const ThemeTextStyle._();

//   ThemeTextStyle.style(TextStyle style)
//       : super(
//           inherit: style.inherit,
//           color: style.color,
//           backgroundColor: style.backgroundColor,
//           fontSize: style.fontSize,
//           fontWeight: style.fontWeight,
//           fontStyle: style.fontStyle,
//           letterSpacing: style.letterSpacing,
//           wordSpacing: style.wordSpacing,
//           textBaseline: style.textBaseline,
//           height: style.height,
//           leadingDistribution: style.leadingDistribution,
//           locale: style.locale,
//           foreground: style.foreground,
//           background: style.background,
//           shadows: style.shadows,
//           fontFeatures: style.fontFeatures,
//           decoration: style.decoration,
//           decorationColor: style.decorationColor,
//           decorationStyle: style.decorationStyle,
//           decorationThickness: style.decorationThickness,
//           debugLabel: style.debugLabel,
//           fontFamily: style.fontFamily,
//           fontFamilyFallback: style.fontFamilyFallback,
//           // package: style.package,
//           overflow: style.overflow,
//         );

//   @override
//   double get fontSize {
//     double sizeAdjustedToScreen = super.fontSize!.sp;
//     return sizeAdjustedToScreen;
//   }
// }
