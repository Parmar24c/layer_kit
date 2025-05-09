//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import "dart:ui";

import "package:easy_localization/easy_localization.dart";

///
/// PROCESS TO CREATE LocaleKeys CLASS
///
/// RUN FOLLOWING COMMAND TO TERMINAL
/// flutter pub run easy_localization:generate -f keys -O lib/config/lang/generated -o locale_keys.g.dart -S lib/config/lang
///
/// IF YOU WANT TO WORK IN ONLY ONE LANGUAGE (E.G., ENGLISH) THAN REMOVE ALL JSON FILE EXCEPT en OR CHANGE NAME OF OTHER JSON FILES

extension LocaleText on List<String> {
  String tr() => this.map((String e) => e.tr()).toList().join(", ");
}


enum Locl {
  en,
  de,
  ;

  Locale get locale => Locale(name);
}
