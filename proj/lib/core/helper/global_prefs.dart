//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';

enum PrefKey {
  token,
  theme,
  ;
}

class GlobalPrefs {
  GlobalPrefs._();

  static SharedPreferences? _sp;

  static Future<void> init() async {
    _sp = await SharedPreferences.getInstance();
  }

  /// GLOBAL VALUES
  ///

  /// TOKEN
  static void set setToken(String val) =>
      _sp?.setString(PrefKey.token.name, val);
  static String get getToken => _sp?.getString(PrefKey.token.name) ?? "";

  /// THEME
  static void set setTheme(bool val) => _sp?.setBool(PrefKey.theme.name, val);
  static bool? get getTheme => _sp?.getBool(PrefKey.theme.name);

  ///
  ///

  static bool get isTokenAvailable {
    final String token = getToken;
    return token.isNotEmpty && token.trim() != "";
  }

  static bool logout() {
    try {
      _sp!.remove(PrefKey.token.name);
      return true;
    } catch (e) {
      return false;
    }
  }
}
