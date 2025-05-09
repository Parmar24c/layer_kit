//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import "package:easy_localization/easy_localization.dart";
import 'package:flutter/material.dart';
import 'package:layer_kit/layer_kit.dart';
import 'package:layer_kit_example/config/routes/routes.dart';
import 'package:layer_kit_example/config/theme/app_colors.dart';
import 'package:layer_kit_example/core/callbacks/callbacks.dart';
import 'package:layer_kit_example/core/common/widgets/custom_elevated_button.dart';
import 'package:layer_kit_example/core/helper/loader.dart';

class Demo2Screen extends StatefulWidget with BaseRoute {
  const Demo2Screen({super.key});

  @override
  State<Demo2Screen> createState() => _Demo2ScreenState();

  @override
  Routes get routeName => Routes.demo2;

  @override
  Widget get screen => this;
}

class _Demo2ScreenState extends State<Demo2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.white40,
      appBar: AppBar(
        title: Txt.appbar("demoScreen".tr()),
      ),
      body: Center(
        child: CustomElevatedButton(
            onTap: () async {
              await safeRun(
                name: "process",
                tryBlock: () async {
                  showLoader(context);
                  await Future.delayed(2.seconds);
                  hideLoader();
                  context.popUntil((route) =>
                      Routes.appScaffold.path == route.settings.name);
                },
              );
            },
            child: Txt.regular14("Process", color: context.colors.white)),
      ),
    );
  }
}
