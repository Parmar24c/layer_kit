import 'dart:ui';

AppSettingsDataModel appSettings = AppSettingsDataModel();

class AppSettingsDataModel {
  AppSettingsDataModel({
    this.lightTertiary,
    this.lightSecondary,
    this.lightPrimary,
    this.darkTertiary,
    this.darkSecondary,
    this.darkPrimary,
  });

  Color? lightTertiary;
  Color? lightSecondary;
  Color? lightPrimary;
  Color? darkTertiary;
  Color? darkSecondary;
  Color? darkPrimary;

  AppSettingsDataModel.fromJson(Map<String, dynamic> json)
      : lightTertiary = colorFromHex(json['light_tertiary']?.toString() ?? ''),
        lightSecondary = colorFromHex(json['light_secondary']?.toString() ?? ''),
        lightPrimary = colorFromHex(json['light_primary']?.toString() ?? ''),
        darkTertiary = colorFromHex(json['dark_tertiary']?.toString() ?? ''),
        darkSecondary = colorFromHex(json['dark_secondary']?.toString() ?? ''),
        darkPrimary = colorFromHex(json['dark_primary']?.toString() ?? '');

  // Helper function to convert color from hex string to Color
  static Color? colorFromHex(String hexColor) {
    try {
      final buffer = StringBuffer();
      if (hexColor.length == 6 || hexColor.length == 7) buffer.write('ff');
      buffer.write(hexColor.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return null;
    }
  }

  // Helper function to convert Color to hex string
  static String colorToHex(Color color) {
    final red = (color.r * 255).toInt().toRadixString(16).substring(2);
    final green = (color.g * 255).toInt().toRadixString(16).substring(2);
    final blue = (color.b * 255).toInt().toRadixString(16).substring(2);

    return '#$red$green$blue';
  }
}
