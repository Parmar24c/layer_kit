//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:layer_kit_example/config/data/dio/dio_client.dart';
import 'package:layer_kit_example/src/movie/datasource/models/requests/movie_req.dart';
import 'package:layer_kit_example/src/movie/datasource/models/response/movie_response.dart';

import '../../../../core/callbacks/callbacks.dart';
import '../../../../core/constants/api_constants.dart';
import 'movie_repo.dart';

class MovieRepoImpl implements MovieRepo {
  final DioClient _dioClient;

  MovieRepoImpl({required DioClient dioClient}) : _dioClient = dioClient;

  @override
  Future<MovieResponse> getData(MovieReq req) async {
    return await repoCallback<MovieResponse>(
      name: "getData",
      callback: () async {
        final res = await _dioClient.post(Apis.getData, data: req.toJson());
        return MovieResponse.fromJson(res.data ?? {});
      },
    );
  }
}

/// CHANGE toJson TO toFormData WHERE YOU PASS IMAGE OF FILE (AS MULTIPART FILE)
/// FOR THAT YOU HAVE TO CREATE toFormData() METHOD IN YOUR REQUEST CLASS
/// toFormData() METHOD CONVERT NORMAL FILE IMAGE TO MULTIPART FILE
/// HERE IS DEMO :
/// --> final res = await _dioClient.post(Apis.getData, data: req.toFormData(), contentType: CType.formData);
///
