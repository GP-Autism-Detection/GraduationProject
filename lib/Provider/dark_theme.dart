import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme = FlexThemeData.dark(
  colors: const FlexSchemeColor(
    primary: Color(0xff537895),
    primaryContainer: Color(0xff537895),
    secondary: Color(0xff537895),
    secondaryContainer: Color(0xff537895),
    tertiary: Color(0xff537895),
    tertiaryContainer: Color(0xff537895),
    appBarColor: Color(0xff537895),
    error: Color(0xffcf6679),
  ),
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 16,
  transparentStatusBar: false,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 40,
    useTextTheme: true,
    useM2StyleDividerInM3: true,
    filledButtonSchemeColor: SchemeColor.primaryContainer,
    switchSchemeColor: SchemeColor.onPrimary,
    switchThumbSchemeColor: SchemeColor.primaryContainer,
    checkboxSchemeColor: SchemeColor.primaryContainer,
    inputDecoratorSchemeColor: SchemeColor.shadow,
    inputDecoratorBorderSchemeColor: SchemeColor.onBackground,
    inputDecoratorUnfocusedBorderIsColored: false,
    dialogBackgroundSchemeColor: SchemeColor.surfaceVariant,
    snackBarBackgroundSchemeColor: SchemeColor.primary,
    snackBarActionSchemeColor: SchemeColor.surface,
    appBarBackgroundSchemeColor: SchemeColor.onInverseSurface,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  // To use the Playground font, add GoogleFonts package and uncomment
  // fontFamily: GoogleFonts.notoSans().fontFamily,
);
