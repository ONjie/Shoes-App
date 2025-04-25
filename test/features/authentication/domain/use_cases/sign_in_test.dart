import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/sign_in.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {

  late SignIn signIn;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    signIn = SignIn(authenticationRepository: mockAuthenticationRepository);
  });

  const tUserEmail = 'user@example.com';
  const tPassword = 'password123';

  test('should return Right from authentication repository', () async {
    //arrange
    when(
     () =>  mockAuthenticationRepository.signIn(
        email: any(named: 'email'),
        password: any(named:'password'),
      ),
    ).thenAnswer((_) async => const Right(true));

    //act
    final result = await signIn.execute(email: tUserEmail, password: tPassword);

    //assert
    expect(result, equals(const Right(true)));
    verify(
      () => mockAuthenticationRepository.signIn(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockAuthenticationRepository);
  });
}
