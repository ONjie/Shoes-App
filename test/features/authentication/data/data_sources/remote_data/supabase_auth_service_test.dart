import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/exceptions/exceptions.dart';

import 'package:shoes_app/features/authentication/data/datasources/remote%20data/supabase_auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class MockAuthResponse extends Mock implements AuthResponse {}

class MockSession extends Mock implements Session {}

class MockUser extends Mock implements User {}

class MockUserResponse extends Mock implements UserResponse {}

class MockSupabaseQueryBuilder extends Mock implements SupabaseQueryBuilder {}

class MockPostgrestFilterBuilder<T> extends Mock
    implements PostgrestFilterBuilder<T> {}

void main() {
  late SupabaseAuthServiceImpl supabaseAuthService;
  late MockSupabaseClient mockSupabaseClient;
  late MockSession mockSession;
  late MockGoTrueClient mockGoTrueClient;
  late MockAuthResponse mockAuthResponse;
  late MockUser mockUser;
  late MockUserResponse mockUserResponse;
  
  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    mockSession = MockSession();
    mockGoTrueClient = MockGoTrueClient();
    mockAuthResponse = MockAuthResponse();
    mockUser = MockUser();
    mockUserResponse = MockUserResponse();
    supabaseAuthService = SupabaseAuthServiceImpl(
      supabaseClient: mockSupabaseClient,
    );
  });

  const tEmail = "user@example.com";
  const tPassword = "password123";
  const tNewPassword = 'newPassword123';
  const tOTPToken = '123456';

  group('checkAuthState', () {
    test('should return true when session != null', () async {
      //arrange
      when(
        () => mockSupabaseClient.auth.currentSession,
      ).thenReturn(mockSession);
      when(() => mockSession.user).thenReturn(MockUser());
      when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
      when(() => mockGoTrueClient.currentSession).thenReturn(mockSession);

      //act
      final result = await supabaseAuthService.checkAuthState();

      //assert
      expect(result, isA<bool>());
      expect(result, equals(true));
      verify(() => mockSupabaseClient.auth).called(1);
      verify(() => mockGoTrueClient.currentSession).called(1);
      verifyNoMoreInteractions(mockSupabaseClient);
      verifyNoMoreInteractions(mockGoTrueClient);
      verifyNoMoreInteractions(mockSession);
    });
    test('should throw SupabaseAuthException when session == null', () async {
      //arrange
      when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
      when(() => mockGoTrueClient.currentSession).thenReturn(null);

      //act
      final call = supabaseAuthService.checkAuthState;

      //assert
      expect(() => call(), throwsA(isA<SupabaseAuthException>()));
      verify(() => mockSupabaseClient.auth).called(1);
      verify(() => mockGoTrueClient.currentSession).called(1);
      verifyNoMoreInteractions(mockSupabaseClient);
      verifyNoMoreInteractions(mockGoTrueClient);
      verifyNoMoreInteractions(mockSession);
    });

    test('should throw OtherExceptions when an error occurs', () async {
      //arrange
      when(() => mockSupabaseClient.auth).thenThrow(AuthException('Error'));

      //act
      final call = supabaseAuthService.checkAuthState;

      //assert
      expect(() => call(), throwsA(isA<OtherExceptions>()));
      verify(() => mockSupabaseClient.auth).called(1);
      verifyNoMoreInteractions(mockSupabaseClient);
    });
  });

  group('signIn', () {
    test("should successfully sign in with valid credentials ", () async {
      //arrange
      when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
      when(
        () => mockGoTrueClient.signInWithPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => mockAuthResponse);

      //act
      await supabaseAuthService.signIn(email: tEmail, password: tPassword);

      //assert

      verify(() => mockSupabaseClient.auth).called(1);
      verify(
        () => mockGoTrueClient.signInWithPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockSupabaseClient);
      verifyNoMoreInteractions(mockGoTrueClient);
      verifyNoMoreInteractions(mockAuthResponse);
    });

    test(
      "should throw SupabaseAuthException when Supabase Auth throws AuthException ",
      () async {
        //arrange
        when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
        when(
          () => mockGoTrueClient.signInWithPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(AuthException('Error'));

        //act
        final call = supabaseAuthService.signIn;

        //assert
        expect(
          () => call(email: tEmail, password: tPassword),
          throwsA(isA<SupabaseAuthException>()),
        );
        verify(() => mockSupabaseClient.auth).called(1);
        verify(
          () => mockGoTrueClient.signInWithPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockSupabaseClient);
        verifyNoMoreInteractions(mockGoTrueClient);
      },
    );

    test(
      "should throw OtherExceptions when Other Exceptions are thrown ",
      () async {
        //arrange
        when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
        when(
          () => mockGoTrueClient.signInWithPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(Exception('Error'));

        //act
        final call = supabaseAuthService.signIn;

        //assert
        expect(
          () => call(email: tEmail, password: tPassword),
          throwsA(isA<OtherExceptions>()),
        );
        verify(() => mockSupabaseClient.auth).called(1);
        verify(
          () => mockGoTrueClient.signInWithPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockSupabaseClient);
        verifyNoMoreInteractions(mockGoTrueClient);
      },
    );
  });

  group('signOut', () {
    test('should successfully sign  out', () async {
      //arrange
      when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
      when(() => mockGoTrueClient.signOut()).thenAnswer((_) async {});

      //act
      await supabaseAuthService.signOut();

      //assert
      verify(() => mockSupabaseClient.auth).called(1);
      verify(() => mockGoTrueClient.signOut()).called(1);
      verifyNoMoreInteractions(mockSupabaseClient);
      verifyNoMoreInteractions(mockGoTrueClient);
    });

    test('should throw SupabaseAuthException when sign out fails', () async {
      //arrange
      when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
      when(() => mockGoTrueClient.signOut()).thenThrow(AuthException('Error'));

      //act
      final call = supabaseAuthService.signOut;

      //assert
      expect(() => call(), throwsA(isA<SupabaseAuthException>()));
      verify(() => mockSupabaseClient.auth).called(1);
      verify(() => mockGoTrueClient.signOut()).called(1);
      verifyNoMoreInteractions(mockSupabaseClient);
      verifyNoMoreInteractions(mockGoTrueClient);
    });
  });

  group('signUp', () {
    const tUser = 'user123';
    test('should successfully sign up with valid credentials', () async {
      //arrange
      when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
      when(
        () => mockGoTrueClient.signUp(
          email: any(named: 'email'),
          password: any(named: 'password'),
          emailRedirectTo: any(named: 'emailRedirectTo'),
        ),
      ).thenAnswer((_) async => mockAuthResponse);
      when(() => mockAuthResponse.user).thenReturn(mockUser);
      when(() => mockUser.id).thenReturn(tUser);

      //act
      final result = await supabaseAuthService.signUp(
        email: tEmail,
        password: tPassword,
      );

      //assert
      expect(result, isA<String>());
      expect(result, equals(tUser));
      verify(() => mockSupabaseClient.auth).called(1);
      verify(
        () => mockGoTrueClient.signUp(
          email: any(named: 'email'),
          password: any(named: 'password'),
          emailRedirectTo: any(named: 'emailRedirectTo'),
        ),
      ).called(1);
      verify(() => mockAuthResponse.user).called(1);
      verify(() => mockUser.id).called(1);

      verifyNoMoreInteractions(mockSupabaseClient);
      verifyNoMoreInteractions(mockGoTrueClient);
      verifyNoMoreInteractions(mockAuthResponse);
      verifyNoMoreInteractions(mockUser);
    });

    test(
      'should throw SupabaseAuthException when Supabase Auth throws AuthException',
      () async {
        //arrange
        when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
        when(
          () => mockGoTrueClient.signUp(
            email: any(named: 'email'),
            password: any(named: 'password'),
            emailRedirectTo: any(named: 'emailRedirectTo'),
          ),
        ).thenThrow(AuthException('Error'));

        //act
        final call = supabaseAuthService.signUp;

        //assert
        expect(
          () => call(email: tEmail, password: tPassword),
          throwsA(isA<SupabaseAuthException>()),
        );
        verify(() => mockSupabaseClient.auth).called(1);
        verify(
          () => mockGoTrueClient.signUp(
            email: any(named: 'email'),
            password: any(named: 'password'),
            emailRedirectTo: any(named: 'emailRedirectTo'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockSupabaseClient);
        verifyNoMoreInteractions(mockGoTrueClient);
      },
    );

    test(
      'should throw OtherExceptions when other exceptions are thrown',
      () async {
        //arrange
        when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
        when(
          () => mockGoTrueClient.signUp(
            email: any(named: 'email'),
            password: any(named: 'password'),
            emailRedirectTo: any(named: 'emailRedirectTo'),
          ),
        ).thenThrow(Exception('Error'));

        //act
        final call = supabaseAuthService.signUp;

        //assert
        expect(
          () => call(email: tEmail, password: tPassword),
          throwsA(isA<OtherExceptions>()),
        );
        verify(() => mockSupabaseClient.auth).called(1);
        verify(
          () => mockGoTrueClient.signUp(
            email: any(named: 'email'),
            password: any(named: 'password'),
            emailRedirectTo: any(named: 'emailRedirectTo'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockSupabaseClient);
        verifyNoMoreInteractions(mockGoTrueClient);
      },
    );
  });

  group('sendResetPasswordOTP', () {
    test('should successfully reset password.', () async {
      //arrange
      when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
      when(
        () => mockGoTrueClient.resetPasswordForEmail(tEmail),
      ).thenAnswer((_) async {});

      //act
      await supabaseAuthService.sendResetPasswordOTP(email: tEmail);

      //assert
      verify(() => mockSupabaseClient.auth).called(1);
      verify(() => mockGoTrueClient.resetPasswordForEmail(tEmail)).called(1);
      verifyNoMoreInteractions(mockSupabaseClient);
      verifyNoMoreInteractions(mockGoTrueClient);
    });

    test(
      'should throw SupabaseAuthException when Supabase Auth throws AuthException',
      () async {
        //arrange
        when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
        when(
          () => mockGoTrueClient.resetPasswordForEmail(tEmail),
        ).thenThrow(AuthException('Error'));

        //act
        final call = supabaseAuthService.sendResetPasswordOTP;

        //assert
        expect(
          () => call(email: tEmail),
          throwsA(isA<SupabaseAuthException>()),
        );
        verify(() => mockSupabaseClient.auth).called(1);
        verify(() => mockGoTrueClient.resetPasswordForEmail(tEmail)).called(1);
        verifyNoMoreInteractions(mockSupabaseClient);
        verifyNoMoreInteractions(mockGoTrueClient);
      },
    );

    test('should throw OtherExceptions when other exceptions occur', () async {
      //arrange
      when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
      when(
        () => mockGoTrueClient.resetPasswordForEmail(tEmail),
      ).thenThrow(Exception('Error'));

      //act
      final call = supabaseAuthService.sendResetPasswordOTP;

      //assert
      expect(() => call(email: tEmail), throwsA(isA<OtherExceptions>()));
      verify(() => mockSupabaseClient.auth).called(1);
      verify(() => mockGoTrueClient.resetPasswordForEmail(tEmail)).called(1);
      verifyNoMoreInteractions(mockSupabaseClient);
      verifyNoMoreInteractions(mockGoTrueClient);
    });
  });

  group('updatePassword', () {
    test('should successfully updateuser password', () async {
      //arrange
      when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
      when(
        () =>
            mockGoTrueClient.updateUser(UserAttributes(password: tNewPassword)),
      ).thenAnswer((_) async => mockUserResponse);

      //act
      await supabaseAuthService.updatePassword(newPassword: tNewPassword);

      //assert
      verify(() => mockSupabaseClient.auth).called(1);
      verify(
        () =>
            mockGoTrueClient.updateUser(UserAttributes(password: tNewPassword)),
      ).called(1);
      verifyNoMoreInteractions(mockSupabaseClient);
      verifyNoMoreInteractions(mockGoTrueClient);
      verifyNoMoreInteractions(mockUserResponse);
    });

    test(
      'should throw SupabaseAuthException when Supabase Auth throws AuthException',
      () async {
        //arrange
        when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
        when(
          () => mockGoTrueClient.updateUser(
            UserAttributes(password: tNewPassword),
          ),
        ).thenThrow(AuthException('Error'));

        //act
        final call = supabaseAuthService.updatePassword;

        //assert
        expect(
          () => call(newPassword: tNewPassword),
          throwsA(isA<SupabaseAuthException>()),
        );
        verify(() => mockSupabaseClient.auth).called(1);
        verify(
          () => mockGoTrueClient.updateUser(
            UserAttributes(password: tNewPassword),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockSupabaseClient);
        verifyNoMoreInteractions(mockGoTrueClient);
      },
    );

    test('should throw OtherExceptions when other exceptions occur', () async {
      //arrange
      when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
      when(
        () =>
            mockGoTrueClient.updateUser(UserAttributes(password: tNewPassword)),
      ).thenThrow(Exception('Error'));

      //act
      final call = supabaseAuthService.updatePassword;

      //assert
      expect(
        () => call(newPassword: tNewPassword),
        throwsA(isA<OtherExceptions>()),
      );
      verify(() => mockSupabaseClient.auth).called(1);
      verify(
        () =>
            mockGoTrueClient.updateUser(UserAttributes(password: tNewPassword)),
      ).called(1);
      verifyNoMoreInteractions(mockSupabaseClient);
      verifyNoMoreInteractions(mockGoTrueClient);
    });
  });

  group('verifyOTP', () {
    test('should successfully verify the OTP', () async {
      //arrange
      when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
      when(
        () => mockGoTrueClient.verifyOTP(
          type: OtpType.recovery,
          email: tEmail,
          token: tOTPToken,
        ),
      ).thenAnswer((_) async => mockAuthResponse);

      //act
      await supabaseAuthService.verifyOTP(email: tEmail, otp: tOTPToken);

      //assert
      verify(() => mockSupabaseClient.auth).called(1);
      verify(
        () =>
           mockGoTrueClient.verifyOTP(
          type: OtpType.recovery,
          email: tEmail,
          token: tOTPToken,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockSupabaseClient);
      verifyNoMoreInteractions(mockGoTrueClient);
      verifyNoMoreInteractions(mockAuthResponse);
    });

    test(
      'should throw SupabaseAuthException when Supabase Auth throws AuthException',
      () async {
        //arrange
        when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
        when(
          () => mockGoTrueClient.verifyOTP(
          type: OtpType.recovery,
          email: tEmail,
          token: tOTPToken,
        ),
        ).thenThrow(AuthException('Error'));

        //act
        final call = supabaseAuthService.verifyOTP;

        //assert
        expect(
          () => call(email: tEmail, otp: tOTPToken),
          throwsA(isA<SupabaseAuthException>()),
        );
        verify(() => mockSupabaseClient.auth).called(1);
        verify(
          () => mockGoTrueClient.verifyOTP(
          type: OtpType.recovery,
          email: tEmail,
          token: tOTPToken,
        ),
        ).called(1);
        verifyNoMoreInteractions(mockSupabaseClient);
        verifyNoMoreInteractions(mockGoTrueClient);
      },
    );

    test('should throw OtherExceptions when other exceptions occur', () async {
      //arrange
      when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
      when(
        () =>
           mockGoTrueClient.verifyOTP(
          type: OtpType.recovery,
          email: tEmail,
          token: tOTPToken,
        ),
      ).thenThrow(Exception('Error'));

      //act
      final call = supabaseAuthService.verifyOTP;

      //assert
      expect(
        () => call(email: tEmail, otp: tOTPToken),
        throwsA(isA<OtherExceptions>()),
      );
      verify(() => mockSupabaseClient.auth).called(1);
      verify(
        () =>
            mockGoTrueClient.verifyOTP(
          type: OtpType.recovery,
          email: tEmail,
          token: tOTPToken,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockSupabaseClient);
      verifyNoMoreInteractions(mockGoTrueClient);
    });
  });
}
