//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:flutter/material.dart';
import 'package:layer_kit_example/core/helper/global_prefs.dart';
import 'package:flutter/cupertino.dart';


class ThemeProvider with ChangeNotifier {
  ThemeProvider();

  bool get darkTheme => _darkTheme;
  bool _darkTheme = false;

  ThemeMode get theme => _darkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme({bool? isDark}) {
    _darkTheme = isDark ?? !_darkTheme;
    GlobalPrefs.setTheme = _darkTheme;
    notifyListeners();
  }

  bool getSystemTheme(BuildContext context) {
    final platformBrightness = MediaQuery.platformBrightnessOf(context);
    final useDarkTheme = platformBrightness == Brightness.dark;
    return useDarkTheme;
  }
  void loadCurrentTheme(BuildContext context,
      {ThemeMode themeMode = ThemeMode.system}) async {
    final isDarkMode = GlobalPrefs.getTheme;
    if (isDarkMode == null) {
      final useDarkTheme = switch (themeMode) {
        ThemeMode.system => getSystemTheme(context),
        ThemeMode.light => false,
        ThemeMode.dark => true,
      };
      _darkTheme = useDarkTheme;
    } else {
      _darkTheme = isDarkMode;
    }
    notifyListeners();
  }
}
