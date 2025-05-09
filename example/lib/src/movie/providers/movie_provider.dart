//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:flutter/cupertino.dart';
import 'package:layer_kit/core/base/base_viewmodel.dart';

import '../../../core/callbacks/callbacks.dart';
import '../../../core/network/network_service.dart';
import '../../../core/utils/common_toast.dart';
import '../datasource/models/requests/movie_req.dart';
import '../datasource/repo/movie_repo.dart';

class MovieProvider extends BaseViewModel {
  final MovieRepo _movieRepo;
  final NetworkService _networkService;

  MovieProvider(
      {required MovieRepo movieRepo, required NetworkService networkService})
      : _movieRepo = movieRepo,
        _networkService = networkService;

  ///
  ///
  ///

  /// GET DATA
  ///

  Future<bool> getData({
    required String data1,
    required String data2,
    bool listen = true,
  }) async {
    setLoading();
    final isNetwork = await _networkService.isConnected;
    final isSuccess = await apiCallback(
      name: "getData",
      isNetwork: isNetwork,
      doWhenOnline: () async {
        final req = MovieReq(data1: data1, data2: data2);
        final res = await _movieRepo.getData(req);
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
