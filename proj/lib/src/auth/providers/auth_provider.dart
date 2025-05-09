//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:layer_kit/layer_kit.dart';
import 'package:layer_kit_example/src/auth/datasource/models/requests/login_req.dart';
import 'package:layer_kit_example/src/auth/datasource/repo/auth_repo.dart';
import 'package:layer_kit_example/core/network/network_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/callbacks/callbacks.dart';
import '../../../core/utils/common_toast.dart';

class AuthProvider extends BaseViewModel {
  final AuthRepo _authRepo;
  final NetworkService _networkService;

  AuthProvider(
      {required AuthRepo authRepo, required NetworkService networkService})
      : _authRepo = authRepo,
        _networkService = networkService;

  ///
  ///
  ///

  /// LOGIN FOR ADMIN
  ///

  Future<bool> adminLogin({
    required String email,
    required String password,
    bool listen = true,
  }) async {
    setLoading();
    final isNetwork = await _networkService.isConnected;
    final isSuccess = await apiCallback(
      name: "adminLogin",
      isNetwork: isNetwork,
      doWhenOnline: () async {
        final req = LoginReq(email: email, password: password);
        final res = await _authRepo.adminLogin(req);
        showSnackbar(res.message);
        setLoaded();
        return res.status;
      },
      errorListener: (e) {
        setError(e.toString());
      },
    );
    if (listen) notifyListeners();
    return isSuccess;
  }
}
