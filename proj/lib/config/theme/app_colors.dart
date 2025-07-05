// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import "package:flutter/material.dart";
import "package:layer_kit_example/config/theme/configs/app_settings_data.dart";

class AppColors {
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color textColor;
  final Color background;
  final Color border;
  final Color shimmerBase;
  final Color shimmerHighlight;
  final Color shimmerContent;

  final Color BLACK = Colors.black;
  final Color WHITE = Colors.white;
  final Color ERROR = Color.fromARGB(255, 166, 4, 4);
  final Color SUCCESS = Color.fromARGB(255, 12, 161, 161);
  final Color WARNING = Color(0xFFC2AF6F);
  final Color BUTTON_TEXT = Colors.white;

  AppColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.textColor,
    required this.background,
    required this.border,
    required this.shimmerBase,
    required this.shimmerHighlight,
    required this.shimmerContent,
  });

  static AppColors get light => AppColors(
        primary: appSettings.lightPrimary ?? Color(0xFFFAFAFA),
        secondary: appSettings.lightSecondary ?? Color(0xFFFFFFFF),
        tertiary: appSettings.lightTertiary ?? Color(0xFF087C7C),
        background: appSettings.lightPrimary ?? Color(0xFFFAFAFA),
        textColor: Color(0xFF4D5454),
        border: Color(0xffEEEEEE).withValues(alpha: 0.6),
        shimmerBase: Color.fromARGB(255, 225, 225, 225),
        shimmerHighlight: Colors.grey.shade100,
        shimmerContent: Colors.white.withValues(alpha: 0.85),
      );

  static AppColors get dark => AppColors(
        primary: appSettings.darkPrimary ?? Color(0xff0C0C0C),
        secondary: appSettings.darkSecondary ?? Color(0xff1C1C1C),
        tertiary: appSettings.darkTertiary ?? Color(0xff53ADAE),
        background: appSettings.darkPrimary ?? Color(0xff0C0C0C),
        textColor: Color(0xffFDFDFD),
        border: Color(0xffFDFDFD),
        shimmerBase: Color.fromARGB(255, 150, 150, 150),
        shimmerHighlight: Colors.grey.shade300,
        shimmerContent: Colors.white.withValues(alpha: 0.7),
      );

  static AppColors fromBrightness(Brightness brightness) => brightness == Brightness.dark ? AppColors.dark : AppColors.light;
}
