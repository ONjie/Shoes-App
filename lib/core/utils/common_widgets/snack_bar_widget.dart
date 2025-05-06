import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';


snackBarWidget({
  required BuildContext context,
  required String message,
  required Color bgColor,
  required int duration,
}){
  return toastification.show(
     context: context,
      type: ToastificationType.info,
      autoCloseDuration: Duration(seconds: duration),
      title: Text(
        message,
        style: TextStyle(
            fontSize: 18,
            color:  Theme.of(context).colorScheme.secondary,
        ),
      ),
      primaryColor: bgColor,
      backgroundColor: bgColor,
      alignment: Alignment.bottomCenter,
      showProgressBar: false,
      showIcon: false,

  );
}