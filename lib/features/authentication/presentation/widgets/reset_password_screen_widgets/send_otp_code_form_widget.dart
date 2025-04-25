import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../bloc/authentication_bloc.dart';
import '../authentication_alert_dialog_widget.dart';

class SendOtpCodeFormWidget extends StatefulWidget {
  const SendOtpCodeFormWidget({super.key});

  @override
  State<SendOtpCodeFormWidget> createState() => _SendOtpCodeFormWidgetState();
}

class _SendOtpCodeFormWidgetState extends State<SendOtpCodeFormWidget> {
  final _formKey = GlobalKey<FormState>();
  late String email = "";

  @override
  Widget build(BuildContext context) {
    return Column(
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
