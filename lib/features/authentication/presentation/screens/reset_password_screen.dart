import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_app/features/authentication/presentation/widgets/reset_password_screen_widgets/reset_password_form_widget.dart';


import '../bloc/authentication_bloc.dart';
import '../widgets/reset_password_screen_widgets/send_otp_code_form_widget.dart';
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

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
        'Reset Password',
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
            child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state.authenticationStatus ==
                    AuthenticationStatus.resetPasswordOTPSent) {
                  Navigator.pop(context);
                  return ResetPasswordFormWidget(sizedBoxHeight:  MediaQuery.of(context).size.height * 0.1,);
                }
                return SendOtpCodeFormWidget();
              },
              listener: (context, state){
                if(state.authenticationStatus == AuthenticationStatus.resetPasswordSuccess){
                  Navigator.pop(context);
                  context.go('/sign_in');

                }
              },
            ),
          ),
        ),
      ),
    );
  }

}
