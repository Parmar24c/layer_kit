//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import "package:easy_localization/easy_localization.dart";
import 'package:flutter/material.dart';
import 'package:layer_kit/layer_kit.dart';
import 'package:layer_kit_example/core/network/network_checker_widget.dart';

import '../../../config/routes/routes.dart';

class HomeScreen extends StatefulWidget with BaseRoute {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  @override
  Widget get screen => this;

  @override
  Routes get routeName => Routes.home;
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NetworkCheckerWidget(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: ListView(
              padding: Insets.medium18.paddingHorizontal,
              children: [
                ...List.generate(
                    200, (index) => Txt("${"homeScreen".tr()} $index")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
