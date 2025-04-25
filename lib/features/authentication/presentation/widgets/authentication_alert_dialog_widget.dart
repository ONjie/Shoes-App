import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoes_app/core/core.dart';

import '../bloc/authentication_bloc.dart';

Future<dynamic> authenticationAlertDialogWidget({
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state.authenticationStatus == AuthenticationStatus.loading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              }

              if (state.authenticationStatus ==
                  AuthenticationStatus.signUpError) {
                return displaySuccessOrErrorMessage(
                  successOrErrorMessage: state.message!,
                  textColor: Colors.red,
                  context: context
                );
              }

              if (state.authenticationStatus ==
                  AuthenticationStatus.signInError) {
                return displaySuccessOrErrorMessage(
                  successOrErrorMessage: state.message!,
                  textColor: Colors.red,
                  context: context,
                );
              }

              if (state.authenticationStatus ==
                  AuthenticationStatus.resetPasswordOTPError) {
                return displaySuccessOrErrorMessage(
                  successOrErrorMessage: state.message!,
                  textColor: Colors.red,
                  context: context,
                );
              }

              if (state.authenticationStatus ==
                  AuthenticationStatus.resetPasswordError) {
                return displaySuccessOrErrorMessage(
                  successOrErrorMessage: state.message!,
                  textColor: Colors.red,
                  context: context,
                );
              }

              return Container();
            },
          ),
        ),
      );
    },
  );
}

Widget displaySuccessOrErrorMessage({
  required String successOrErrorMessage,
  required Color textColor,
  required BuildContext context,
}) {
  return successOrErrorMessage == noInternetConnectionMessage
      ? Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/no_internet.png',
            color: Colors.red,
            width: 70,
          ),
          const SizedBox(height: 5),
          Text(
            successOrErrorMessage,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: textColor),
          ),
        ],
      )
      : Center(
        child: Text(
          successOrErrorMessage,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: textColor),
        ),
      );
}
