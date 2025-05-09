//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:layer_kit_example/config/theme/theme_provider.dart';
import 'package:layer_kit_example/src/auth/datasource/repo/auth_repo.dart';
import 'package:layer_kit_example/src/home/datasource/repo/home_repo.dart';
import 'package:layer_kit_example/src/auth/datasource/repo/auth_repo_impl.dart';
import 'package:layer_kit_example/src/auth/providers/auth_provider.dart';
import 'package:layer_kit_example/src/demo/providers/demo_provider.dart';
import 'package:layer_kit_example/src/home/datasource/repo/home_repo_impl.dart';
import 'package:layer_kit_example/src/home/providers/home_provider.dart';
import 'package:layer_kit_example/src/splash/providers/splash_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/data/dio/dio_client.dart';
import 'config/data/dio/logging_intercepter.dart';
import 'core/constants/api_constants.dart';
import 'core/network/network_service.dart';

part 'di_container.main.dart';
