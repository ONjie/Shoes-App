import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/exceptions/exceptions.dart';
import 'package:shoes_app/core/failures/failures.dart';
import 'package:shoes_app/core/network/network_info.dart';
import 'package:shoes_app/core/utils/text/error_messages.dart';
import 'package:shoes_app/features/authentication/data/datasources/remote%20data/supabase_auth_service.dart';
import 'package:shoes_app/features/authentication/data/repositories/authentication_repository_impl.dart';

class MockSupabaseAuthService extends Mock implements SupabaseAuthService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late AuthenticationRepositoryImpl authenticationRepositoryImpl;
  late MockSupabaseAuthService mockSupabaseAuthService;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockSupabaseAuthService = MockSupabaseAuthService();
    authenticationRepositoryImpl = AuthenticationRepositoryImpl(
      supabaseAuthService: mockSupabaseAuthService,
      networkInfo: mockNetworkInfo,
    );
  });

  const tUsername = 'user';
  const tEmail = 'user@example.com';
  const tPassword = 'password123';
  const tUserId = 'user123';
  const tNewPassword = 'newPassword123';
  const tOTPToken = '123456';

  void runOnlineTest(Function body) {
    group('when device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runOfflineTest(Function body) {
    group('when device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('checkAuthstate', () {
    test('checks if the device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      //act
      authenticationRepositoryImpl.checkAuthState();

      //assert
      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    runOfflineTest(() {
      test(
        'should return Left(InternetConnectionFailure) when device is offline',
        () async {
          //act
          final result = await authenticationRepositoryImpl.checkAuthState();

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(
              InternetConnectionFailure(message: noInternetConnectionMessage),
            ),
          );
        },
      );
    });

    runOnlineTest(() {
      test('should return Right(true) when successful', () async {
        //arrange
        when(
          () => mockSupabaseAuthService.checkAuthState(),
        ).thenAnswer((_) async => true);

        //act
        final result = await authenticationRepositoryImpl.checkAuthState();

        //assert
        expect(result, isA<Right<Failure, bool>>());
        expect(result.right, equals(true));
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(() => mockSupabaseAuthService.checkAuthState()).called(1);
        verifyNoMoreInteractions(mockSupabaseAuthService);
        verifyNoMoreInteractions(mockNetworkInfo);
      });
      test(
        'should return Left(SupabaseAuthFailure) when SupabaseAuthException is thrown',
        () async {
          //arrange
          when(
            () => mockSupabaseAuthService.checkAuthState(),
          ).thenThrow(SupabaseAuthException(message: 'Error'));

          //act
          final result = await authenticationRepositoryImpl.checkAuthState();

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(result.left, equals(SupabaseAuthFailure(message: 'Error')));
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(() => mockSupabaseAuthService.checkAuthState()).called(1);
          verifyNoMoreInteractions(mockSupabaseAuthService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );

      test(
        'should return Left(OtherFailure) when OtherExceptions is thrown',
        () async {
          //arrange
          when(
            () => mockSupabaseAuthService.checkAuthState(),
          ).thenThrow(OtherExceptions(message: 'Error'));

          //act
          final result = await authenticationRepositoryImpl.checkAuthState();

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(result.left, equals(OtherFailure(message: 'Error')));
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(() => mockSupabaseAuthService.checkAuthState()).called(1);
          verifyNoMoreInteractions(mockSupabaseAuthService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });
  });

  group('signIn', () {
    test('checks if the device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      //act
      authenticationRepositoryImpl.signIn(email: tEmail, password: tPassword);

      //assert
      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    runOfflineTest(() {
      test(
        'should return Left(InternetConnectionFailure) when device is offline',
        () async {
          //act
          final result = await authenticationRepositoryImpl.signIn(
            email: tEmail,
            password: tPassword,
          );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(
              InternetConnectionFailure(message: noInternetConnectionMessage),
            ),
          );
        },
      );
    });

    runOnlineTest(() {
      test('should return Right(true) when successful', () async {
        //arrange
        when(
          () => mockSupabaseAuthService.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => true);

        //act
        final result = await authenticationRepositoryImpl.signIn(
          email: tEmail,
          password: tPassword,
        );

        //assert
        expect(result, isA<Right<Failure, bool>>());
        expect(result.right, equals(true));
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(
          () => mockSupabaseAuthService.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockSupabaseAuthService);
        verifyNoMoreInteractions(mockNetworkInfo);
      });
      test(
        'should return Left(SupabaseAuthFailure) when SupabaseAuthException is thrown',
        () async {
          //arrange
          when(
            () => mockSupabaseAuthService.signIn(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenThrow(SupabaseAuthException(message: noUserFoundMessage));

          //act
          final result = await authenticationRepositoryImpl.signIn(
            email: tEmail,
            password: tPassword,
          );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(SupabaseAuthFailure(message: noUserFoundMessage)),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () => mockSupabaseAuthService.signIn(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).called(1);
          verifyNoMoreInteractions(mockSupabaseAuthService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
      test(
        'should return Left(OtherFailure) when OtherExceptions is thrown',
        () async {
          //arrange
          when(
            () => mockSupabaseAuthService.signIn(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenThrow(OtherExceptions(message: 'Error'));

          //act
          final result = await authenticationRepositoryImpl.signIn(
            email: tEmail,
            password: tPassword,
          );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(result.left, equals(OtherFailure(message: 'Error')));
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () => mockSupabaseAuthService.signIn(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).called(1);
          verifyNoMoreInteractions(mockSupabaseAuthService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });
  });

  group('signOut', () {
    test('checks if the device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      //act
      authenticationRepositoryImpl.signOut();

      //assert
      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    runOfflineTest(() {
      test(
        'should return Left(InternetConnectionFailure) when device is offline',
        () async {
          //act
          final result = await authenticationRepositoryImpl.signOut();

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(
              InternetConnectionFailure(message: noInternetConnectionMessage),
            ),
          );
        },
      );
    });

    runOnlineTest(() {
      test('should return Right(true) when successful', () async {
        //arrange
        when(() => mockSupabaseAuthService.signOut()).thenAnswer((_) async {});

        //act
        final result = await authenticationRepositoryImpl.signOut();

        //assert
        expect(result, isA<Right<Failure, bool>>());
        expect(result.right, equals(true));
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(() => mockSupabaseAuthService.signOut()).called(1);
        verifyNoMoreInteractions(mockSupabaseAuthService);
        verifyNoMoreInteractions(mockNetworkInfo);
      });
      test(
        'should return Left(SupabaseAuthFailure) when SupabaseAuthException is thrown',
        () async {
          //arrange
          when(
            () => mockSupabaseAuthService.signOut(),
          ).thenThrow(SupabaseAuthException(message: 'Error'));

          //act
          final result = await authenticationRepositoryImpl.signOut();

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(result.left, equals(SupabaseAuthFailure(message: 'Error')));
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(() => mockSupabaseAuthService.signOut()).called(1);
          verifyNoMoreInteractions(mockSupabaseAuthService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });
  });

  group('signUp', () {
    test('checks if the device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      //act
      authenticationRepositoryImpl.signUp(
        username: tUsername,
        email: tEmail,
        password: tPassword,
      );

      //assert
      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    runOfflineTest(() {
      test(
        'should return Left(InternetConnectionFailure) when device is offline',
        () async {
          //act
          final result = await authenticationRepositoryImpl.signUp(
            username: tUsername,
            email: tEmail,
            password: tPassword,
          );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(
              InternetConnectionFailure(message: noInternetConnectionMessage),
            ),
          );
        },
      );
    });

    runOnlineTest(() {
      test('should return Right(true) when successful', () async {
        //arrange
        when(
          () => mockSupabaseAuthService.signUp(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => tUserId);
        when(
          () => mockSupabaseAuthService.createAccount(
            username: any(named: 'username'),
            email: any(named: 'email'),
            userId: any(named: 'userId'),
          ),
        ).thenAnswer((_) async {});

        //act
        final result = await authenticationRepositoryImpl.signUp(
          username: tUsername,
          email: tEmail,
          password: tPassword,
        );

        //assert
        expect(result, isA<Right<Failure, bool>>());
        expect(result.right, equals(true));
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(
          () => mockSupabaseAuthService.signUp(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).called(1);
        verify(
          () => mockSupabaseAuthService.createAccount(
            username: any(named: 'username'),
            email: any(named: 'email'),
            userId: any(named: 'userId'),
          ),
        ).called(1);

        verifyNoMoreInteractions(mockSupabaseAuthService);
        verifyNoMoreInteractions(mockNetworkInfo);
      });
      test(
        'should return Left(SupabaseAuthFailure) when SupabaseAuthException is thrown',
        () async {
          //arrange
          when(
            () => mockSupabaseAuthService.signUp(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenThrow(SupabaseAuthException(message: 'Error'));

          //act
          final result = await authenticationRepositoryImpl.signUp(
            username: tUsername,
            email: tEmail,
            password: tPassword,
          );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(result.left, equals(SupabaseAuthFailure(message: 'Error')));
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () => mockSupabaseAuthService.signUp(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).called(1);
          verifyNoMoreInteractions(mockSupabaseAuthService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );

      test(
        'should return Left(OtherFailure) when OtherExceptions is thrown',
        () async {
          //arrange
          when(
            () => mockSupabaseAuthService.signUp(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenThrow(OtherExceptions(message: 'Error'));

          //act
          final result = await authenticationRepositoryImpl.signUp(
            username: tUsername,
            email: tEmail,
            password: tPassword,
          );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(result.left, equals(OtherFailure(message: 'Error')));
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () => mockSupabaseAuthService.signUp(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).called(1);
          verifyNoMoreInteractions(mockSupabaseAuthService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });
  });

  group('sendResetPasswordOTP', () {
    test('checks if the device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      //act
      authenticationRepositoryImpl.sendResetPasswordOTP(email: tEmail);

      //assert
      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    runOfflineTest(() {
      test(
        'should return Left(InternetConnectionFailure) when device is offline',
        () async {
          //act
          final result = await authenticationRepositoryImpl
              .sendResetPasswordOTP(email: tEmail);

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(
              InternetConnectionFailure(message: noInternetConnectionMessage),
            ),
          );
        },
      );
    });

    runOnlineTest(() {
      test('should return Right(true) when successful', () async {
        //arrange
        when(
          () => mockSupabaseAuthService.sendResetPasswordOTP(
            email: any(named: 'email'),
          ),
        ).thenAnswer((_) async {});

        //act
        final result = await authenticationRepositoryImpl.sendResetPasswordOTP(
          email: tEmail,
        );

        //assert
        expect(result, isA<Right<Failure, bool>>());
        expect(result.right, equals(true));
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(
          () => mockSupabaseAuthService.sendResetPasswordOTP(
            email: any(named: 'email'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockSupabaseAuthService);
        verifyNoMoreInteractions(mockNetworkInfo);
      });
      test(
        'should return Left(SupabaseAuthFailure) when SupabaseAuthException is thrown',
        () async {
          //arrange
          when(
            () => mockSupabaseAuthService.sendResetPasswordOTP(
              email: any(named: 'email'),
            ),
          ).thenThrow(SupabaseAuthException(message: 'Error'));

          //act
          final result = await authenticationRepositoryImpl
              .sendResetPasswordOTP(email: tEmail);

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(result.left, equals(SupabaseAuthFailure(message: 'Error')));
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () => mockSupabaseAuthService.sendResetPasswordOTP(
              email: any(named: 'email'),
            ),
          ).called(1);
          verifyNoMoreInteractions(mockSupabaseAuthService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );

      test(
        'should return Left(OtherFailure) when OtherExceptions is thrown',
        () async {
          //arrange
          when(
            () => mockSupabaseAuthService.sendResetPasswordOTP(
              email: any(named: 'email'),
            ),
          ).thenThrow(OtherExceptions(message: 'Error'));

          //act
          final result = await authenticationRepositoryImpl
              .sendResetPasswordOTP(email: tEmail);

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(result.left, equals(OtherFailure(message: 'Error')));
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () => mockSupabaseAuthService.sendResetPasswordOTP(
              email: any(named: 'email'),
            ),
          ).called(1);
          verifyNoMoreInteractions(mockSupabaseAuthService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });
  });

  group('resetPassword', () {
    test('checks if the device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      //act
      authenticationRepositoryImpl.resetPassword(
        email: tEmail,
        otp: tOTPToken,
        newPassword: tNewPassword,
      );

      //assert
      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    runOfflineTest(() {
      test(
        'should return Left(InternetConnectionFailure) when device is offline',
        () async {
          //act
          final result = await authenticationRepositoryImpl.resetPassword(
            email: tEmail,
            otp: tOTPToken,
            newPassword: tNewPassword,
          );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(
              InternetConnectionFailure(message: noInternetConnectionMessage),
            ),
          );
        },
      );
    });

    runOnlineTest(() {
      test('should return Right(true) when successful', () async {
        //arrange
        when(
          () =>
              mockSupabaseAuthService.verifyOTP(email: tEmail, otp: tOTPToken),
        ).thenAnswer((_) async {});
        when(
          () =>
              mockSupabaseAuthService.updatePassword(newPassword: tNewPassword),
        ).thenAnswer((_) async {});

        //act
        final result = await authenticationRepositoryImpl.resetPassword(
            email: tEmail,
            otp: tOTPToken,
            newPassword: tNewPassword,
          );

        //assert
        expect(result, isA<Right<Failure, bool>>());
        expect(result.right, equals(true));
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(
          () => mockSupabaseAuthService.verifyOTP(email: tEmail, otp: tOTPToken),
        ).called(1);
        verify(
          () => mockSupabaseAuthService.updatePassword(newPassword: tNewPassword),
        ).called(1);
        verifyNoMoreInteractions(mockSupabaseAuthService);
        verifyNoMoreInteractions(mockNetworkInfo);
      });
      test(
        'should return Left(SupabaseAuthFailure) when SupabaseAuthException is thrown',
        () async {
          //arrange
          when(
          () =>
              mockSupabaseAuthService.verifyOTP(email: tEmail, otp: tOTPToken),
        ).thenThrow(SupabaseAuthException(message: 'Error'));


          //act
          final result = await authenticationRepositoryImpl.resetPassword(
            email: tEmail,
            otp: tOTPToken,
            newPassword: tNewPassword,
          );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(result.left, equals(SupabaseAuthFailure(message: 'Error')));
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () => mockSupabaseAuthService.verifyOTP(email: tEmail, otp: tOTPToken)
          ).called(1);
          verifyNoMoreInteractions(mockSupabaseAuthService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );

     test(
        'should return Left(OtherFailure) when OtherExceptions is thrown',
        () async {
           //arrange
          when(
          () =>
              mockSupabaseAuthService.verifyOTP(email: tEmail, otp: tOTPToken),
        ).thenThrow(OtherExceptions(message: 'Error'));


          //act
          final result = await authenticationRepositoryImpl.resetPassword(
            email: tEmail,
            otp: tOTPToken,
            newPassword: tNewPassword,
          );
          
          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(result.left, equals(OtherFailure(message: 'Error')));
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () => mockSupabaseAuthService.verifyOTP(email: tEmail, otp: tOTPToken)
          ).called(1);
          verifyNoMoreInteractions(mockSupabaseAuthService);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });
  });
}
