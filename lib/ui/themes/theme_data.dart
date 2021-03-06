import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static const _lightFillColor = Color(0xFF334657);
  static const _darkFillColor = Color(0xFFEDF1FA);

  static const _enabledColor = Color(0xFF3FD89A);
  static const _disabledColor = Color(0xFFFF535C);
  static const _favoritesColor = Color(0xFFFFCB05);

  static final Color _lightFocusColor = _lightFillColor.withOpacity(0.12);
  static final Color _darkFocusColor = _darkFillColor.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      brightness: colorScheme.brightness,
      fontFamily: 'Sinter',
      textTheme: TextTheme(
        headline1: TextStyle(
            color: colorScheme.onBackground,
            fontWeight: _ultra,
            fontSize: 26.0),
        headline2: TextStyle(
            color: colorScheme.onBackground, fontWeight: _bold, fontSize: 26.0),
        headline3: TextStyle(
            color: colorScheme.onBackground, fontWeight: _bold, fontSize: 24.0),
        headline4: TextStyle(
            color: colorScheme.onBackground, fontWeight: _bold, fontSize: 20.0),
        bodyText1: TextStyle(
            color: colorScheme.onBackground,
            fontWeight: _medium,
            fontSize: 20.0),
        bodyText2: TextStyle(
            color: colorScheme.onBackground,
            fontWeight: _medium,
            fontSize: 10.0),
        subtitle1: TextStyle(
            color: colorScheme.onBackground,
            fontWeight: _regular,
            fontSize: 20.0),
        subtitle2: TextStyle(
            color: colorScheme.onBackground,
            fontWeight: _regular,
            fontSize: 16.0),
        // overline: TextStyle(color: colorScheme.onBackground, fontWeight: _medium, fontSize: 12.0),
        // caption: TextStyle(color: colorScheme.onBackground, fontWeight: _ultra, fontSize: 16.0),
        // button: TextStyle(color: colorScheme.onBackground, fontWeight: _ultra, fontSize: 14.0),
      ),
      primaryColor: colorScheme.primary,
      accentColor: colorScheme.primary,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      cardColor: colorScheme.secondary,
      scaffoldBackgroundColor: colorScheme.background,
      backgroundColor: colorScheme.background,
      canvasColor: colorScheme.background,
      bottomAppBarColor: colorScheme.secondary,
      disabledColor: _disabledColor,
      indicatorColor: _enabledColor,
      toggleableActiveColor: _favoritesColor,
      iconTheme: IconThemeData(
        color: colorScheme.secondary,
      ),
      toggleButtonsTheme: ToggleButtonsThemeData(
          color: _enabledColor, disabledColor: _disabledColor),
      dividerTheme: DividerThemeData(
        color: colorScheme.primary,
        space: 2.0,
        thickness: 2.0,
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: colorScheme.secondary,
            width: 1,
          ),
          gapPadding: 4.0,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
      ),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFDEE5F5),
    primaryVariant: Color(0xFFD8E1F3),
    secondary: Color(0xFFCCD4E7),
    secondaryVariant: Color(0xFFBFC8DF),
    background: Color(0xFFEDF1FA),
    surface: Color(0xFFCCD4E7),
    onBackground: Color(0xFF334657),
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF334657),
    onSurface: Color(0xFF334657),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFF30444D),
    primaryVariant: Color(0xFF435B66),
    secondary: Color(0xFF3F545D),
    secondaryVariant: Color(0xFF516973),
    background: Color(0xFF22353C),
    surface: Color(0xFF3F545D),
    onBackground: Color(0xFFEDF1FA),
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _bold = FontWeight.w700;
  static const _ultra = FontWeight.w900;
}
