import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/failures/failures.dart';
import 'package:shoes_app/core/utils/text/info_messages.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/check_auth_state.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/reset_password.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/send_reset_password_otp.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/sign_in.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/sign_out.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/sign_up.dart';
import 'package:shoes_app/features/authentication/presentation/bloc/authentication_bloc.dart';

class MockSignIn extends Mock implements SignIn {}

class MockSignOut extends Mock implements SignOut {}

class MockSignUp extends Mock implements SignUp {}

class MockAuthState extends Mock implements CheckAuthState {}

class MockResetPassword extends Mock implements ResetPassword {}

class MockSendResetPasswordOTP extends Mock
    implements SendResetPasswordOTP {}

void main() {
  late AuthenticationBloc authenticationBloc;
  late MockAuthState mockAuthState;
  late MockSignUp mockSignUp;
  late MockSignIn mockSignIn;
  late MockSendResetPasswordOTP mockSendResetPasswordOTP;
  late MockResetPassword mockResetPassword;
  late MockSignOut mockSignOut;

  setUp(() {
    mockSignOut = MockSignOut();
    mockSignIn = MockSignIn();
    mockSignUp = MockSignUp();
    mockAuthState = MockAuthState();
    mockResetPassword = MockResetPassword();
    mockSendResetPasswordOTP = MockSendResetPasswordOTP();

    authenticationBloc = AuthenticationBloc(
      signUp: mockSignUp,
      signIn: mockSignIn,
      checkAuthState: mockAuthState,
      signOut: mockSignOut,
      sendResetPasswordOTP: mockSendResetPasswordOTP,
      resetPassword: mockResetPassword,
    );
  });

  const tUsername = 'user';
  const tEmail = 'user@example.com';
  const tPassword = 'password123';
  const tNewPassword = 'newPassword123';
  const tOTPToken = '123456';

  group('_onSignIn', () {
    blocTest(
      'Should emit [AuthenticationStatus.loading, AuthenticationStatus.signInSuccess] when successful',
      setUp: () {
        when(
          () => mockSignIn.execute(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => const Right(true));
      },
      build: () => authenticationBloc,
      act:
          (bloc) => authenticationBloc.add(
            const SignInEvent(email: tEmail, password: tPassword),
          ),
      expect:
          () => <AuthenticationState>[
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.loading,
            ),
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.signInSuccess,
            ),
          ],
    );

    blocTest(
      'Should emit [AuthenticationStatus.loading, AuthenticationStatus.signInError] when unsuccessful',
      setUp: () {
        when(
          () => mockSignIn.execute(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => Left(SupabaseAuthFailure(message: 'Error')));
      },
      build: () => authenticationBloc,
      act:
          (bloc) => authenticationBloc.add(
            const SignInEvent(email: tEmail, password: tPassword),
          ),
      expect:
          () => <AuthenticationState>[
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.loading,
            ),
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.signInError,
              message: 'Error',
            ),
          ],
    );
  });

  group('_onCheckAuthState', () {
    blocTest(
      'Should emit [AuthenticationStatus.loading, AuthenticationStatus.authenticated] when user is signedIn',
      setUp: () {
        when(
          () => mockAuthState.execute(),
        ).thenAnswer((_) async => const Right(true));
      },
      build: () => authenticationBloc,
      act: (bloc) => authenticationBloc.add(CheckAuthStateEvent()),
      expect:
          () => <AuthenticationState>[
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.loading,
            ),
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.authenticated,
            ),
          ],
    );

    blocTest(
      'Should emit [AuthenticationStatus.loading, AuthenticationStatus.unauthenticated] when user is signedOut',
      setUp: () {
        when(() => mockAuthState.execute()).thenAnswer(
          (_) async => const Left(SupabaseAuthFailure(message: 'Error')),
        );
      },
      build: () => authenticationBloc,
      act: (bloc) => authenticationBloc.add(CheckAuthStateEvent()),
      expect:
          () => <AuthenticationState>[
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.loading,
            ),
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.unauthenticated,
            ),
          ],
    );
  });

  group('_onSignOut', () {
    blocTest(
      'Should emit [AuthenticationStatus.loading, AuthenticationStatus.signOutSuccess] when successful',
      setUp: () {
        when(
          () => mockSignOut.execute(),
        ).thenAnswer((_) async => const Right(true));
      },
      build: () => authenticationBloc,
      act: (bloc) => authenticationBloc.add(SignOutEvent()),
      expect:
          () => <AuthenticationState>[
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.loading,
            ),
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.signOutSuccess,
            ),
          ],
    );

    blocTest(
      'Should emit [AuthenticationStatus.loading, AuthenticationStatus.signOutError] when there is not internet connection',
      setUp: () {
        when(() => mockSignOut.execute()).thenAnswer(
          (_) async => const Left(InternetConnectionFailure(message: 'Error')),
        );
      },
      build: () => authenticationBloc,
      act: (bloc) => authenticationBloc.add(SignOutEvent()),
      expect:
          () => <AuthenticationState>[
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.loading,
            ),
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.signOutError,
              message: 'Error',
            ),
          ],
    );
  });

  group('_onSignUp', () {
    blocTest(
      'should emit [AuthenticationStatus.loading, AuthenticationStatus.signUpError]',
      setUp: () {
        when(
          () => mockSignUp.execute(
            username: any(named: 'username'),
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer(
          (_) async => const Left(SupabaseAuthFailure(message: 'Error')),
        );
      },
      build: () => authenticationBloc,
      act:
          (bloc) => authenticationBloc.add(
            const SignUpEvent(
              username: tUsername,
              email: tEmail,
              password: tPassword,
            ),
          ),
      expect:
          () => <AuthenticationState>[
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.loading,
            ),
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.signUpError,
              message: 'Error',
            ),
          ],
    );

    blocTest(
      'should emit [AuthenticationStatus.loading, AuthenticationStatus.signUpSuccess]',
      setUp: () {
        when(
          () => mockSignUp.execute(
            username: any(named: 'username'),
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => Right(true));
      },
      build: () => authenticationBloc,
      act:
          (bloc) => authenticationBloc.add(
            const SignUpEvent(
              username: tUsername,
              email: tEmail,
              password: tPassword,
            ),
          ),
      expect:
          () => <AuthenticationState>[
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.loading,
            ),
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.signUpSuccess,
            ),
          ],
    );
  });

  group('_sendResetPasswordOTP', () {
    blocTest(
      'should emit[AuthenticationStatus.loading, AuthenticationStatus.resetPasswordOTPSent] when otp is sent',
      setUp: () {
        when(
          () => mockSendResetPasswordOTP.execute(email: any(named: 'email')),
        ).thenAnswer((_) async => const Right(true));
      },
      build: () => authenticationBloc,
      act:
          (bloc) => authenticationBloc.add(
            const SendResetPasswordOTPEvent(email: tEmail),
          ),
      expect:
          () => <AuthenticationState>[
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.loading,
            ),
            AuthenticationState(
              authenticationStatus: AuthenticationStatus.resetPasswordOTPSent,
              message: otpCodeSentText,
            ),
          ],
    );

    blocTest(
      'should emit[AuthenticationStatus.loading, AuthenticationStatus.resetPasswordOTPError] when unsuccessful',
      setUp: () {
        when(
          () => mockSendResetPasswordOTP.execute(email: any(named: 'email')),
        ).thenAnswer(
          (_) async => const Left(SupabaseAuthFailure(message: 'Error')),
        );
      },
      build: () => authenticationBloc,
      act:
          (bloc) => authenticationBloc.add(
            const SendResetPasswordOTPEvent(email: tEmail),
          ),
      expect:
          () => <AuthenticationState>[
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.loading,
            ),
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.resetPasswordOTPError,
              message: 'Error',
            ),
          ],
    );
  });

   group('_resetPassword', () {
    blocTest(
      'should emit[AuthenticationStatus.loading, AuthenticationStatus.resetPasswordSuccess] when otp is sent',
      setUp: () {
        when(
          () => mockResetPassword.execute(
            email: any(named: 'email'),
            newPassword: any(named: 'newPassword'),
            otp: any(named: 'otp'),
          ),
        ).thenAnswer((_) async => const Right(true));
      },
      build: () => authenticationBloc,
      act:
          (bloc) => authenticationBloc.add(
            ResetPasswordEvent(
              email: tEmail,
              newPassword: tNewPassword,
              otp: tOTPToken,
            ),
          ),
      expect:
          () => <AuthenticationState>[
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.loading,
            ),
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.resetPasswordSuccess,
            ),
          ],
    );

    blocTest(
      'should emit[AuthenticationStatus.loading, AuthenticationStatus.resetPasswordError] when unsuccessful',
      setUp: () {
        when(
          () => mockResetPassword.execute(
            email: any(named: 'email'),
            newPassword: any(named: 'newPassword'),
            otp: any(named: 'otp'),
          ),
        ).thenAnswer(
          (_) async => const Left(SupabaseAuthFailure(message: 'Error')),
        );
      },
      build: () => authenticationBloc,
      act:
          (bloc) => authenticationBloc.add(
            ResetPasswordEvent(
              email: tEmail,
              newPassword: tNewPassword,
              otp: tOTPToken,
            ),
          ),
      expect:
          () => <AuthenticationState>[
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.loading,
            ),
            const AuthenticationState(
              authenticationStatus: AuthenticationStatus.resetPasswordError,
              message: 'Error',
            ),
          ],
    );
  });
}
