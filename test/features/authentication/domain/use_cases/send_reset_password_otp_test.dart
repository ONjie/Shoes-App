import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/send_reset_password_otp.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late SendResetPasswordOTP sendResetPasswordOTP;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    sendResetPasswordOTP = SendResetPasswordOTP(
      authenticationRepository: mockAuthenticationRepository,
    );
  });

  const tEmail = 'user@example.com';

  test('should Right(true) when call to SendResetPasswordOTP returns Right', () async {
    //arrange
    when(
      () => mockAuthenticationRepository.sendResetPasswordOTP(
        email: any(named: 'email'),
      ),
    ).thenAnswer((_) async => Right(true));

    //act
    final result = await sendResetPasswordOTP.execute(email: tEmail);

    //assert
    expect(result.right, isA<bool>());
    expect(result, Right(true));
    verify(
      () => mockAuthenticationRepository.sendResetPasswordOTP(email: tEmail),
    ).called(1);
    verifyNoMoreInteractions(mockAuthenticationRepository);
  });
}
