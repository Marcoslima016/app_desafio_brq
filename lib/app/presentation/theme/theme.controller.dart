import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:app_desafio_brq/lib.exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ThemeExtension on BuildContext {
  ThemeController get theme => ThemeController.I;
}

class ThemeController with ChangeNotifier {
  late IThemeColorsTokens colors;

  late IThemeTextStylesTokens textStyles;

  late final ILocalStorageAdapter storage;

  final String storageTagDarkMode = "dark-mode-status";

  bool darkThemeActive = true;

  static ThemeController get I => APP.I.themeController;

  IDesignSystemTokens tokens;

  ThemeController({
    required this.tokens,
    required this.storage,
  }) {
    textStyles = tokens.textStylesLight;
    colors = tokens.colorsLight;
  }

  Future initialize() async {
    await _recoverDarkModeStatus();
  }

  Future _recoverDarkModeStatus() async {
    bool? status = await storage.readBool(key: storageTagDarkMode);
    if (status == null) {
      AdaptiveThemeMode? savedTheme = await AdaptiveTheme.getThemeMode();
      if (savedTheme != null) {
        status = savedTheme == AdaptiveThemeMode.light ? status = false : status = true;
      }
    }
    status ??= true;
    changeDarkThemeActivationStatus(status);
  }

  changeDarkThemeActivationStatus(bool newStatus) {
    darkThemeActive = newStatus;
    if (darkThemeActive) {
      colors = tokens.colorsDark;
      textStyles = tokens.textStylesDark;
    } else {
      colors = tokens.colorsLight;
      textStyles = tokens.textStylesLight;
    }
    storage.writeBool(key: storageTagDarkMode, value: darkThemeActive);
    notifyListeners();
  }
}

abstract class IDesignSystemTokens {
  IDesignSystemTokens();
  IThemeColorsTokens get colorsLight;
  IThemeColorsTokens get colorsDark;
  IThemeTextStylesTokens get textStylesLight;
  IThemeTextStylesTokens get textStylesDark;
}

abstract class ISpacingTokens {
  double get xs;
  double get sm;
  double get md;
  double get lg;
  double get xl;
}

abstract class IPaddingTokens {
  double get xs;
  double get sm;
  double get md;
  double get lg;
  double get xl;
}

abstract class IThemeColorsTokens {
  Color get primary;
  Color get primaryVariant;
  Color get onPrimary;
  Color get secondary;
  Color get onSecondary;
  Color get disable;
  Color get onDisable;
  Color get surface;
  Color get onSurface;
  Color get background;
  Color get onBackground;
  Color get neutral;
  Color get containerPrimary;
  Color get containerSecondary;
  Color get containerTertiary;
  Color get onContainer;
}

abstract class IThemeTextStylesTokens {
  ThemeTextStyle get displayExtraLarge;
  ThemeTextStyle get displayLarge;
  ThemeTextStyle get displayMedium;
  ThemeTextStyle get displaySmall;
  ThemeTextStyle get headingLarge;
  ThemeTextStyle get headingMedium;
  ThemeTextStyle get headingSmall;
  ThemeTextStyle get headingExtraSmall;
  ThemeTextStyle get bodyLarge;
  ThemeTextStyle get bodyMedium;
  ThemeTextStyle get bodySmall;
  ThemeTextStyle get bodyMediumBold;
  ThemeTextStyle get labelMedium;
  ThemeTextStyle get labelSmall;
  ThemeTextStyle get labelExtraSmall;
}

class ThemeTextStyle extends TextStyle {
  ThemeTextStyle.style(TextStyle style)
      : super(
          inherit: style.inherit,
          color: style.color,
          backgroundColor: style.backgroundColor,
          fontSize: style.fontSize,
          fontWeight: style.fontWeight,
          fontStyle: style.fontStyle,
          letterSpacing: style.letterSpacing,
          wordSpacing: style.wordSpacing,
          textBaseline: style.textBaseline,
          height: style.height,
          leadingDistribution: style.leadingDistribution,
          locale: style.locale,
          foreground: style.foreground,
          background: style.background,
          shadows: style.shadows,
          fontFeatures: style.fontFeatures,
          decoration: style.decoration,
          decorationColor: style.decorationColor,
          decorationStyle: style.decorationStyle,
          decorationThickness: style.decorationThickness,
          debugLabel: style.debugLabel,
          fontFamily: style.fontFamily,
          fontFamilyFallback: style.fontFamilyFallback,
          // package: style.package,
          overflow: style.overflow,
        );

  @override
  double get fontSize {
    double sizeAdjustedToScreen = super.fontSize!.sp;
    return sizeAdjustedToScreen;
  }
}
