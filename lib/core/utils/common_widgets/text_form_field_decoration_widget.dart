import 'package:flutter/material.dart';

InputDecoration textFormFieldDecorationWidget({
  required bool filled,
  required Color fillColor,
  required String hintText,
  required Color hintTextColor,
  required double borderRadius,
  required Color borderSideColor,
  Icon? prefixIcon,
  IconButton? suffixIcon,
  bool showPrefixIcon = false,
  bool showSuffixIcon = false,
  required BuildContext context,
}) {
  final baseDecoration = InputDecoration(
    filled: filled,
    fillColor: fillColor,
    hintText: hintText,
    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: hintTextColor,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: borderSideColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: borderSideColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(color: Colors.red),
    ),
    errorStyle: Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: Colors.red),
  );

  return baseDecoration.copyWith(
    prefixIcon: showPrefixIcon ? prefixIcon : null,
    suffixIcon: showSuffixIcon ? suffixIcon : null,
  );
}
