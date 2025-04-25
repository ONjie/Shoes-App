import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget signInScreenLinkWidget({required BuildContext context}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Already have an account?',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      TextButton(
        onPressed: () {
          context.go('/sign_in');
        },
        child: Text('Sign In', style: Theme.of(context).textTheme.labelMedium),
      ),
    ],
  );
}
