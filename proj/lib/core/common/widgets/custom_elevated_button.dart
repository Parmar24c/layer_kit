//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR  
//                      © 2025  
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:layer_kit_example/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:layer_kit/layer_kit.dart';

class ButtonBorder {
  final double width;
  final Color color;

  ButtonBorder({required this.width, required this.color});
}

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final Color? color;
  final BoxShape? shape;
  final double? size;
  final double? height;
  final double? width;
  final double? borderRadius;
  final BorderRadius? radius;
  final ButtonBorder? border;
  final Alignment? alignment;
  final EdgeInsetsGeometry? padding;

  const CustomElevatedButton({
    super.key,
    required this.onTap,
    required this.child,
    this.color,
    this.shape,
    this.border,
    this.padding,
    this.size,
    this.height,
    this.width,
    this.borderRadius,
    this.radius,
    this.alignment,
  })  : assert(
            size == null || (height == null && width == null),
            "\n\nIf you give size, it will apply as height and width\n"
            "Consider give height and width or size.\n"),
        assert(radius == null || borderRadius == null);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: radius ?? KitConfig.defaultRadius.borderRadiusCircular,
      child: Container(
        alignment: alignment,
        padding: padding ?? EdgeInsets.symmetric(horizontal: Insets.medium16, vertical: Insets.xsmall8),
        height: size ?? height,
        width: size ?? width,
        decoration: BoxDecoration(
          color: color ?? context.colors.primary,
          borderRadius: radius ?? KitConfig.defaultRadius.borderRadiusCircular,
          border: border == null  ? null : Border.all(color: border?.color ?? context.colors.primary, width: border?.width ?? 1),
          shape: shape ?? BoxShape.rectangle,
        ),
        child: child,
      ),
    );
  }
}
