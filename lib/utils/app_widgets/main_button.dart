import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../constants.dart';
import '../dimensions.dart';

class SmartPayMainButton extends StatelessWidget {
  const SmartPayMainButton({
    super.key,
    this.backgroundColor = kPRYCOLOUR,
    this.cornerRadius = 16,
    this.child,
    required this.text,
    this.textColor = kWHTCOLOUR,
    this.useCustom = false,
    required this.onTap,
  });
  final bool useCustom;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final double cornerRadius;
  final Widget? child;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(getScreenHeight(cornerRadius))),
        height: getScreenHeight(56),
        child: Center(
          child: useCustom
              ? child
              : Text(
                  text,
                  style: kTextStyleSemiBold(color: textColor),
                ),
        ),
      ),
    );
  }
}
