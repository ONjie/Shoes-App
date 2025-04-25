import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/sign_up.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late MockAuthenticationRepository mockAuthenticationRepository;
  late SignUp signUp;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    signUp = SignUp(authenticationRepository: mockAuthenticationRepository);
  });

  const tUsername = 'user';
  const tEmail = 'user@example.com';
  const tPassword = 'password123';

  test('should return Right from authentication repository', () async {
    //arrange
    when(
      () => mockAuthenticationRepository.signUp(
        username: any(named: 'username'),
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Right(true));

    //act
    final result = await signUp.execute(
      username: tUsername,
      email: tEmail,
      password: tPassword,
    );

    //assert
    expect(result, const Right(true));
    verify(
      () => mockAuthenticationRepository.signUp(
        username: any(named: 'username'),
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockAuthenticationRepository);
  });
}
