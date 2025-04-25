import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/authentication_bloc.dart';
import '../../../../core/core.dart';
import '../widgets/sign_in_screen_widgets/sign_in_screen_form_widget.dart';
import '../widgets/sign_in_screen_widgets/sign_in_screen_message_widget.dart';
import '../widgets/sign_in_screen_widgets/sign_up_screen_link_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late int tapCount = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        tapCount++;
        if (tapCount == 1) {
          showToast(context: context);
        } else if (tapCount == 2) {
          exit(0);
        } else {
          tapCount = 0;
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: buildBody(context: context),
      ),
    );
  }

  Widget buildBody({required BuildContext context}) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.authenticationStatus == AuthenticationStatus.signInSuccess) {
          context.go('/home');
        }
      },
      child: SafeArea(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 50, right: 12, left: 12),
              child: Column(
                children: [
                  const SignInScreenMessageWidget(),
                  const SizedBox(height: 40),
                  const SignInScreenFormWidget(),
                  SizedBox(height: MediaQuery.of(context).size.height / 3),
                  signUpScreenLinkWidget(context: context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
