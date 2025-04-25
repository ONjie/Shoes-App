import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../bloc/authentication_bloc.dart';
import '../authentication_alert_dialog_widget.dart';

class ResetPasswordFormWidget extends StatefulWidget {
  const ResetPasswordFormWidget({super.key});

  @override
  State<ResetPasswordFormWidget> createState() =>
      _ResetPasswordFormWidgetState();
}

class _ResetPasswordFormWidgetState extends State<ResetPasswordFormWidget> {
  final _formKey = GlobalKey<FormState>();
  late String email = "";
  late String otp = "";
  late String newPassword = "";
  late String confirmNewPassword = "";

   bool _obscureText = false;
   bool _obscureTextTwo = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              buildOTPCodeTextFormField(),
              SizedBox(height: 16),
              buildEmailTextFormField(),
              SizedBox(height: 16),
              buildNewPasswordTextFormField(),
              SizedBox(height: 16),
              buildConfirmPasswordTextFormField(),
              SizedBox(height: 50),
              buildResetPasswordButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildOTPCodeTextFormField() {
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
          hintText: 'OTP Code',
          showPrefixIcon: true,
          prefixIcon: Icon(
            Icons.pin_outlined,
            color: Theme.of(context).colorScheme.primary,
            size: 30,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Otp code cannot be empty';
          }
          return null;
        },
        onChanged: (value) {
          setState(() => otp = value.trim());
        },
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

  Widget buildNewPasswordTextFormField() {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        obscureText: !_obscureText,
        obscuringCharacter: '*',
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
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
          setState(() => newPassword = value.trim());
        },
      ),
    );
  }

  Widget buildConfirmPasswordTextFormField() {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        obscureText: !_obscureTextTwo,
        obscuringCharacter: '*',
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
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
          hintText: 'Confirm Password',
          showSuffixIcon: true,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() => _obscureTextTwo = !_obscureTextTwo);
            },
            icon: Icon(
              _obscureTextTwo
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
            return 'Confirm password cannot be empty';
          } else if (newPassword != value) {
            return 'Passwords do not match';
          }
          return null;
        },
        onChanged: (value) {
          setState(() => confirmNewPassword = value.trim());
        },
      ),
    );
  }

  
Widget buildResetPasswordButton() {
    return ElevatedButtonWidget(
      buttonText: resetPasswordText,
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
          ).add(ResetPasswordEvent(email: email, otp: otp, newPassword: newPassword));
          await authenticationAlertDialogWidget(context: context);
        }
      },
    );
  }




}
