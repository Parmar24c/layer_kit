//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:layer_kit/layer_kit.dart';


class LoggingInterceptor extends InterceptorsWrapper {
  String truncateData(dynamic data) {
    String dataString = data?.toString() ?? '';
    return dataString.length > KitConfig.apiLogDataLengthInChars ? '${dataString.substring(0, 4000)}...' : dataString;
  }

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if(KitConfig.showApiReqLog) {
      log(
        "-----------------🟧 REQUEST 🟧------------------------\n"
            "[🟧 API PATH     ] : ${options.path} \n"
            "[🟧 API METHOD   ] : ${options.method} \n"
            "[🟧 REQ DATA     ] : ${truncateData(options.data is FormData ? (options.data as FormData).fields : options.data)} \n"
            "[🟧 REQ HEADERS  ] : ${options.headers} \n"
            "[🟧 QUERY PARAMS ] : ${options.queryParameters} \n"
            "-----------------------------------------------------------------------------\n",
        name: "🟧 API REQUEST ",
      );

      if (KitConfig.envType.isDevelopmentWithPrint) {
        print(
          "-----------------[ REQUEST ]------------------------\n"
              "[🟧 API PATH     ] : ${options.path} \n"
              "[🟧 API METHOD   ] : ${options.method} \n"
              "[🟧 REQ DATA     ] : ${truncateData(options.data)} \n"
              "[🟧 REQ HEADERS  ] : ${options.headers} \n"
              "[🟧 QUERY PARAMS ] : ${options.queryParameters} \n"
              "-----------------------------------------------------------------------------\n",
        );
      }
    }
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    if(KitConfig.showApiResLog) {
      log(
        "-----------------🟩 RESPONSE 🟩------------------------\n"
            "[🟩 RES PATH     ] : ${response.requestOptions.path} \n"
            "[🟩 RES STATUS   ] : ${response.statusCode} \n"
            "[🟩 RES DATA     ] : ${truncateData(response.data)} \n"
            "-----------------------------------------------------------------------------\n",
        name: "🟩 API RESPONSE ",
      );

      if (KitConfig.envType.isDevelopmentWithPrint) {
        print(
          "-----------------[ RESPONSE ]------------------------\n"
              "[🟩 RES PATH     ] : ${response.requestOptions.path} \n"
              "[🟩 RES STATUS   ] : ${response.statusCode} \n"
              "[🟩 RES DATA     ] : ${truncateData(response.data)} \n"
              "-----------------------------------------------------------------------------\n",
        );
      }
    }
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    log(
      "-----------------🟥 ERROR 🟥------------------------\n"
      "[🟥 ERROR STATUS  ] : ${err.response?.statusCode} \n"
      "[🟥 ERROR PATH    ] : ${err.requestOptions.path} \n"
      "[🟥 ERROR MESSAGE ] : ${truncateData(err.message)} \n"
      "[🟥 QUERY PARAMS  ] : ${err.requestOptions.queryParameters} \n"
      "[🟥 REQ HEADERS   ] : ${err.requestOptions.headers} \n"
      "-----------------------------------------------------------------------------\n",
      name: "🟥 API ERROR ",
    );

    if (KitConfig.envType.isDevelopmentWithPrint) {
      print(
        "-----------------[ ERROR ]------------------------\n"
        "[🟥 ERROR STATUS  ] : ${err.response?.statusCode} \n"
        "[🟥 ERROR PATH    ] : ${err.requestOptions.path} \n"
        "[🟥 ERROR MESSAGE ] : ${truncateData(err.message)} \n"
        "[🟥 REQ HEADERS   ] : ${err.requestOptions.headers} \n"
        "[🟥 QUERY PARAMS  ] : ${err.requestOptions.queryParameters} \n"
        "-----------------------------------------------------------------------------\n",
      );
    }

    return super.onError(err, handler);
  }
}
