import 'package:flutter/material.dart';

import '../../../../../core/core.dart';


class SignUpScreenMessageWidget extends StatelessWidget {
  const SignUpScreenMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          signUpText,
          style: Theme.of(context).textTheme.bodyLarge
        ),
        const SizedBox(height: 10,),
        Text(
          signUpTextInfo,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge
        ),
      ],
    );
  }


}