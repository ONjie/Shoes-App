import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';
import '../bloc/authentication_bloc.dart';
import '../widgets/authentication_alert_dialog_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late String email = "";

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
          context.go('/sign_in');
        },
        icon: Icon(
          CupertinoIcons.back,
          color: Theme.of(context).colorScheme.surface,
          size: 30,
        ),
      ),
      title: Text(
        'Forgot Password',
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
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
            child: BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state.authenticationStatus ==
                    AuthenticationStatus.resetPasswordOTPSent) {
                  Navigator.pop(context);
                  context.go('/reset_password');
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter your email address and we\'ll send you an OTP Code to reset your password.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 30),
                  Form(key: _formKey, child: buildEmailTextFormField()),
                  const SizedBox(height: 30),
                  buildSendOTPButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmailTextFormField() {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.none,
        style: Theme.of(context).textTheme.bodyLarge,
        decoration: textFormFieldDecorationWidget(
          borderRadius: 12,
          borderSideColor: Theme.of(context).colorScheme.primary,
          filled: true,
          fillColor: Theme.of(
            context,
          ).colorScheme.primary.withValues(alpha: 0.1),
          context: context,
          hintTextColor: Theme.of(
            context,
          ).colorScheme.secondary.withValues(alpha: 0.8),
          hintText: 'Email',
          showPrefixIcon: true,
          prefixIcon: Icon(
            Icons.email_outlined,
            color: Theme.of(context).colorScheme.primary,
            size: 30,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Email cannot be empty';
          }
          return null;
        },
        onChanged: (value) {
          setState(() => email = value.trim());
        },
      ),
    );
  }

  Widget buildSendOTPButton() {
    return ElevatedButtonWidget(
      buttonText: sendOTPText,
      textColor: Theme.of(context).colorScheme.surface,
      textFontSize: 20,
      buttonWidth: double.infinity,
      backgroundColor: Theme.of(context).colorScheme.primary,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      radius: 10,
      borderSideColor: Theme.of(context).colorScheme.primary,
      borderSideWidth: 1,
      padding: const EdgeInsets.all(12),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          BlocProvider.of<AuthenticationBloc>(
            context,
          ).add(SendResetPasswordOTPEvent(email: email));
          await authenticationAlertDialogWidget(context: context);
        }
      },
    );
  }
}
