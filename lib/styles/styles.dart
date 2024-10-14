import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class XColors {
  static const Color colorBlue = Color(0xFF03A9F5);
  static const Color colorYellow = Color(0xFFF7D046);
  static const Color colorDark = Color(0xFF262626);
}

ThemeData buildTheme(Color primaryColor, Brightness brightness) {
  /// Apply theme colors
  var baseTheme = ThemeData(
    colorScheme:
        ColorScheme.fromSeed(seedColor: primaryColor, brightness: brightness),
    useMaterial3: true,
  );

  /// Apply theme font
  final poppingTextTheme = GoogleFonts.poppinsTextTheme(baseTheme.textTheme);
  baseTheme = baseTheme.copyWith(textTheme: poppingTextTheme);

  /// Apply theme inputDecorators
  final inputDecorationTheme = InputDecorationTheme(
    alignLabelWithHint: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    fillColor: baseTheme.colorScheme.surface,
    filled: true,
    suffixIconColor: baseTheme.colorScheme.primary,

    /// Text Styles
    labelStyle: TextStyle(
      color: baseTheme.colorScheme.onSurface.withAlpha(120),
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    hintStyle: TextStyle(
      color: baseTheme.colorScheme.onSurface.withAlpha(120),
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
    errorStyle: TextStyle(
      color: baseTheme.colorScheme.error,
      fontSize: 10,
      fontWeight: FontWeight.w500,
    ),
    counterStyle: TextStyle(
      color: baseTheme.colorScheme.onSurface,
      fontSize: 10,
      fontWeight: FontWeight.w500,
    ),

    /// Border Styles
    border: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(
        color: baseTheme.colorScheme.inversePrimary,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(
        color: baseTheme.colorScheme.primary,
        width: 1.5,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(
        color: baseTheme.disabledColor,
        width: 1,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(
        color: baseTheme.colorScheme.error,
        width: 1,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      // borderSide: BorderSide.none,
      borderSide: BorderSide(
        color: baseTheme.colorScheme.error,
        width: 1.5,
      ),
    ),
  );
  baseTheme = baseTheme.copyWith(inputDecorationTheme: inputDecorationTheme);

  /// Apply theme button Style
  final filledButtonTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      fixedSize: const Size.fromHeight(48),
      textStyle:
          baseTheme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
    ),
  );
  baseTheme = baseTheme.copyWith(filledButtonTheme: filledButtonTheme);

  /// Apply theme NavBar style
  final navBarTheme = NavigationBarThemeData(
    iconTheme: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: baseTheme.colorScheme.primary);
        } else if (states.contains(WidgetState.disabled)) {
          return IconThemeData(color: baseTheme.disabledColor);
        }
        return IconThemeData(color: baseTheme.colorScheme.onSurface);
      },
    ),
    labelTextStyle: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return baseTheme.textTheme.bodySmall?.copyWith(
            color: baseTheme.colorScheme.primary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          );
        } else if (states.contains(WidgetState.disabled)) {
          return baseTheme.textTheme.bodySmall
              ?.copyWith(color: baseTheme.disabledColor, fontSize: 12);
        }
        return baseTheme.textTheme.bodySmall
            ?.copyWith(color: baseTheme.colorScheme.onSurface, fontSize: 12);
      },
    ),
  );
  baseTheme = baseTheme.copyWith(navigationBarTheme: navBarTheme);

  return baseTheme;
}
