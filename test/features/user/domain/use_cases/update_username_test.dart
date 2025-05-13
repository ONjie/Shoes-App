import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/user/domain/repositories/user_repository.dart';
import 'package:shoes_app/features/user/domain/use_cases/update_username.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late UpdateUsername updateUsername;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    updateUsername = UpdateUsername(userRepository: mockUserRepository);
  });

  const tUserId = 'userId';
  const tNewUsername = 'NewUsername';

  test(
    'should return Right(true) when call to UserRepository is successful',
    () async {
      //arrange
      when(
        () => mockUserRepository.updateUsername(
          userId: any(named: 'userId'),
          newUsername: any(named: 'newUsername'),
        ),
      ).thenAnswer((_) async => Right(true));

      //act
      final result = await updateUsername.call(
        userId: tUserId,
        newUsername: tNewUsername,
      );

      //assert
      expect(result, isA<Right<Failure, bool>>());
      expect(result.right, equals(true));
      verify(() => mockUserRepository.updateUsername(
          userId: any(named: 'userId'),
          newUsername: any(named: 'newUsername'),
        ),).called(1);
      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}
