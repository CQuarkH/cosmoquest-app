import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppTheme {
  final ColorScheme _themeColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: HexColor("#090A0F"),
    onPrimary: HexColor("#F5F6FA"),
    secondary: HexColor("#465483"),
    onSecondary: HexColor("#D1D6E6"),
    error: HexColor("#F23A40"),
    onError: HexColor("#F5F6FA"),
    background: HexColor("#0d0d0f"),
    onBackground: HexColor("#F5F6FA"),
    surface: HexColor("#4C11A1"),
    onSurface: HexColor("#FAFAFA"),
  );

  ThemeData get themeData {
    return ThemeData(
        fontFamily: 'Onest',
        colorScheme: _themeColorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: _themeColorScheme.primary,
        ),
        cardColor: _themeColorScheme.secondary.withOpacity(0.2),
        dividerTheme: DividerThemeData(
            color: _themeColorScheme.onBackground.withOpacity(0.5)),
        textTheme: TextTheme(
            displayLarge: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _themeColorScheme.onPrimary),
            displayMedium: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: _themeColorScheme.onPrimary),
            displaySmall: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: _themeColorScheme.onPrimary),
            bodyLarge: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: _themeColorScheme.onBackground),
            bodyMedium: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: _themeColorScheme.onBackground),
            bodySmall: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: _themeColorScheme.onBackground)));
  }
}
