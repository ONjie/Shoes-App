part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  loading,
  success,
  signInSuccess,
  signInError,
  signOutSuccess,
  signOutError,
  signUpSuccess,
  signUpError,
  resetPasswordOTPSent,
  resetPasswordOTPError,
  resetPasswordSuccess,
  resetPasswordError,
  error,
  noInternetConnection,
  authenticated,
  unauthenticated,
}

class AuthenticationState extends Equatable {
  final AuthenticationStatus authenticationStatus;
  final String? message;

  const AuthenticationState({required this.authenticationStatus, this.message});

  @override
  List<Object?> get props => [authenticationStatus, message];
}
