//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:flutter/material.dart';
import 'package:layer_kit_example/core/helper/global_prefs.dart';
import 'package:flutter/cupertino.dart';

import "package:responsive_theme/responsive_theme.dart";

class ThemeProvider with ChangeNotifier {
  ThemeProvider();

  bool get darkTheme => _darkTheme;
  bool _darkTheme = false;

  AppThemeMode get theme => _darkTheme ? AppThemeMode.dark : AppThemeMode.light;

  void toggleTheme({bool? isDark}) {
    _darkTheme = isDark ?? !_darkTheme;
    GlobalPrefs.setTheme = _darkTheme;
    notifyListeners();
  }

  void loadCurrentTheme(BuildContext context,
      {ThemeMode themeMode = ThemeMode.system}) async {
    final isDarkMode = GlobalPrefs.getTheme;
    if (isDarkMode == null) {
      final useDarkTheme = switch (themeMode) {
        ThemeMode.system =>
          AppResponsiveTheme.colorModeOf(context) == AppThemeMode.dark,
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
