import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/check_auth_state.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/reset_password.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/send_reset_password_otp.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/sign_in.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/sign_out.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/sign_up.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SignUp signUp;
  final SignIn signIn;
  final CheckAuthState checkAuthState;
  final SignOut signOut;
  final SendResetPasswordOTP sendResetPasswordOTP;
  final ResetPassword resetPassword;

  AuthenticationBloc({
    required this.signUp,
    required this.signIn,
    required this.checkAuthState,
    required this.signOut,
    required this.sendResetPasswordOTP,
    required this.resetPassword,
  }) : super(
         const AuthenticationState(
           authenticationStatus: AuthenticationStatus.loading,
         ),
       ) {
    on<SignInEvent>(_onSignIn);
    on<CheckAuthStateEvent>(_onCheckAuthState);
    on<SignOutEvent>(_onSignOut);
    on<SignUpEvent>(_onSignUp);
    on<SendResetPasswordOTPEvent>(_sendResetPasswordOTP);
    on<ResetPasswordEvent>(_onResetPassword);
  }

  _onSignIn(SignInEvent event, Emitter<AuthenticationState> emit) async {
    emit(
      const AuthenticationState(
        authenticationStatus: AuthenticationStatus.loading,
      ),
    );

    final isRightOrFailure = await signIn.execute(
      email: event.email,
      password: event.password,
    );

    isRightOrFailure.fold(
      (failure) {
        emit(
          AuthenticationState(
            authenticationStatus: AuthenticationStatus.signInError,
            message: mapFailureToMessage(failure: failure),
          ),
        );
      },
      (isRight) {
        emit(
          const AuthenticationState(
            authenticationStatus: AuthenticationStatus.signInSuccess,
          ),
        );
      },
    );
  }

  _onCheckAuthState(
    CheckAuthStateEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(
      const AuthenticationState(
        authenticationStatus: AuthenticationStatus.loading,
      ),
    );

    final isRightOrFailure = await checkAuthState.execute();

    isRightOrFailure.fold(
      (failure) {
        emit(
          AuthenticationState(
            authenticationStatus: AuthenticationStatus.unauthenticated,
          ),
        );
      },
      (isRight) {
        emit(
          const AuthenticationState(
            authenticationStatus: AuthenticationStatus.authenticated,
          ),
        );
      },
    );
  }

  _onSignOut(SignOutEvent event, Emitter<AuthenticationState> emit) async {
    emit(
      const AuthenticationState(
        authenticationStatus: AuthenticationStatus.loading,
      ),
    );

    final isRightOrFailure = await signOut.execute();

    isRightOrFailure.fold(
      (failure) {
        emit(
          AuthenticationState(
            authenticationStatus: AuthenticationStatus.signOutError,
            message: mapFailureToMessage(failure: failure),
          ),
        );
      },
      (isRight) {
        emit(
          const AuthenticationState(
            authenticationStatus: AuthenticationStatus.signOutSuccess,
          ),
        );
      },
    );
  }

  _onSignUp(SignUpEvent event, Emitter<AuthenticationState> emit) async {
    emit(
      const AuthenticationState(
        authenticationStatus: AuthenticationStatus.loading,
      ),
    );

    final isRightOrFailure = await signUp.execute(
      username: event.username,
      email: event.email,
      password: event.password,
    );

    isRightOrFailure.fold(
      (failure) {
        emit(
          AuthenticationState(
            authenticationStatus: AuthenticationStatus.signUpError,
            message: mapFailureToMessage(failure: failure),
          ),
        );
      },
      (isRight) {
        emit(
          AuthenticationState(
            authenticationStatus: AuthenticationStatus.signUpSuccess,
          ),
        );
      },
    );
  }

  _sendResetPasswordOTP(
    SendResetPasswordOTPEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(
      const AuthenticationState(
        authenticationStatus: AuthenticationStatus.loading,
      ),
    );

    final isRightOrFailure = await sendResetPasswordOTP.execute(
      email: event.email,
    );

    isRightOrFailure.fold(
      (failure) {
        emit(
          AuthenticationState(
            authenticationStatus: AuthenticationStatus.resetPasswordOTPError,
            message: mapFailureToMessage(failure: failure),
          ),
        );
      },
      (isRight) {
        emit(
           AuthenticationState(
            authenticationStatus: AuthenticationStatus.resetPasswordOTPSent,
            message: otpCodeSentText,
          ),
        );
      },
    );
  }

  _onResetPassword(
    ResetPasswordEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(
      const AuthenticationState(
        authenticationStatus: AuthenticationStatus.loading,
      ),
    );

    final isRightOrFailure = await resetPassword.execute(
      email: event.email,
      newPassword: event.newPassword,
      otp: event.otp,
    );

    isRightOrFailure.fold(
      (failure) {
        emit(
          AuthenticationState(
            authenticationStatus: AuthenticationStatus.resetPasswordError,
            message: mapFailureToMessage(failure: failure),
          ),
        );
      },
      (isRight) {
        emit(
          const AuthenticationState(
            authenticationStatus: AuthenticationStatus.resetPasswordSuccess,
          ),
        );
      },
    );
  }

}
