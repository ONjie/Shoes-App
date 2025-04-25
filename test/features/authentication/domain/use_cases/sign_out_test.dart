import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/sign_out.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main(){

  late SignOut signOut;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    signOut = SignOut(authenticationRepository: mockAuthenticationRepository);
  });


  test('should return Right from authentication repository', () async {

    //arrange
     when(() => mockAuthenticationRepository.signOut())
        .thenAnswer((_) async => const Right(true));

    //act
    final result = await signOut.execute();


    //assert
    expect(result, equals(const Right(true)));
    verify(() => mockAuthenticationRepository.signOut()).called(1);
    verifyNoMoreInteractions(mockAuthenticationRepository);

  });

}