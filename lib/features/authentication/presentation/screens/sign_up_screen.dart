import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_app/features/authentication/presentation/bloc/authentication_bloc.dart';

import '../../../../core/core.dart';
import '../widgets/sign_up_screen_widgets/sign_in_screen_link_widget.dart';
import '../widgets/sign_up_screen_widgets/sign_up_screen_form_widget.dart';
import '../widgets/sign_up_screen_widgets/sign_up_screen_message_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
        appBar: buildAppBar(context: context),
        body: buildBody(context: context),
      ),
    );
  }

  AppBar buildAppBar({required BuildContext context}) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () {
          context.go('/sign_in');
        },
        icon: Icon(
          CupertinoIcons.back,
          color: Theme.of(context).colorScheme.secondary,
          size: 30,
        ),
      ),
    );
  }

  Widget buildBody({required BuildContext context}) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.authenticationStatus == AuthenticationStatus.signUpSuccess) {
          Navigator.pop(context);
          context.go('/home');
        }
      },
      child: SafeArea(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SignUpScreenMessageWidget(),
                  const SizedBox(height: 30),
                  const SignUpScreenFormWidget(),
                  SizedBox(height: MediaQuery.of(context).size.height / 4),
                  signInScreenLinkWidget(context: context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
