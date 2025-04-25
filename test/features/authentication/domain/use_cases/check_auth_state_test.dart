import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/check_auth_state.dart';


class MockAuthenticationRepository extends Mock implements AuthenticationRepository{}
void main() {
  late CheckAuthState authState;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    authState = CheckAuthState(
      authenticationRepository: mockAuthenticationRepository,
    );
  });


  test('should return Right from authentication repository', () async {
    //arrange
    when(
      () => mockAuthenticationRepository.checkAuthState(),
    ).thenAnswer((_) async => const Right(true));

    //act
    final result = await authState.execute();

    //assert
    expect(result, equals(const Right(true)));
    verify(() => mockAuthenticationRepository.checkAuthState()).called(1);
    verifyNoMoreInteractions(mockAuthenticationRepository);
  });
}
