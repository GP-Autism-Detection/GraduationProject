import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = FlexThemeData.light(
  colors: const FlexSchemeColor(
    primary: Color(0xff537895),
    primaryContainer: Color(0xff537895),
    secondary: Color(0xff537895),
    secondaryContainer: Color(0xff537895),
    tertiary: Color(0xff95acbd),
    tertiaryContainer: Color(0xff95acbd),
    appBarColor: Color(0xff537895),
    error: Color(0xffb00020),
  ),
  transparentStatusBar: false,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
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
