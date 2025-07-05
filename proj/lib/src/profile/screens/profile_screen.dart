//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:layer_kit_example/core/network/network_checker_widget.dart';
import "package:easy_localization/easy_localization.dart";
import 'package:flutter/material.dart';
import 'package:layer_kit/layer_kit.dart';

import '../../../config/routes/routes.dart';
import '../../../config/theme/atoms/padding.dart';
import '../../../config/theme/atoms/text.dart';

class ProfileScreen extends StatefulWidget with BaseRoute {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

  @override
  Widget get screen => this;

  @override
  Routes get routeName => Routes.profile;
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin<ProfileScreen> {
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
              padding: Insets.medium16.paddingHorizontal,
              children: [
                ...List.generate(
                    200, (index) => Txt("${"profileScreen".tr()} $index")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
