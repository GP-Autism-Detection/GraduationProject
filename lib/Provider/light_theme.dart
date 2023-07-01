import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = FlexThemeData.light(
  colors: const FlexSchemeColor(
    primary: Color(0xff2196f3),
    primaryContainer: Color(0xff1e88e5),
    secondary: Color(0xff2196f3),
    secondaryContainer: Color(0xff2196f3),
    tertiary: Color(0xff95f0ff),
    tertiaryContainer: Color(0xff01d7f2),
    appBarColor: Color(0xff2196f3),
    error: Color(0xffb00020),
  ),
  transparentStatusBar: false,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    blendOnColors: false,
    useTextTheme: true,
    useM2StyleDividerInM3: true,
    adaptiveAppBarScrollUnderOff: FlexAdaptive.all(),
    filledButtonSchemeColor: SchemeColor.primaryContainer,
    switchSchemeColor: SchemeColor.onPrimary,
    switchThumbSchemeColor: SchemeColor.primaryContainer,
    checkboxSchemeColor: SchemeColor.primaryContainer,
    inputDecoratorSchemeColor: SchemeColor.onPrimary,
    inputDecoratorBorderSchemeColor: SchemeColor.outlineVariant,
    inputDecoratorUnfocusedBorderIsColored: false,
    dialogBackgroundSchemeColor: SchemeColor.surfaceVariant,
    snackBarBackgroundSchemeColor: SchemeColor.primary,
    snackBarActionSchemeColor: SchemeColor.surface,
    appBarBackgroundSchemeColor: SchemeColor.primary,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  // To use the Playground font, add GoogleFonts package and uncomment
  // fontFamily: GoogleFonts.notoSans().fontFamily,
);
