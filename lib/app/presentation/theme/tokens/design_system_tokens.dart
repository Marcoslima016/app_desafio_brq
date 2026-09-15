import '../theme.exports.dart';

class DesignSystemTokens implements IDesignSystemTokens {
  DesignSystemTokens();

  @override
  IThemeColorsTokens get colorsLight => const ColorsLight();

  @override
  IThemeColorsTokens get colorsDark => const ColorsDark();

  @override
  IThemeTextStylesTokens get textStylesLight => ThemeTextStylesTokensLight();

  @override
  IThemeTextStylesTokens get textStylesDark => ThemeTextStylesTokensDark();
}
