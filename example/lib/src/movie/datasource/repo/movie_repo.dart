//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:layer_kit_example/src/movie/datasource/models/response/movie_response.dart';

import '../models/requests/movie_req.dart';

abstract interface class MovieRepo {
  Future<MovieResponse> getData(MovieReq req);
}
