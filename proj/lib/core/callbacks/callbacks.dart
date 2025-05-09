//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'dart:async';

import "package:flutter/foundation.dart";
import "package:flutter/material.dart" show WidgetsBinding;
import 'package:layer_kit/layer_kit.dart';

import '../utils/common_toast.dart';

typedef BoolCallback = Future<bool> Function();
typedef ErrorListener =  Function(Object e);

void widgetBinding(void Function(Duration _) callback) {
  WidgetsBinding.instance.addPostFrameCallback(callback);
}

void onDebugOnly(dynamic Function() callback) async {
  if (!kReleaseMode) {
    await callback();
  }
}

/// Executes a function with tracking and error handling
///
/// [name] - Name of the function for identification in logs
/// [tryBlock] - The function to execute
/// [errorHandler] - Function to handle errors and return a fallback value
/// [isEnabled] - Whether this specific callback is enabled (default: true)
/// [logEnabled] - Whether to log execution of this specific callback (default: follows global setting)
///
/// Returns the result of tryBlock, or the result of errorHandler if an error occurs
Future<T?> safeRun<T>({
  required String name,
  required FutureOr<T> Function() tryBlock,
  T Function(Object e)? errorHandler,
  bool isEnabled = true,
  bool logEnabled = true,
}) async {
  if (!isEnabled) {
    if (logEnabled && KitConfig.showDevLog) {
      debugPrint('⏭️ Skipped execution of "$name" (disabled)');
    }
    // Return a default value or error result when disabled
    if (errorHandler == null) {
      return null;
    } else {
      return errorHandler(Exception('Function disabled: $name'));
    }
  }
  if (KitConfig.removeTryCatch) {
    if (logEnabled && KitConfig.showDevLog) {
      debugPrint('▶️ Executing "$name" without try-catch');
    }
    final stopwatch = Stopwatch()..start();
    final result = await tryBlock();
    stopwatch.stop();

    if (logEnabled && KitConfig.showDevLog) {
      debugPrint('✅ Completed "$name" in ${(stopwatch.elapsedMilliseconds / 1000).toStringAsFixed(2)}s');
    }

    return result;
  }

  try {
    if (logEnabled && KitConfig.showDevLog) {
      debugPrint('▶️ Starting "$name"');
    }

    final stopwatch = Stopwatch()..start();
    final result = await tryBlock();
    stopwatch.stop();

    if (logEnabled && KitConfig.showDevLog) {
      debugPrint('✅ Completed "$name" in ${(stopwatch.elapsedMilliseconds/1000).toStringAsFixed(2)}s');
    }

    return result;
  } catch (e) {
    if (logEnabled && KitConfig.showDevErrorLog) {
      debugPrint('❌ Error in "$name": $e');
    }

    if (errorHandler == null) {
      return null;
    } else {
      return errorHandler(e);
    }
  }
}

/// Executes a void function with tracking and error handling
///
/// [name] - Name of the function for identification in logs
/// [tryBlock] - The void function to execute
/// [errorHandler] - Function to handle errors
/// [isEnabled] - Whether this specific callback is enabled (default: true)
/// [logEnabled] - Whether to log execution of this specific callback (default: follows global setting)
Future<void> safeRunVoid({
  required String name,
  required Future<void> Function() tryBlock,
  required void Function(Object e) errorHandler,
  bool isEnabled = true,
  bool logEnabled = true,
}) async {
  await safeRun<void>(
    name: name,
    tryBlock: tryBlock,
    errorHandler: (e) {
      errorHandler(e);
    },
    isEnabled: isEnabled,
    logEnabled: logEnabled,
  );
}

Future<T> repoCallback<T>({
  required String name,
  required Future<T> Function() callback,
}) async {
  if (KitConfig.removeTryCatch) {
    return await callback();
  }
  try {
    return await callback();
  } on ServerException catch (e) {
    devlogError("ERROR IN REPO : SERVER EXCEPTION -> $name : ${e.message}");
    throw ServerException(e.message);
  } catch (e) {
    devlogError("ERROR IN REPO : CATCH ERROR -> $name : $e");
    throw ServerException("Something went wrong.!");
  }
}

Future<bool> apiCallback({
  required String name,
  required bool isNetwork,
  required BoolCallback doWhenOnline,
  BoolCallback? doWhenOffline,
  ErrorListener? errorListener,
}) async {
  bool isSuccess = false;
  if (KitConfig.removeTryCatch) {
    isSuccess = await doWhenOnline();
  } else {
    try {
      if (isNetwork) {
        isSuccess = await doWhenOnline();
        if (isSuccess) {
          devlog("SUCCESS MESSAGE - PROVIDER -> $name ");
        }
      } else {
        showSnackbar("No Internet Connection.!");
        if (doWhenOffline != null) {
          isSuccess = await doWhenOffline();
        }
      }
    } on ServerException catch (e) {
      devlogError("ERROR - PROVIDER - SERVER_EXCEPTION -> $name : $e");
      showSnackbar(e.message);
      if(errorListener != null) errorListener(e);
    } catch (e) {
      devlogError("ERROR - PROVIDER - CATCH_ERROR -> $name : $e");
      showSnackbar("Something went wrong.!");
      if(errorListener != null) errorListener(e);
    }
  }
  return isSuccess;
}

/// Extension method for easier usage with function types
extension LayerKitCallbackExtension<T> on Future<T> Function() {
  /// Execute this function with tracking and error handling
  Future<T?> withSafeRun(
    String functionName,
    T Function(Object e) errorHandler, {
    bool isEnabled = true,
    bool logEnabled = true,
  }) {
    return safeRun<T>(
      name: functionName,
      tryBlock: this,
      errorHandler: errorHandler,
      isEnabled: isEnabled,
      logEnabled: logEnabled,
    );
  }
}
