part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class SignInEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const SignInEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class CheckAuthStateEvent extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class SignOutEvent extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class SignUpEvent extends AuthenticationEvent {
  final String username;
  final String email;
  final String password;

  const SignUpEvent({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password, username];
}

class SendResetPasswordOTPEvent extends AuthenticationEvent {
  final String email;

  const SendResetPasswordOTPEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class ResetPasswordEvent extends AuthenticationEvent {
  final String email;
  final String otp;
  final String newPassword;

  const ResetPasswordEvent({
    required this.email,
    required this.otp,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [email, otp, newPassword];
}
