//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'dart:developer' as dev;

import '../../config/layerkit_config.dart';

String _truncateData(String data, int? limit) {
  String dataString = data.toString();
  if (limit == null) return dataString;
  return dataString.length > limit
      ? '${dataString.substring(0, limit)}...'
      : dataString;
}

void devlog(String msg, {String? name, int? limit}) {
  if (KitConfig.showDevLog) {
    dev.log("👉 👉 👉 ${_truncateData(msg, limit)}", name: name ?? " LOG ");
    if (KitConfig.envType.isDevelopmentWithPrint)
      print("[${name ?? " LOG "}] 👉 👉 👉 ${_truncateData(msg, limit)}");
  }
}

void devlogError(String error) {
  if (KitConfig.showDevErrorLog) {
    dev.log("❌ ==> ==> * $error", name: " ERROR ");
    if (KitConfig.envType.isDevelopmentWithPrint)
      print("[ ERROR ] ❌ ==> ==> * $error");
  }
}
