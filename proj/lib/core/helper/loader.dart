//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:layer_kit/layer_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:layer_kit_example/config/theme/theme.dart';
import 'package:layer_kit_example/config/theme/configs/theme_config.dart';

import '../utils/devlog.dart';

BuildContext? c;

showLoader(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      c = AppRouter.context;
      return const LoaderPage();
    },
  );
}

hideLoader() {
  try {
    Navigator.pop(c ?? AppRouter.context);
  } catch (e) {
    devlogError("error in hide loader : $e");
  }
}

class LoaderPage extends StatelessWidget {
  const LoaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, r) {
        return;
      },
      child: Material(
        color: Colors.grey.withOpacity(0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4.w)),
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          offset: Offset(1, 1))
                    ]),
                child: Column(
                  children: <Widget>[
                    CupertinoActivityIndicator(
                        color: context.colors.primary, radius: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
