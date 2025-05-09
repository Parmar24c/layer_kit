//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:layer_kit_example/config/data/dio/dio_client.dart';
import 'package:layer_kit_example/src/feature/datasource/models/requests/feature_req.dart';
import 'package:layer_kit_example/src/feature/datasource/models/response/feature_response.dart';

import '../../../../core/callbacks/callbacks.dart';
import '../../../../core/constants/api_constants.dart';
import 'feature_repo.dart';

class FeatureRepoImpl implements FeatureRepo {
  final DioClient _dioClient;

  FeatureRepoImpl({required DioClient dioClient}) : _dioClient = dioClient;

  @override
  Future<FeatureResponse> getData(FeatureReq req) async {
    return await repoCallback<FeatureResponse>(
      name: "getData",
      callback: () async {
        final res = await _dioClient.post(Apis.getData, data: req.toJson());
        return FeatureResponse.fromJson(res.data ?? {});
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
