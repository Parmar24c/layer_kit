//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:layer_kit_example/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:layer_kit/layer_kit.dart';
import 'package:provider/provider.dart';

import '../../di_container.dart';
import '../constants/image_constants.dart';
import 'network_service.dart';

class NetworkCheckerWidget extends StatelessWidget {
  final Widget child;

  const NetworkCheckerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    NetworkStatus networkStatus = Provider.of<NetworkStatus>(context);

    return Scaffold(
      body: networkStatus == NetworkStatus.online
          ? child
          : const NoInternetWdget(),
    );

    // return Scaffold(
    //   body: networkStatus == NetworkStatus.online ? child : Column(
    //     children: [
    //       Expanded(child: child),
    //       Container(
    //         width: double.infinity,
    //         color: AppColors.theme,
    //         padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.2.h),
    //         alignment: Alignment.center,
    //         child: Txt("No Internet Connection.!", textColor: Colors.white, fontSize: 1.6.t),
    //       )
    //     ],
    //   ),
    // );
  }
}

class NoInternetWdget extends StatelessWidget {
  const NoInternetWdget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off_sharp, size: 30.w),
              Txt("No Internet", fontSize: 4.t, color: context.colors.primary),
              Txt("Check your Internet Connection..!",
                  fontSize: 1.5.t, color: context.colors.black),
              SizedBox(height: 2.h),
              SizedBox(
                width: 55.w,
                // padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: ElevatedButton(
                    onPressed: () {
                      Di.sl<NetworkService>().checkConnection();
                    },
                    child: Txt("Retry",
                        color: context.colors.WHITE,
                        fontSize: 2.t,
                        fontWeight: FontWeight.w600)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
