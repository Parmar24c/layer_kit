//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:layer_kit/layer_kit.dart';


enum EnvType {
  development,
  developmentWithPrint,
  production,
  ;

  bool get isDevelopment => this == EnvType.development;
  bool get isDevelopmentWithPrint => this == EnvType.developmentWithPrint;
  bool get isProduction => this == EnvType.production;
}

class KitConfig {
  KitConfig._();

  // Environment Configuration
  static EnvType envType = EnvType.development;
  static bool isIOS = Platform.isIOS;
  static bool showApiReqLog = true;
  static bool showApiResLog = true;
  static bool showDevLog = true;
  static bool showDevErrorLog = true;
  static bool removeTryCatch = false;

  // UI/UX Configuration
  static TransitionType transitionType = TransitionType.slideLeft;
  static double textBoldSizeGlobal = 1.6.t;
  static double textPrimarySizeGlobal = 1.6.t;
  static double textSecondarySizeGlobal = 1.4.t;
  static String? fontFamilyBoldGlobal = "Poppins";
  static String? fontFamilyPrimaryGlobal = "Poppins";
  static String? fontFamilySecondaryGlobal = "Poppins";
  static FontWeight fontWeightBoldGlobal = FontWeight.bold;
  static FontWeight fontWeightPrimaryGlobal = FontWeight.normal;
  static FontWeight fontWeightSecondaryGlobal = FontWeight.normal;

  // Button Configuration
  static double defaultAppButtonRadius = 8.0;
  static double defaultAppButtonElevation = 4.0;

  // InkWell Configuration
  static Color? defaultInkWellSplashColor;
  static Color? defaultInkWellHoverColor;
  static Color? defaultInkWellHighlightColor;
  static double? defaultInkWellRadius;

  // Shadow Configuration
  static Color shadowColorGlobal = Colors.grey.withOpacity(0.2);
  static int defaultElevation = 4;
  static double defaultRadius = 8.0;
  static double defaultBlurRadius = 4.0;
  static double defaultSpreadRadius = 1.0;
  static double defaultAppBarElevation = 4.0;

  // Other Settings
  static int passwordLengthGlobal = 6;
  static int apiLogDataLengthInChars = 5000;
  static ShapeBorder? defaultDialogShape;
  static String defaultCurrencySymbol = RS;

  /// Initialize LayerKitConfig with custom parameters
  static void init({
    // Environment parameters
    EnvType? envType,
    bool? showApiReqLog,
    bool? showApiResLog,
    bool? showDevLog,
    bool? showDevErrorLog,
    bool? removeTryCatch,

    // UI/UX parameters
    TransitionType? transitionType,
    double? textBoldSizeGlobal,
    double? textPrimarySizeGlobal,
    double? textSecondarySizeGlobal,
    String? fontFamilyBoldGlobal,
    String? fontFamilyPrimaryGlobal,
    String? fontFamilySecondaryGlobal,
    FontWeight? fontWeightBoldGlobal,
    FontWeight? fontWeightPrimaryGlobal,
    FontWeight? fontWeightSecondaryGlobal,

    // Button parameters
    double? defaultAppButtonRadius,
    double? defaultAppButtonElevation,

    // InkWell parameters
    Color? defaultInkWellSplashColor,
    Color? defaultInkWellHoverColor,
    Color? defaultInkWellHighlightColor,
    double? defaultInkWellRadius,

    // Shadow parameters
    Color? shadowColorGlobal,
    int? defaultElevation,
    double? defaultRadius,
    double? defaultBlurRadius,
    double? defaultSpreadRadius,
    double? defaultAppBarElevation,

    // Other parameters
    int? passwordLengthGlobal,
    ShapeBorder? defaultDialogShape,
    String? defaultCurrencySymbol,

    // Required context for size initialization
    required BuildContext context,
  }) {
    // Environment configuration
    RouteConfig.setDefaultTransition(
        transitionType ?? KitConfig.transitionType);

    KitConfig.envType = envType ?? KitConfig.envType;
    KitConfig.showApiReqLog = showApiReqLog ?? KitConfig.showApiReqLog;
    KitConfig.showApiResLog = showApiResLog ?? KitConfig.showApiResLog;
    KitConfig.showDevLog = showDevLog ?? KitConfig.showDevLog;
    KitConfig.showDevErrorLog = showDevErrorLog ?? KitConfig.showDevErrorLog;
    KitConfig.removeTryCatch = removeTryCatch ?? KitConfig.removeTryCatch;

    // UI/UX configuration
    KitConfig.transitionType = transitionType ?? KitConfig.transitionType;
    KitConfig.textBoldSizeGlobal =
        textBoldSizeGlobal ?? KitConfig.textBoldSizeGlobal;
    KitConfig.textPrimarySizeGlobal =
        textPrimarySizeGlobal ?? KitConfig.textPrimarySizeGlobal;
    KitConfig.textSecondarySizeGlobal =
        textSecondarySizeGlobal ?? KitConfig.textSecondarySizeGlobal;
    KitConfig.fontFamilyBoldGlobal =
        fontFamilyBoldGlobal ?? KitConfig.fontFamilyBoldGlobal;
    KitConfig.fontFamilyPrimaryGlobal =
        fontFamilyPrimaryGlobal ?? KitConfig.fontFamilyPrimaryGlobal;
    KitConfig.fontFamilySecondaryGlobal =
        fontFamilySecondaryGlobal ?? KitConfig.fontFamilySecondaryGlobal;
    KitConfig.fontWeightBoldGlobal =
        fontWeightBoldGlobal ?? KitConfig.fontWeightBoldGlobal;
    KitConfig.fontWeightPrimaryGlobal =
        fontWeightPrimaryGlobal ?? KitConfig.fontWeightPrimaryGlobal;
    KitConfig.fontWeightSecondaryGlobal =
        fontWeightSecondaryGlobal ?? KitConfig.fontWeightSecondaryGlobal;

    // Button configuration
    KitConfig.defaultAppButtonRadius =
        defaultAppButtonRadius ?? KitConfig.defaultAppButtonRadius;
    KitConfig.defaultAppButtonElevation =
        defaultAppButtonElevation ?? KitConfig.defaultAppButtonElevation;

    // InkWell configuration
    KitConfig.defaultInkWellSplashColor =
        defaultInkWellSplashColor ?? KitConfig.defaultInkWellSplashColor;
    KitConfig.defaultInkWellHoverColor =
        defaultInkWellHoverColor ?? KitConfig.defaultInkWellHoverColor;
    KitConfig.defaultInkWellHighlightColor =
        defaultInkWellHighlightColor ?? KitConfig.defaultInkWellHighlightColor;
    KitConfig.defaultInkWellRadius =
        defaultInkWellRadius ?? KitConfig.defaultInkWellRadius;

    // Shadow configuration
    KitConfig.shadowColorGlobal =
        shadowColorGlobal ?? KitConfig.shadowColorGlobal;
    KitConfig.defaultElevation = defaultElevation ?? KitConfig.defaultElevation;
    KitConfig.defaultRadius = defaultRadius ?? KitConfig.defaultRadius;
    KitConfig.defaultBlurRadius =
        defaultBlurRadius ?? KitConfig.defaultBlurRadius;
    KitConfig.defaultSpreadRadius =
        defaultSpreadRadius ?? KitConfig.defaultSpreadRadius;
    KitConfig.defaultAppBarElevation =
        defaultAppBarElevation ?? KitConfig.defaultAppBarElevation;

    // Other settings
    KitConfig.passwordLengthGlobal =
        passwordLengthGlobal ?? KitConfig.passwordLengthGlobal;
    KitConfig.defaultDialogShape =
        defaultDialogShape ?? KitConfig.defaultDialogShape;
    KitConfig.defaultCurrencySymbol =
        defaultCurrencySymbol ?? KitConfig.defaultCurrencySymbol;
  }
}
