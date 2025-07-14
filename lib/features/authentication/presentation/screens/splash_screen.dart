import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoes_app/features/authentication/presentation/bloc/authentication_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _checkIsFirstTime();
    super.initState();
  }

  void _checkIsFirstTime() async {
    await Future.delayed(const Duration(seconds: 5)).whenComplete(() async {
      final sharedPreferences = await SharedPreferences.getInstance();
      bool isFirstTime = sharedPreferences.getBool('isFirstTime') ?? true;

      if (isFirstTime) {
        await sharedPreferences.setBool('isFirstTime', false);
        if (!mounted) return;
        context.go('/onboarding');
      } else {
        if (!mounted) return;
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
        if (didPop) {
          exit(0);
        }
      },
      child: SafeArea(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
            child: BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state.authenticationStatus ==
                    AuthenticationStatus.authenticated) {
                  context.go('/home/0');
                }
                if (state.authenticationStatus ==
                    AuthenticationStatus.unauthenticated) {
                  context.go('/sign_in');
                }
                if (state.authenticationStatus ==
                    AuthenticationStatus.noInternetConnection) {
                  context.go('/splash_screen_error_widget/${state.message}');
                }
              },
              child: Center(
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(30 / 360),
                  child: Lottie.asset('assets/lottie/shoe_animation.json'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
