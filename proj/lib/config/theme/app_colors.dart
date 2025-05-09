// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:equatable/equatable.dart';
import "package:flutter/material.dart";
import 'package:layer_kit/layer_kit.dart';

class AppColors {
  final Color primary;

  final Color white;
  final Color WHITE;
  final Color white20;
  final Color WHITE20;
  final Color white40;
  final Color WHITE40;
  final Color white60;
  final Color WHITE60;
  final Color white80;
  final Color WHITE80;
  final Color white90;
  final Color WHITE90;

  final Color black;
  final Color BLACK;
  final Color black20;
  final Color BLACK20;
  final Color black40;
  final Color BLACK40;
  final Color black60;
  final Color BLACK60;
  final Color black80;
  final Color BLACK80;
  final Color black100;
  final Color BLACK100;

  final Color violet80;
  final Color violet60;
  final Color violet40;
  final Color violet20;

  final Color yellow100;
  final Color yellow80;
  final Color yellow60;
  final Color yellow40;
  final Color yellow20;

  final Color blue100;
  final Color blue80;
  final Color blue60;
  final Color blue40;
  final Color blue20;

  final Color red100;
  final Color red80;
  final Color red60;
  final Color red40;
  final Color red20;

  final Color green100;
  final Color green80;
  final Color green60;
  final Color green40;
  final Color green20;

  final Color dark100;
  final Color dark75;
  final Color dark50;
  final Color dark25;

  final Color light100;
  final Color light80;
  final Color light60;
  final Color light40;
  final Color light20;

  final Color grey20;
  final Color grey40;
  final Color grey60;
  final Color grey80;
  final Color grey100;

  const AppColors({
    required this.primary,
    required this.white,
    required this.WHITE,
    required this.white20,
    required this.WHITE20,
    required this.white40,
    required this.WHITE40,
    required this.white60,
    required this.WHITE60,
    required this.white80,
    required this.WHITE80,
    required this.white90,
    required this.WHITE90,
    required this.black,
    required this.BLACK,
    required this.black20,
    required this.BLACK20,
    required this.black40,
    required this.BLACK40,
    required this.black60,
    required this.BLACK60,
    required this.black80,
    required this.BLACK80,
    required this.black100,
    required this.BLACK100,
    required this.violet80,
    required this.violet60,
    required this.violet40,
    required this.violet20,
    required this.yellow100,
    required this.yellow80,
    required this.yellow60,
    required this.yellow40,
    required this.yellow20,
    required this.blue100,
    required this.blue80,
    required this.blue60,
    required this.blue40,
    required this.blue20,
    required this.red100,
    required this.red80,
    required this.red60,
    required this.red40,
    required this.red20,
    required this.green100,
    required this.green80,
    required this.green60,
    required this.green40,
    required this.green20,
    required this.dark100,
    required this.dark75,
    required this.dark50,
    required this.dark25,
    required this.light100,
    required this.light80,
    required this.light60,
    required this.light40,
    required this.light20,
    required this.grey20,
    required this.grey40,
    required this.grey60,
    required this.grey80,
    required this.grey100,
  });

  factory AppColors.light() => const AppColors(
        primary: Color(0xff7F3DFF),
        white: Colors.white,
        WHITE: Colors.white,
        white20: Color(0xFFF0F0F0),
        WHITE20: Color(0xFFF0F0F0),
        white40: Color(0xFFE0E0E0),
        WHITE40: Color(0xFFE0E0E0),
        white60: Color(0xFFD0D0D0),
        WHITE60: Color(0xFFD0D0D0),
        white80: Color(0xFFB0B0B0),
        WHITE80: Color(0xFFB0B0B0),
        white90: Color(0xFFA0A0A0),
        WHITE90: Color(0xFFA0A0A0),
        black: Colors.black,
        BLACK: Colors.black,
        black20: Color(0xFFE5E5E5),
        BLACK20: Color(0xFFE5E5E5),
        black40: Color(0xFFB3B3B3),
        BLACK40: Color(0xFFB3B3B3),
        black60: Color(0xFF808080),
        BLACK60: Color(0xFF808080),
        black80: Color(0xFF4D4D4D),
        BLACK80: Color(0xFF4D4D4D),
        black100: Color(0xFF1A1A1A),
        BLACK100: Color(0xFF1A1A1A),
        violet80: Color(0xff8F57FF),
        violet60: Color(0xffB18AFF),
        violet40: Color(0xffD3BDFF),
        violet20: Color(0xffEEE5FF),
        yellow100: Color(0xffFCAC12),
        yellow80: Color(0xffFCBB3C),
        yellow60: Color(0xffFCCC6F),
        yellow40: Color(0xffFCDDA1),
        yellow20: Color(0xffFCEED4),
        blue100: Color(0xff0077FF),
        blue80: Color(0xff248AFF),
        blue60: Color(0xff57A5FF),
        blue40: Color(0xff8AC0FF),
        blue20: Color(0xffBDDCFF),
        red100: Color(0xffFD3C4A),
        red80: Color(0xffFD5662),
        red60: Color(0xffFD6F7A),
        red40: Color(0xffFDA2A9),
        red20: Color(0xffFDD5D7),
        green100: Color(0xff00A86B),
        green80: Color(0xff2AB784),
        green60: Color(0xff65D1AA),
        green40: Color(0xff93EACA),
        green20: Color(0xffCFFAEA),
        dark100: Color(0xff0D0E0F),
        dark75: Color(0xff161719),
        dark50: Color(0xff464A4D),
        dark25: Color(0xff7A7E80),
        light100: Color(0xffFFFFFF),
        light80: Color(0xffFBFBFB),
        light60: Color(0xffF7F9FA),
        light40: Color(0xffF2F4F5),
        light20: Color(0xffE3E5E5),
        grey20: Color(0xFFF0F0F0),
        grey40: Color(0xFFD9D9D9),
        grey60: Color(0xFFBFBFBF),
        grey80: Color(0xFFA6A6A6),
        grey100: Color(0xFF8C8C8C),
      );

  factory AppColors.dark() => const AppColors(
        primary: Color(0xff7F3DFF),
        white: Color(0xff555555),
        WHITE: Colors.white,
        white20: Color(0xFF333333),
        WHITE20: Color(0xFFF0F0F0),
        white40: Color(0xFF4D4D4D),
        WHITE40: Color(0xFFE0E0E0),
        white60: Color(0xFF666666),
        WHITE60: Color(0xFFD0D0D0),
        white80: Color(0xFF808080),
        WHITE80: Color(0xFFB0B0B0),
        white90: Color(0xFF999999),
        WHITE90: Color(0xFFA0A0A0),
        black: Color(0xffdddddd),
        BLACK: Colors.black,
        black20: Color(0xFF1A1A1A),
        BLACK20: Color(0xFFE5E5E5),
        black40: Color(0xFF4D4D4D),
        BLACK40: Color(0xFFB3B3B3),
        black60: Color(0xFF808080),
        BLACK60: Color(0xFF808080),
        black80: Color(0xFFB3B3B3),
        BLACK80: Color(0xFF4D4D4D),
        black100: Color(0xFFE5E5E5),
        BLACK100: Color(0xFF1A1A1A),
        violet80: Color(0xff8F57FF),
        violet60: Color(0xffB18AFF),
        violet40: Color(0xffD3BDFF),
        violet20: Color(0xffEEE5FF),
        yellow100: Color(0xffFCAC12),
        yellow80: Color(0xffFCBB3C),
        yellow60: Color(0xffFCCC6F),
        yellow40: Color(0xffFCDDA1),
        yellow20: Color(0xffFCEED4),
        blue100: Color(0xff0077FF),
        blue80: Color(0xff248AFF),
        blue60: Color(0xff57A5FF),
        blue40: Color(0xff8AC0FF),
        blue20: Color(0xffBDDCFF),
        red100: Color(0xffFD3C4A),
        red80: Color(0xffFD5662),
        red60: Color(0xffFD6F7A),
        red40: Color(0xffFDA2A9),
        red20: Color(0xffFDD5D7),
        green100: Color(0xff00A86B),
        green80: Color(0xff2AB784),
        green60: Color(0xff65D1AA),
        green40: Color(0xff93EACA),
        green20: Color(0xffCFFAEA),
        dark100: Color(0xff0D0E0F),
        dark75: Color(0xff161719),
        dark50: Color(0xff464A4D),
        dark25: Color(0xff7A7E80),
        light100: Color(0xffFFFFFF),
        light80: Color(0xffFBFBFB),
        light60: Color(0xffF7F9FA),
        light40: Color(0xffF2F4F5),
        light20: Color(0xffE3E5E5),
        grey20: Color(0xFFF0F0F0),
        grey40: Color(0xFFD9D9D9),
        grey60: Color(0xFFBFBFBF),
        grey80: Color(0xFFA6A6A6),
        grey100: Color(0xFF8C8C8C),
      );

  ThemeColor toThemeColor() => {
        'primary': primary,
        'white': white,
        'WHITE': WHITE,
        'black': black,
        'BLACK': BLACK,
        'violet80': violet80,
        'violet60': violet60,
        'violet40': violet40,
        'violet20': violet20,
        'yellow100': yellow100,
        'yellow80': yellow80,
        'yellow60': yellow60,
        'yellow40': yellow40,
        'yellow20': yellow20,
        'blue100': blue100,
        'blue80': blue80,
        'blue60': blue60,
        'blue40': blue40,
        'blue20': blue20,
        'red100': red100,
        'red80': red80,
        'red60': red60,
        'red40': red40,
        'red20': red20,
        'green100': green100,
        'green80': green80,
        'green60': green60,
        'green40': green40,
        'green20': green20,
        'dark100': dark100,
        'dark75': dark75,
        'dark50': dark50,
        'dark25': dark25,
        'light100': light100,
        'light80': light80,
        'light60': light60,
        'light40': light40,
        'light20': light20,
        'black20': black20,
        'black40': black40,
        'black60': black60,
        'black80': black80,
        'black100': black100,
        'grey20': grey20,
        'grey40': grey40,
        'grey60': grey60,
        'grey80': grey80,
        'grey100': grey100,
        'white20': white20,
        'white40': white40,
        'white60': white60,
        'white80': white80,
        'white90': white90,
        'BLACK20': BLACK20,
        'BLACK40': BLACK40,
        'BLACK60': BLACK60,
        'BLACK80': BLACK80,
        'BLACK100': BLACK100,
        'WHITE20': WHITE20,
        'WHITE40': WHITE40,
        'WHITE60': WHITE60,
        'WHITE80': WHITE80,
        'WHITE90': WHITE90,
      };
}

extension ThemeColorKey on ThemeColor {
  Color get primary => this['primary']!;
  Color get white => this['white']!;
  Color get WHITE => this['WHITE']!;
  Color get black => this['black']!;
  Color get BLACK => this['BLACK']!;
  Color get violet80 => this['violet80']!;
  Color get violet60 => this['violet60']!;
  Color get violet40 => this['violet40']!;
  Color get violet20 => this['violet20']!;
  Color get yellow100 => this['yellow100']!;
  Color get yellow80 => this['yellow80']!;
  Color get yellow60 => this['yellow60']!;
  Color get yellow40 => this['yellow40']!;
  Color get yellow20 => this['yellow20']!;
  Color get blue100 => this['blue100']!;
  Color get blue80 => this['blue80']!;
  Color get blue60 => this['blue60']!;
  Color get blue40 => this['blue40']!;
  Color get blue20 => this['blue20']!;
  Color get red100 => this['red100']!;
  Color get red80 => this['red80']!;
  Color get red60 => this['red60']!;
  Color get red40 => this['red40']!;
  Color get red20 => this['red20']!;
  Color get green100 => this['green100']!;
  Color get green80 => this['green80']!;
  Color get green60 => this['green60']!;
  Color get green40 => this['green40']!;
  Color get green20 => this['green20']!;
  Color get dark100 => this['dark100']!;
  Color get dark75 => this['dark75']!;
  Color get dark50 => this['dark50']!;
  Color get dark25 => this['dark25']!;
  Color get light100 => this['light100']!;
  Color get light80 => this['light80']!;
  Color get light60 => this['light60']!;
  Color get light40 => this['light40']!;
  Color get light20 => this['light20']!;
  Color get black20 => this['black20']!;
  Color get black40 => this['black40']!;
  Color get black60 => this['black60']!;
  Color get black80 => this['black80']!;
  Color get black100 => this['black100']!;
  Color get grey20 => this['grey20']!;
  Color get grey40 => this['grey40']!;
  Color get grey60 => this['grey60']!;
  Color get grey80 => this['grey80']!;
  Color get grey100 => this['grey100']!;
  Color get white20 => this['white20']!;
  Color get white40 => this['white40']!;
  Color get white60 => this['white60']!;
  Color get white80 => this['white80']!;
  Color get white90 => this['white90']!;
  Color get BLACK20 => this['BLACK20']!;
  Color get BLACK40 => this['BLACK40']!;
  Color get BLACK60 => this['BLACK60']!;
  Color get BLACK80 => this['BLACK80']!;
  Color get BLACK100 => this['BLACK100']!;
  Color get WHITE20 => this['WHITE20']!;
  Color get WHITE40 => this['WHITE40']!;
  Color get WHITE60 => this['WHITE60']!;
  Color get WHITE80 => this['WHITE80']!;
  Color get WHITE90 => this['WHITE90']!;
}
