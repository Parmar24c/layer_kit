//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:flutter/material.dart';
import 'package:layer_kit/layer_kit.dart';
import 'package:layer_kit_example/config/theme/theme.dart';
import 'package:layer_kit_example/core/callbacks/callbacks.dart';
import 'package:layer_kit_example/core/common/widgets/custom_elevated_button.dart';
import 'package:layer_kit_example/core/network/network_checker_widget.dart';
import 'package:layer_kit_example/core/utils/common_toast.dart';
import 'package:layer_kit_example/src/feature/providers/feature_provider.dart';
import 'package:provider/provider.dart';

import '../../../config/routes/routes.dart';
import '../../../config/theme/atoms/text.dart';
import '../../../config/layerkit_config.dart';
import '../../../core/utils/devlog.dart';

class FeatureScreen extends StatelessWidget with BaseRoute {
  const FeatureScreen({super.key});

  @override
  Widget get screen => this;

  @override
  AppRoutes get routeName => Routes.feature;

  @override
  TransitionType get transitionType => KitConfig.transitionType;

  @override
  Widget build(BuildContext context) {
    return NetworkCheckerWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Txt.appbar("Feature Screen", color: context.colors.primary),
        ),
        body: SafeArea(
          child: Consumer<FeatureProvider>(builder: (context, state, _) {
            if (state.state ==
                ViewState.loading /* or use [state.isLoading] */) {
              return Center(child: CircularProgressIndicator());
            }

            if (state.state == ViewState.error) {
              return Center(
                  child: Txt.title18(state.errorMessage, color: Colors.red));
            }

            return Center(
              child: CustomElevatedButton(
                child: Txt.regular16("Feature Button",
                    color: context.colors.WHITE),
                onTap: () {
                  /// safeRun works same as try..catch along with enhanced functionality
                  safeRun(
                    name: "Feature Button",
                    isEnabled: true,
                    logEnabled: true,
                    tryBlock: () {
                      /// todo : implement on click logic
                      showSnackbar("Feature Button Clicked");
                      devlog("Feature Button Clicked");
                    },
                    errorHandler: (e) {
                      /// todo : handle error
                      devlogError("Error occured on Feature Button click - $e");
                    },
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
