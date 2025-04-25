
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key,
    required this.buttonText,
    required this.textColor,
    required this.textFontSize,
    required this.buttonWidth,
    required this.backgroundColor,
    required this.surfaceTintColor,
    required this.radius,
    required this.borderSideColor,
    required this.borderSideWidth,
    required this.padding,
    required this.onPressed,
  });

  final String buttonText;
  final Color textColor;
  final double textFontSize;
  final double buttonWidth;
  final Color backgroundColor;
  final Color surfaceTintColor;
  final double radius;
  final Color borderSideColor;
  final double borderSideWidth;
  final EdgeInsetsGeometry padding;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          surfaceTintColor: surfaceTintColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            side: BorderSide(color: borderSideColor, width: borderSideWidth),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: padding,
          child: Center(
            child: Text(
              buttonText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: textFontSize,
                color: textColor
              )
            ),
          ),
        ),
      ),
    );
  }
}
