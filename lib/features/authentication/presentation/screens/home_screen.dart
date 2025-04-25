import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_app/features/authentication/presentation/bloc/authentication_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.authenticationStatus == AuthenticationStatus.signOutSuccess) {
          context.go('/sign_in');
        }
        if (state.authenticationStatus == AuthenticationStatus.signOutError ) {
          print('error: ${state.message}');
        }
      },
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).add(SignOutEvent());
          },
          child: Text('signOut'),
        ),
      ),
    );
  }
}
