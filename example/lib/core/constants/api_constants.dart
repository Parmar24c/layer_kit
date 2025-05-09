//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import "package:layer_kit/core/utils/layerkit_config.dart";

class Apis {
  static const stagingBaseUrl = "https://staging-example.com";
  static const liveBaseUrl = "https://example.com";

  static String get baseUrl => KitConfig.envType.isProduction ? liveBaseUrl : stagingBaseUrl;
  static const name = "api";
  static const version = "v1";
  static String url = "$baseUrl/$name/$version";

  static const adminLogin = "/auth/admin-login";
  static const getData = "/getdata";

  static const getAllCategory = "/admin/category";
  static const getSingleCategory = "/admin/category/view";

  static const logout = "/auth/logout";
}
