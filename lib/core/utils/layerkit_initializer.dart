import 'package:flutter/material.dart';
import 'package:layer_kit/layer_kit.dart';

/// A controller class that manages LayerKit configuration state
class LayerKitController extends ChangeNotifier {
  static LayerKitController? _instance;
  static LayerKitController get instance => _instance ??= LayerKitController._();

  LayerKitController._();

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  Map<String, dynamic>? _configParams;
  BuildContext? _savedContext;

  /// Ensures LayerKit is initialized before the app starts
  static Future<void> ensureInitialized() async {
    // Create instance if not already created
    if (_instance == null) {
      _instance = LayerKitController._();
    }

    // If we already have a saved context and config params, initialize immediately
    if (_instance!._savedContext != null && _instance!._configParams != null) {
      _instance!._initWithSavedParams();
    }

    return Future.value();
  }

  /// Save configuration parameters for later initialization
  void saveConfigParams({
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
  }) {
    _configParams = {
      // Environment parameters
      'envType': envType,
      'showApiReqLog': showApiReqLog,
      'showApiResLog': showApiResLog,
      'showDevLog': showDevLog,
      'showDevErrorLog': showDevErrorLog,
      'removeTryCatch': removeTryCatch,

      // UI/UX parameters
      'transitionType': transitionType,
      'textBoldSizeGlobal': textBoldSizeGlobal,
      'textPrimarySizeGlobal': textPrimarySizeGlobal,
      'textSecondarySizeGlobal': textSecondarySizeGlobal,
      'fontFamilyBoldGlobal': fontFamilyBoldGlobal,
      'fontFamilyPrimaryGlobal': fontFamilyPrimaryGlobal,
      'fontFamilySecondaryGlobal': fontFamilySecondaryGlobal,
      'fontWeightBoldGlobal': fontWeightBoldGlobal,
      'fontWeightPrimaryGlobal': fontWeightPrimaryGlobal,
      'fontWeightSecondaryGlobal': fontWeightSecondaryGlobal,

      // Button parameters
      'defaultAppButtonRadius': defaultAppButtonRadius,
      'defaultAppButtonElevation': defaultAppButtonElevation,

      // InkWell parameters
      'defaultInkWellSplashColor': defaultInkWellSplashColor,
      'defaultInkWellHoverColor': defaultInkWellHoverColor,
      'defaultInkWellHighlightColor': defaultInkWellHighlightColor,
      'defaultInkWellRadius': defaultInkWellRadius,

      // Shadow parameters
      'shadowColorGlobal': shadowColorGlobal,
      'defaultElevation': defaultElevation,
      'defaultRadius': defaultRadius,
      'defaultBlurRadius': defaultBlurRadius,
      'defaultSpreadRadius': defaultSpreadRadius,
      'defaultAppBarElevation': defaultAppBarElevation,

      // Other parameters
      'passwordLengthGlobal': passwordLengthGlobal,
      'defaultDialogShape': defaultDialogShape,
      'defaultCurrencySymbol': defaultCurrencySymbol,
    };

    if (_savedContext != null) {
      _initWithSavedParams();
    }
  }

  /// Save context for initialization
  void saveContext(BuildContext context) {
    _savedContext = context;

    if (_configParams != null) {
      _initWithSavedParams();
    }
  }

  /// Initialize with saved parameters
  void _initWithSavedParams() {
    if (_isInitialized || _savedContext == null || _configParams == null) return;

    KitConfig.init(
      context: _savedContext!,

      // Environment parameters
      envType: _configParams!['envType'],
      showApiReqLog: _configParams!['showApiReqLog'],
      showApiResLog: _configParams!['showApiResLog'],
      showDevLog: _configParams!['showDevLog'],
      showDevErrorLog: _configParams!['showDevErrorLog'],
      removeTryCatch: _configParams!['removeTryCatch'],

      // UI/UX parameters
      transitionType: _configParams!['transitionType'],
      textBoldSizeGlobal: _configParams!['textBoldSizeGlobal'],
      textPrimarySizeGlobal: _configParams!['textPrimarySizeGlobal'],
      textSecondarySizeGlobal: _configParams!['textSecondarySizeGlobal'],
      fontFamilyBoldGlobal: _configParams!['fontFamilyBoldGlobal'],
      fontFamilyPrimaryGlobal: _configParams!['fontFamilyPrimaryGlobal'],
      fontFamilySecondaryGlobal: _configParams!['fontFamilySecondaryGlobal'],
      fontWeightBoldGlobal: _configParams!['fontWeightBoldGlobal'],
      fontWeightPrimaryGlobal: _configParams!['fontWeightPrimaryGlobal'],
      fontWeightSecondaryGlobal: _configParams!['fontWeightSecondaryGlobal'],

      // Button parameters
      defaultAppButtonRadius: _configParams!['defaultAppButtonRadius'],
      defaultAppButtonElevation: _configParams!['defaultAppButtonElevation'],

      // InkWell parameters
      defaultInkWellSplashColor: _configParams!['defaultInkWellSplashColor'],
      defaultInkWellHoverColor: _configParams!['defaultInkWellHoverColor'],
      defaultInkWellHighlightColor: _configParams!['defaultInkWellHighlightColor'],
      defaultInkWellRadius: _configParams!['defaultInkWellRadius'],

      // Shadow parameters
      shadowColorGlobal: _configParams!['shadowColorGlobal'],
      defaultElevation: _configParams!['defaultElevation'],
      defaultRadius: _configParams!['defaultRadius'],
      defaultBlurRadius: _configParams!['defaultBlurRadius'],
      defaultSpreadRadius: _configParams!['defaultSpreadRadius'],
      defaultAppBarElevation: _configParams!['defaultAppBarElevation'],

      // Other parameters
      passwordLengthGlobal: _configParams!['passwordLengthGlobal'],
      defaultDialogShape: _configParams!['defaultDialogShape'],
      defaultCurrencySymbol: _configParams!['defaultCurrencySymbol'],
    );

    _isInitialized = true;
    notifyListeners();
  }

  void reinitialize() {
    if (_savedContext != null && _configParams != null) {
      _initWithSavedParams();
    }
  }
}

/// A widget that initializes and provides LayerKit configuration to its child widget tree
class LayerKitInitializer extends StatefulWidget {
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

  // Loading widget to show while initialization is in progress
  final Widget? loadingWidget;

  /// Creates a LayerKitInitializer to initialize the LayerKit configuration
  /// for the application and provide it to the widget tree.
  ///
  /// The [child] parameter is required and typically should be your
  /// application's root widget (like MaterialApp).
  const LayerKitInitializer({
    Key? key,
    required this.child,
    this.loadingWidget,

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
  State<LayerKitInitializer> createState() => _LayerKitInitializerState();

  /// ensureInitialized needs to be called in main
  /// so that configuration is loaded and used from the start.
  static Future<void> ensureInitialized() async {
    await LayerKitController.ensureInitialized();
  }

  /// Get LayerKit provider from context
  static LayerKitProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LayerKitProvider>();
  }
}

class _LayerKitInitializerState extends State<LayerKitInitializer> with WidgetsBindingObserver {
  LayerKitController? _controller;
  bool _contextProvided = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = LayerKitController.instance;

    // Save configuration parameters
    _controller!.saveConfigParams(
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

    // Add listener to rebuild the widget when initialization is complete
    _controller!.addListener(_handleControllerUpdate);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller!.removeListener(_handleControllerUpdate);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // Re-initialize on metric changes (like orientation changes)
    if (_controller!.isInitialized && mounted) {
      _controller!.reinitialize();
    }
  }

  void _handleControllerUpdate() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // Save context for initialization if not already provided
    if (!_contextProvided) {
      _contextProvided = true;

      // Use post-frame callback to ensure context is fully ready
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _controller!.saveContext(context);
        }
      });
    }

    // Show loading widget until initialization is complete
    if (!_controller!.isInitialized) {
      return widget.loadingWidget ??
          MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
    }

    // Provide the controller to the widget tree
    return LayerKitProvider(
      controller: _controller!,
      child: widget.child,
    );
  }
}

/// An inherited widget that provides LayerKit configuration to the widget tree
class LayerKitProvider extends InheritedWidget {
  final LayerKitController controller;

  const LayerKitProvider({
    Key? key,
    required this.controller,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(LayerKitProvider oldWidget) {
    return controller != oldWidget.controller ||
        controller.isInitialized != oldWidget.controller.isInitialized;
  }

  /// Reinitialize LayerKit configuration
  void reinitialize() {
    controller.reinitialize();
  }
}