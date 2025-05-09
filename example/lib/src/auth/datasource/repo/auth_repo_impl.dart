//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:layer_kit_example/config/data/dio/dio_client.dart';
import 'package:layer_kit_example/src/auth/datasource/models/requests/login_req.dart';
import 'package:layer_kit_example/src/auth/datasource/models/response/login_response.dart';
import 'package:layer_kit_example/src/auth/datasource/repo/auth_repo.dart';

import '../../../../core/callbacks/callbacks.dart';
import '../../../../core/constants/api_constants.dart';

class AuthRepoImpl implements AuthRepo {
  final DioClient _dioClient;

  AuthRepoImpl({required DioClient dioClient}) : _dioClient = dioClient;

  @override
  Future<LoginResponse> adminLogin(LoginReq req) async {
    return repoCallback<LoginResponse>(
      name: "adminLogin",
      callback: () async {
        final res = await _dioClient.post(Apis.adminLogin, data: req.toJson());
        return LoginResponse.fromJson(res.data ?? {});
      },
    );
  }
}

/// CHANGE toJson TO toFormData WHERE YOU PASS IMAGE OF FILE (AS MULTIPART FILE)
/// FOR THAT YOU HAVE TO CREATE toFormData() METHOD IN YOUR REQUEST CLASS
/// toFormData() METHOD CONVERT NORMAL FILE IMAGE TO MULTIPART FILE
/// HERE IS DEMO :
/// --> final res = await _dioClient.post(Apis.adminLogin, data: req.toFormData(), contentType: CType.formData);
///
