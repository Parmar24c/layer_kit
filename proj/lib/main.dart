//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'dart:io';

import "package:layer_kit_example/config/lang/lang.dart";
import 'package:layer_kit_example/config/routes/routes.dart';
import 'package:layer_kit_example/config/theme/app_colors.dart';
import "package:layer_kit_example/config/theme/theme_provider.dart";
import "package:layer_kit_example/core/callbacks/callbacks.dart";
import 'package:layer_kit_example/core/constants/app_constants.dart';
import 'package:layer_kit_example/core/helper/global_prefs.dart';
import 'package:layer_kit_example/src/splash/screens/splash_screen.dart';
import "package:easy_localization/easy_localization.dart";
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:layer_kit/layer_kit.dart';
import 'package:provider/provider.dart';
import "package:toastification/toastification.dart";
import 'package:url_strategy/url_strategy.dart';

import 'di_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// FIREBASE SETUP
  ///
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await _setupFirebaseCrashlytics();
  ///
  /// /////////////

  await Di.init();
  await GlobalPrefs.init();
  await EasyLocalization.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  setPathUrlStrategy();
  runApp(MultiProvider(
    providers: Di.changeNotifierProviders,
    child: EasyLocalization(
      supportedLocales: Locl.values.map((Locl e) => e.locale).toList(),
      path: 'lib/config/lang',
      fallbackLocale: Locl.en.locale,
      assetLoader: RootBundleAssetLoader(),
      child: MyApp(),
    ),
  ));
}

/// CODE FOR FIREBASE CRASHLYTICS
///
// Future<void> _setupFirebaseCrashlytics() async {
//   await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
//   FlutterError.onError = (FlutterErrorDetails details) {
//     if (kDebugMode) {
//       FlutterError.dumpErrorToConsole(details);
//     } else {
//       FirebaseCrashlytics.instance.recordFlutterError(details);
//     }
//   };
//
//   PlatformDispatcher.instance.onError = (error, stack) {
//     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
//     return true;
//   };
// }
/// ////////////////////////////////////////

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    widgetBinding((_) {
      context.themeProvider.loadCurrentTheme(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      // DeviceOrientation.landscapeRight,
      // DeviceOrientation.landscapeLeft,
    ]);

    return Consumer<ThemeProvider>(builder: (context, state, _) {
      return ToastificationWrapper(
        child: MaterialApp(
          title: AppConsts.appName,
          navigatorKey: AppRouter.navigatorKey,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (s) => AppRouter.generateRoute(s, SplashScreen()),
          scrollBehavior: const StretchScrollBehavior(),
          initialRoute: Routes.splash.path,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: state.darkTheme ? ThemeData.dark() : ThemeData.light(),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child ?? SizedBox(),
            );
          },
        ),
      );
    });
  }
}
