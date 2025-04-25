import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';
import '../../bloc/authentication_bloc.dart';
import '../authentication_alert_dialog_widget.dart';

class SignInScreenFormWidget extends StatefulWidget {
  const SignInScreenFormWidget({super.key});

  @override
  State<SignInScreenFormWidget> createState() => _SignInScreenFormWidgetState();
}

class _SignInScreenFormWidgetState extends State<SignInScreenFormWidget> {
  final _formKey = GlobalKey<FormState>();

  late String email = "";
  late String password = "";

  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildSignInForm(),
        const SizedBox(height: 16),
        buildForgetPasswordTextButton(),
        const SizedBox(height: 35),
        buildSignInButton(),
      ],
    );
  }

  Widget buildSignInForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailTextFormField(),
          const SizedBox(height: 20),
          buildPasswordTextFormField(),
        ],
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

  Widget buildPasswordTextFormField() {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        obscureText: !_obscureText,
        obscuringCharacter: '*',
        keyboardType: TextInputType.text,
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
          hintText: 'Password',
          showSuffixIcon: true,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() => _obscureText = !_obscureText);
            },
            icon: Icon(
              _obscureText
                  ? CupertinoIcons.eye_fill
                  : CupertinoIcons.eye_slash_fill,
              color: Theme.of(context).colorScheme.secondary,
              size: 30,
            ),
          ),
          showPrefixIcon: true,
          prefixIcon: Icon(
            Icons.lock_outline_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 30,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Password cannot be empty';
          } else if (value.length < 8) {
            return 'Password must be 8 or more characters';
          }
          return null;
        },
        onChanged: (value) {
          setState(() => password = value.trim());
        },
      ),
    );
  }

  Widget buildForgetPasswordTextButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            context.go('/reset_password');
          },
          child: Text(
            'Forgot password?',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSignInButton() {
    return ElevatedButtonWidget(
      buttonText: signInText,
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
          ).add(SignInEvent(email: email.toLowerCase(), password: password));
          await authenticationAlertDialogWidget(context: context);
        }
      },
    );
  }
}
