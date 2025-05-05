import 'package:flutter/material.dart';
import 'package:shoes_app/core/core.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return message == noInternetConnectionMessage
        ? buildNoInternetConnectionWidget(context: context)
        : Center(
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
  }

  Widget buildNoInternetConnectionWidget({required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/no_internet.png',
          color: Colors.red,
          width: 70,
        ),
        const SizedBox(height: 5),
        Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.red,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
