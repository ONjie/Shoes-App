import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/user/domain/repositories/user_repository.dart';
import 'package:shoes_app/features/user/domain/use_cases/update_profile_picture.dart';


class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late UpdateProfilePicture updateProfilePicture;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    updateProfilePicture = UpdateProfilePicture(
      userRepository: mockUserRepository,
    );
  });

  const tUserId = 'userId';
  final tNewProfilePicture = File('newProfilePicture');

  test(
    'should return Right(true) when call to UserRepository is successful',
    () async {
      //arrange
      when(
        () => mockUserRepository.updateProfilePicture(
          userId: any(named: 'userId'),
          newProfilePicture: tNewProfilePicture,
        ),
      ).thenAnswer((_) async => Right(true));

      //act
      final result = await updateProfilePicture.call(
        userId: tUserId,
        newProfilePicture: tNewProfilePicture,
      );

      //assert
      expect(result, isA<Right<Failure, bool>>());
      expect(result.right, equals(true));
      verify(
        () => mockUserRepository.updateProfilePicture(
          userId: any(named: 'userId'),
          newProfilePicture: tNewProfilePicture,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}
