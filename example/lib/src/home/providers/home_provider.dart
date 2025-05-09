//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR  
//                      © 2025  
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:layer_kit/layer_kit.dart';
import 'package:layer_kit_example/core/network/network_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends BaseViewModel {
  final NetworkService _networkService;

  HomeProvider({
    required NetworkService networkService,
  })  :
        _networkService = networkService;
}
