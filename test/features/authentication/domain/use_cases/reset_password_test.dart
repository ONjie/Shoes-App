import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/reset_password.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late ResetPassword resetPassword;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    resetPassword = ResetPassword(
      authenticationRepository: mockAuthenticationRepository,
    );
  });

  const tEmail = 'user@example.com';
  const tNewPassword = 'newPassword123';
  const tOTPToken = '123456';

  test('should Right(true) when call to ResetPassword returns Right', () async {
    //arrange
    when(
      () => mockAuthenticationRepository.resetPassword(
        email: any(named: 'email'),
        otp: any(named: 'otp'),
        newPassword: any(named: 'newPassword'),
      ),
    ).thenAnswer((_) async => Right(true));

    //act
    final result = await resetPassword.execute(
      email: tEmail,
      otp: tOTPToken,
      newPassword: tNewPassword,
    );

    //assert
    expect(result.right, isA<bool>());
    expect(result, Right(true));
    verify(
      () => mockAuthenticationRepository.resetPassword(
        email: any(named: 'email'),
        otp: any(named: 'otp'),
        newPassword: any(named: 'newPassword'),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockAuthenticationRepository);
  });
}
