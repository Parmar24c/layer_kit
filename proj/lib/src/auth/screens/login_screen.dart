//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import "package:easy_localization/easy_localization.dart";
import 'package:flutter/material.dart';
import 'package:layer_kit/layer_kit.dart';
import 'package:layer_kit_example/config/theme/app_colors.dart';
import 'package:layer_kit_example/config/theme/theme.dart';
import 'package:layer_kit_example/core/callbacks/callbacks.dart';
import 'package:layer_kit_example/core/common/widgets/custom_elevated_button.dart';
import 'package:layer_kit_example/core/network/network_checker_widget.dart';
import 'package:layer_kit_example/src/main_screen.dart';

import '../../../config/routes/routes.dart';
import '../../../config/theme/atoms/text.dart';
import '../../../core/utils/devlog.dart';

class LoginScreen extends StatelessWidget with BaseRoute {
  const LoginScreen({super.key});

  @override
  Widget get screen => this;

  @override
  AppRoutes get routeName => Routes.login;

  @override
  TransitionType get transitionType => TransitionType.fade;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, r) {
        devlog("pop invoked in login page");
      },
      child: NetworkCheckerWidget(
        child: Scaffold(
          appBar: AppBar(
            title: Txt.appbar("loginScreen".tr(), color: context.colors.primary),
          ),
          body: SafeArea(
            child: Center(
              child: CustomElevatedButton(
                child: Txt.regular14("loginWithoutEmailPassword".tr(), color: context.colors.WHITE),
                onTap: () {
                  safeRun(
                      name: "login without email password",
                      tryBlock: () {
                        context.pushReplacementNamed(MainScreen(initialIndex: 0));
                      });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
