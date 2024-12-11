import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/// The [AppTheme] defines light and dark themes for the app.
///
/// Theme setup for FlexColorScheme package v8.
/// Use same major flex_color_scheme package version. If you use a
/// lower minor version, some properties may not be supported.
/// In that case, remove them after copying this theme to your
/// app or upgrade package to version 8.0.2.
///
/// Use in [MaterialApp] like this:
///
/// MaterialApp(
///  theme: AppTheme.light,
///  darkTheme: AppTheme.dark,
///  :
/// );
sealed class AppTheme {
  // The defined light theme.
  static ThemeData light = FlexThemeData.light(
  colors: const FlexSchemeColor( // Custom colors
    primary: Color(0xFFC11119),
    primaryContainer: Color(0xFFD0E4FF),
    primaryLightRef: Color(0xFFC11119),
    secondary: Color(0xFFAC3306),
    secondaryContainer: Color(0xFFFFDBCF),
    secondaryLightRef: Color(0xFFAC3306),
    tertiary: Color(0xFF006875),
    tertiaryContainer: Color(0xFF95F0FF),
    tertiaryLightRef: Color(0xFF006875),
    appBarColor: Color(0xFFFFDBCF),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
  ),
  usedColors: 1,
  subThemesData: const FlexSubThemesData(
    interactionEffects: true,
    tintedDisabledControls: true,
    useM2StyleDividerInM3: true,
    inputDecoratorIsFilled: true,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    alignedDropdown: true,
    navigationRailUseIndicator: true,
    navigationRailLabelType: NavigationRailLabelType.all,
  ),
  useMaterial3ErrorColors: true,
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
  // The defined dark theme.
  static ThemeData dark = FlexThemeData.dark(
  colors: const FlexSchemeColor(
    primary: Color(0xFFC7282F),
    primaryContainer: Color(0xFFD4E6FF),
    primaryLightRef: Color(0xFFC11119),
    secondary: Color(0xFFB4471E),
    secondaryContainer: Color(0xFFFFDED3),
    secondaryLightRef: Color(0xFFAC3306),
    tertiary: Color(0xFF197682),
    tertiaryContainer: Color(0xFF9FF1FF),
    tertiaryLightRef: Color(0xFF006875),
    appBarColor: Color(0xFFFFDED3),
    error: Color(0x00000000),
    errorContainer: Color(0x00000000),
  ).defaultError.toDark(10, false),
  usedColors: 1,
  subThemesData: const FlexSubThemesData(
    interactionEffects: true,
    tintedDisabledControls: true,
    blendOnColors: true,
    useM2StyleDividerInM3: true,
    inputDecoratorIsFilled: true,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    alignedDropdown: true,
    navigationRailUseIndicator: true,
    navigationRailLabelType: NavigationRailLabelType.all,
  ),
  useMaterial3ErrorColors: true,
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}
