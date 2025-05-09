//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:flutter/material.dart';
import 'package:layer_kit/layer_kit.dart';
import 'package:layer_kit_example/config/theme/app_colors.dart';
import "package:layer_kit_example/core/helper/global_prefs.dart";

import '../../../config/routes/routes.dart';
import '../../auth/screens/login_screen.dart';
import '../../home/screens/home_screen.dart';

class SplashScreen extends StatefulWidget with BaseRoute {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

  @override
  Widget get screen => this;

  @override
  AppRoutes get routeName => Routes.splash;
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      final isToken = GlobalPrefs.isTokenAvailable;

      /// TOKEN BASED LOGIN
      if (isToken) {
        context.pushNamedAndRemoveUntil(HomeScreen(), (route) => false);
      } else {
        context.pushNamedAndRemoveUntil(LoginScreen(), (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.white,
      body: SizedBox(
        width: 100.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_circle_rounded, size: 30.w),
          ],
        ),
      ),
    );
  }
}
