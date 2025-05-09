//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import "package:layer_kit_example/config/theme/app_colors.dart";
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "package:layer_kit/layer_kit.dart";
import "package:toastification/toastification.dart";

import "../constants/color_constants.dart";

Future<bool?> showFlutterToast(String msg, {Color? textColor, Color? color}) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    fontSize: 1.55.t,
    backgroundColor: color ?? AppColors.light().primary.mapped.shade200,
    textColor: textColor ?? Colors.black,
    gravity: ToastGravity.BOTTOM,
  );
}

showSnackbar(String msg, {ToastificationType? type, Color? textColor, Color? color, Color? handleColor}) {
  toastification.dismissAll(delayForAnimation: false);
  toastification.show(
    description: Txt(
      msg,
      fontSize: 1.4.t,
      textAlign: TextAlign.start,
      color: textColor ?? Colors.white,
      fontWeight: FontWeight.w500,
      maxLines: 20,
    ),
    style: ToastificationStyle.minimal,
    backgroundColor: color ?? Colors.grey.shade800,
    foregroundColor: Colors.white,
    borderSide: BorderSide(color: color ?? Colors.grey.shade800),
    primaryColor: handleColor ?? AppColors.light().primary,
    alignment: Alignment.bottomCenter,
    autoCloseDuration: Duration(milliseconds: 1500),
    type: type,
    showProgressBar: false,
    margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0),
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 5),
    showIcon: type != null,
  );
}
