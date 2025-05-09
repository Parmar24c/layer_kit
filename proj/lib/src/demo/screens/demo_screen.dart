//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import "package:easy_localization/easy_localization.dart";
import 'package:flutter/material.dart';
import 'package:layer_kit/layer_kit.dart';
import 'package:layer_kit_example/config/theme/app_colors.dart';
import 'package:layer_kit_example/core/network/network_checker_widget.dart';

import '../../../config/routes/routes.dart';
import '../../../core/common/widgets/custom_elevated_button.dart';
import 'demo2_screen.dart';

class DemoScreen extends StatefulWidget with BaseRoute {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();

  @override
  Widget get screen => this;

  @override
  Routes get routeName => Routes.demo;
}

class _DemoScreenState extends State<DemoScreen> with AutomaticKeepAliveClientMixin<DemoScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NetworkCheckerWidget(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                CustomElevatedButton(
                  onTap: () => context.pushNamed(Demo2Screen()),
                  child: Txt.button("nextScreen".tr(), color: context.colors.WHITE),
                ),
                VGap.small12(),
                Expanded(
                  child: ListView(
                    padding: Insets.medium16.paddingHorizontal,
                    children: [
                      ...List.generate(200, (index) => Txt.regular14("${"demoScreen".tr()} $index")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
