import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast({required BuildContext context}){
  return Fluttertoast.showToast(
    msg: "Double tap to exit",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Theme.of(context).colorScheme.tertiary,
    textColor: Theme.of(context).colorScheme.secondary,
    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
  );
}