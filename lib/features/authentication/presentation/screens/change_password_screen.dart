import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_app/core/core.dart';

import '../bloc/authentication_bloc.dart';
import '../widgets/reset_password_screen_widgets/reset_password_form_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key, required this.email});

  final String email;

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool showMessage = false;
  @override
  void initState() {
    BlocProvider.of<AuthenticationBloc>(
      context,
    ).add(SendResetPasswordOTPEvent(email: widget.email));
    super.initState();
  }

  void _delayEvent() {
    Future.delayed(Duration(seconds: 3)).then((_) {
      if (!mounted) return;
      BlocProvider.of<AuthenticationBloc>(context).add(SignOutEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: buildAppBar(),
      body: buildBody(context: context),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () {
          context.go('/home/3');
        },
        icon: Icon(
          CupertinoIcons.back,
          color: Theme.of(context).colorScheme.surface,
          size: 30,
        ),
      ),
      title: Text(
        'Change Password',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
    );
  }

  Widget buildBody({required BuildContext context}) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 50, 12, 0),
            child: BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state.authenticationStatus ==
                    AuthenticationStatus.resetPasswordOTPSent) {
                  setState(() {
                    showMessage = true;
                  });
                }
                if (state.authenticationStatus ==
                    AuthenticationStatus.resetPasswordSuccess) {
                  context.pop();
                  snackBarWidget(
                    context: context,
                    message: state.message!,
                    bgColor: Theme.of(context).colorScheme.primary,
                    duration: 3,
                  );
                  _delayEvent();
                }
                if (state.authenticationStatus ==
                    AuthenticationStatus.sendResetPasswordOTPError) {
                  snackBarWidget(
                    context: context,
                    message: state.message!,
                    bgColor: Theme.of(context).colorScheme.error,
                    duration: 4,
                  );
                }
                if (state.authenticationStatus ==
                    AuthenticationStatus.signOutSuccess) {
                  context.go('/sign_in');
                }
                if (state.authenticationStatus ==
                    AuthenticationStatus.signOutError) {
                  snackBarWidget(
                    context: context,
                    message: state.message!,
                    bgColor: Theme.of(context).colorScheme.error,
                    duration: 4,
                  );
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  showMessage
                      ? Text(
                        'OTP code has been sent to ${widget.email}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                      : SizedBox(),
                  ResetPasswordFormWidget(sizedBoxHeight: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
