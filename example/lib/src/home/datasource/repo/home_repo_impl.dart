//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:layer_kit_example/config/data/dio/dio_client.dart';
import 'package:layer_kit_example/src/home/datasource/repo/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final DioClient _dioClient;

  HomeRepoImpl({required DioClient dioClient}) : _dioClient = dioClient;
}
