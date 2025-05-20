import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/user/domain/entities/user_entity.dart';
import 'package:shoes_app/features/user/domain/repositories/user_repository.dart';
import 'package:shoes_app/features/user/domain/use_cases/update_user_profile.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late UpdateUserProfile updateUserProfile;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    updateUserProfile = UpdateUserProfile(userRepository: mockUserRepository);
  });

  const tUser = UserEntity(
    userId: 'userId',
    username: 'username',
    email: 'email',
    profilePicture: 'profilePicture',
  );

  final tNewProfilePicture = File('newProfilePicture.jpeg');

  const tNewUsername = 'newUsername';

  test(
    'should return Right(true) from UserRepository when call i successful',
    () async {
      //arrange
      when(
        () => mockUserRepository.updateUserProfile(
          user: tUser,
          newUsername: tNewUsername,
          newProfilePicture: tNewProfilePicture,
        ),
      ).thenAnswer((_) async => Right(true));

      //act
      final result = await updateUserProfile.call(
        user: tUser,
        newUsername: tNewUsername,
        newProfilePicture: tNewProfilePicture,
      );

      //assert
      expect(result, isA<Right<Failure, bool>>());
      expect(result.right, equals(true));
      verify(
        () => mockUserRepository.updateUserProfile(
          user: tUser,
          newUsername: tNewUsername,
          newProfilePicture: tNewProfilePicture,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}
