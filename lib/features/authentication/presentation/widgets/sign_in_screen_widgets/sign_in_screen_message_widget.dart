import 'package:flutter/material.dart';
import '../../../../../core/core.dart';


class SignInScreenMessageWidget extends StatelessWidget {
  const SignInScreenMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          signInText,
          style: Theme.of(context).textTheme.bodyLarge
        ),
        const SizedBox(height: 10,),
        Text(
          signInTextInfo,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge
        ),
      ],
    );
  }


}
