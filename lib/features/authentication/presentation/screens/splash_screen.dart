import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_app/features/authentication/presentation/bloc/authentication_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _checkAuthStatus();
    super.initState();
  }

  void _checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 3)).whenComplete(() {
      if (mounted) {
        BlocProvider.of<AuthenticationBloc>(context).add(CheckAuthStateEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: true,
      
      onPopInvokedWithResult: (didPop, result) {
        if(didPop){
          exit(0);
        }
      },
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.authenticationStatus ==
              AuthenticationStatus.authenticated) {
            context.go('/home');
          }
          if (state.authenticationStatus ==
              AuthenticationStatus.unauthenticated) {
            context.go('/sign_in');
          }
        },
        child: SafeArea(
          child: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16,
                left: 12,
                right: 12,
                bottom: 0,
              ),
              child: Center(
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(30 / 360),
                  child: Image.asset(
                    'assets/icons/app_logo.png',
                    color: Theme.of(context).colorScheme.surface,
                    width: 225,
                    height: 225,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
