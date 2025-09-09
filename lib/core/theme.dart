import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utility/appColor.dart';

final themeProvider = Provider<ThemeData>((ref) {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFF9FAFB),
    textTheme: GoogleFonts.plusJakartaSansTextTheme(),
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.light,
      primarySwatch: createMaterialColor(AppColors.primary500),
      backgroundColor: const Color(0xFFF9FAFB),
    ),
  );
});

final darkThemeProvider = Provider<ThemeData>((ref) {
  return ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFF111827),
    textTheme: GoogleFonts.plusJakartaSansTextTheme(),
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      primarySwatch: createMaterialColor(AppColors.primary500),
      backgroundColor: const Color(0xFF111827),
    ),
  );
});

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
