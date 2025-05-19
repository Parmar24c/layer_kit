//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:flutter/material.dart';
import 'package:layer_kit/layer_kit.dart';

/// A widget that initializes and provides LayerKitConfig to its child widget tree
@Deprecated("use LayerKitInitializer")
class LayerKitConfigProvider extends StatefulWidget {
  final Widget child;

  // Environment parameters
  final EnvType? envType;
  final bool? showApiReqLog;
  final bool? showApiResLog;
  final bool? showDevLog;
  final bool? showDevErrorLog;
  final bool? removeTryCatch;

  // UI/UX parameters
  final TransitionType? transitionType;
  final double? textBoldSizeGlobal;
  final double? textPrimarySizeGlobal;
  final double? textSecondarySizeGlobal;
  final String? fontFamilyBoldGlobal;
  final String? fontFamilyPrimaryGlobal;
  final String? fontFamilySecondaryGlobal;
  final FontWeight? fontWeightBoldGlobal;
  final FontWeight? fontWeightPrimaryGlobal;
  final FontWeight? fontWeightSecondaryGlobal;

  // Button parameters
  final double? defaultAppButtonRadius;
  final double? defaultAppButtonElevation;

  // InkWell parameters
  final Color? defaultInkWellSplashColor;
  final Color? defaultInkWellHoverColor;
  final Color? defaultInkWellHighlightColor;
  final double? defaultInkWellRadius;

  // Shadow parameters
  final Color? shadowColorGlobal;
  final int? defaultElevation;
  final double? defaultRadius;
  final double? defaultBlurRadius;
  final double? defaultSpreadRadius;
  final double? defaultAppBarElevation;

  // Other parameters
  final int? passwordLengthGlobal;
  final ShapeBorder? defaultDialogShape;
  final String? defaultCurrencySymbol;

  /// Creates a LayerKitConfigProvider to initialize the LayerKitConfig
  /// for the application and provide it to the widget tree.
  ///
  /// The [child] parameter is required and typically should be your
  /// application's root widget (like MaterialApp).
  const LayerKitConfigProvider({
    Key? key,
    required this.child,

    // Environment parameters
    this.envType,
    this.showApiReqLog,
    this.showApiResLog,
    this.showDevLog,
    this.showDevErrorLog,
    this.removeTryCatch,

    // UI/UX parameters
    this.transitionType,
    this.textBoldSizeGlobal,
    this.textPrimarySizeGlobal,
    this.textSecondarySizeGlobal,
    this.fontFamilyBoldGlobal,
    this.fontFamilyPrimaryGlobal,
    this.fontFamilySecondaryGlobal,
    this.fontWeightBoldGlobal,
    this.fontWeightPrimaryGlobal,
    this.fontWeightSecondaryGlobal,

    // Button parameters
    this.defaultAppButtonRadius,
    this.defaultAppButtonElevation,

    // InkWell parameters
    this.defaultInkWellSplashColor,
    this.defaultInkWellHoverColor,
    this.defaultInkWellHighlightColor,
    this.defaultInkWellRadius,

    // Shadow parameters
    this.shadowColorGlobal,
    this.defaultElevation,
    this.defaultRadius,
    this.defaultBlurRadius,
    this.defaultSpreadRadius,
    this.defaultAppBarElevation,

    // Other parameters
    this.passwordLengthGlobal,
    this.defaultDialogShape,
    this.defaultCurrencySymbol,
  }) : super(key: key);

  @override
  State<LayerKitConfigProvider> createState() => _LayerKitConfigProviderState();
}

class _LayerKitConfigProviderState extends State<LayerKitConfigProvider>
    with WidgetsBindingObserver {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // Re-initialize on metric changes (like orientation changes)
    if (_isInitialized && mounted) {
      _initializeConfig();
    }
  }

  void _initializeConfig() {
    KitConfig.init(
      context: context,

      // Environment parameters
      envType: widget.envType,
      showApiReqLog: widget.showApiReqLog,
      showApiResLog: widget.showApiResLog,
      showDevLog: widget.showDevLog,
      showDevErrorLog: widget.showDevErrorLog,
      removeTryCatch: widget.removeTryCatch,

      // UI/UX parameters
      transitionType: widget.transitionType,
      textBoldSizeGlobal: widget.textBoldSizeGlobal,
      textPrimarySizeGlobal: widget.textPrimarySizeGlobal,
      textSecondarySizeGlobal: widget.textSecondarySizeGlobal,
      fontFamilyBoldGlobal: widget.fontFamilyBoldGlobal,
      fontFamilyPrimaryGlobal: widget.fontFamilyPrimaryGlobal,
      fontFamilySecondaryGlobal: widget.fontFamilySecondaryGlobal,
      fontWeightBoldGlobal: widget.fontWeightBoldGlobal,
      fontWeightPrimaryGlobal: widget.fontWeightPrimaryGlobal,
      fontWeightSecondaryGlobal: widget.fontWeightSecondaryGlobal,

      // Button parameters
      defaultAppButtonRadius: widget.defaultAppButtonRadius,
      defaultAppButtonElevation: widget.defaultAppButtonElevation,

      // InkWell parameters
      defaultInkWellSplashColor: widget.defaultInkWellSplashColor,
      defaultInkWellHoverColor: widget.defaultInkWellHoverColor,
      defaultInkWellHighlightColor: widget.defaultInkWellHighlightColor,
      defaultInkWellRadius: widget.defaultInkWellRadius,

      // Shadow parameters
      shadowColorGlobal: widget.shadowColorGlobal,
      defaultElevation: widget.defaultElevation,
      defaultRadius: widget.defaultRadius,
      defaultBlurRadius: widget.defaultBlurRadius,
      defaultSpreadRadius: widget.defaultSpreadRadius,
      defaultAppBarElevation: widget.defaultAppBarElevation,

      // Other parameters
      passwordLengthGlobal: widget.passwordLengthGlobal,
      defaultDialogShape: widget.defaultDialogShape,
      defaultCurrencySymbol: widget.defaultCurrencySymbol,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Initialize on first build when context is available
    if (!_isInitialized) {
      _isInitialized = true;

      // Use post-frame callback to ensure context is fully ready
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _initializeConfig();
        }
      });
    }

    return widget.child;
  }
}
