import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/user/domain/entities/user_entity.dart';
import 'package:shoes_app/features/user/domain/repositories/user_repository.dart';
import 'package:shoes_app/features/user/domain/use_cases/fetch_user.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late FetchUser fetchUser;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    fetchUser = FetchUser(userRepository: mockUserRepository);
  });

  final tUser = UserEntity(
    userId: 'userId',
    username: 'username',
    email: 'email',
    profilePicture: 'profilePicture',
  );

  test(
    'should return Right(UserEntity) when call to UserRepository is successful',
    () async {
      //arrange
      when(
        () => mockUserRepository.fetchUser(),
      ).thenAnswer((_) async => Right(tUser));

      //act
      final result = await fetchUser.call();

      //assert
      expect(result, isA<Right<Failure, UserEntity>>());
      expect(result.right, equals(tUser));
      verify(() => mockUserRepository.fetchUser()).called(1);
      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}
