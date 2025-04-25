import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget signUpScreenLinkWidget({required BuildContext context}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Don\'t have an account?',
        style: Theme.of(context).textTheme.bodyMedium
      ),
      TextButton(
        onPressed:(){
          context.go('/sign_up');
        },
        child: Text(
          'Sign Up',
          style: Theme.of(context).textTheme.labelMedium
        ),
      )
    ],
  );
}