import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/user/data/data_sources/remote_data/user_remote_database_service.dart';
import 'package:shoes_app/features/user/data/models/user_model.dart';
import 'package:shoes_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:shoes_app/features/user/domain/entities/user_entity.dart';

class MockUserRemoteDatabaseService extends Mock
    implements UserRemoteDatabaseService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late UserRepositoryImpl userRepositoryImpl;
  late MockNetworkInfo mockNetworkInfo;
  late MockUserRemoteDatabaseService mockUserRemoteDatabaseService;

  setUp(() {
    mockUserRemoteDatabaseService = MockUserRemoteDatabaseService();
    mockNetworkInfo = MockNetworkInfo();

    userRepositoryImpl = UserRepositoryImpl(
      networkInfo: mockNetworkInfo,
      userRemoteDatabaseService: mockUserRemoteDatabaseService,
    );
  });

  void runOnlineTest(Function body) {
    group('when device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runOfflineTest(Function body) {
    group('when device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  final tUserModel = UserModel(
    userId: 'userId',
    username: 'username',
    email: 'email',
    profilePicture: 'profilePicture',
    updatedAt: DateTime.now(),
  );

  const tUserEntity = UserEntity(
    userId: 'userId',
    username: 'username',
    email: 'email',
    profilePicture: 'profilePicture',
  );

  const tNewUsername = 'newUsername';

  group('fetchUser', () {
    test('checks if the device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      userRepositoryImpl.fetchUser();

      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    runOfflineTest(() {
      test(
        'should return left(InternetConnectionFailure) when device is offline',
        () async {
          //act
          final result = await userRepositoryImpl.fetchUser();

          //assert
          expect(result, isA<Left<Failure, UserEntity>>());
          expect(
            result.left,
            equals(
              InternetConnectionFailure(message: noInternetConnectionMessage),
            ),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });

    runOnlineTest(() {
      test('should return Right(UserEntity) when call is successful', () async {
        //arrange
        when(
          () => mockUserRemoteDatabaseService.fetchUser(),
        ).thenAnswer((_) async => tUserModel);

        //act
        final result = await userRepositoryImpl.fetchUser();

        //assert
        expect(result, isA<Right<Failure, UserEntity>>());
        expect(result.right, equals(tUserModel.toUserEntity()));
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(() => mockUserRemoteDatabaseService.fetchUser()).called(1);
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockUserRemoteDatabaseService);
      });

      test(
        'should return Left(SupabaseDatabaseFailure) when SupabaseDatabaseException is thrown',
        () async {
          //arrange
          when(() => mockUserRemoteDatabaseService.fetchUser()).thenThrow(
            SupabaseDatabaseException(message: 'Failed to fetch user'),
          );

          //act
          final result = await userRepositoryImpl.fetchUser();

          //assert
          expect(result, isA<Left<Failure, UserEntity>>());
          expect(
            result.left,
            equals(SupabaseDatabaseFailure(message: 'Failed to fetch user')),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(() => mockUserRemoteDatabaseService.fetchUser()).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
          verifyNoMoreInteractions(mockUserRemoteDatabaseService);
        },
      );
    });
  });

  group('updateUserProfile', () {
    final tNewProfilePicture = File('new_profile_picture.jpeg');
    const tUploadedImageUrl = 'uploadedImageUrl';
    test('checks if the device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      userRepositoryImpl.updateUserProfile(
        user: tUserEntity,
        newProfilePicture: tNewProfilePicture,
        newUsername: tNewUsername,
      );

      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    runOfflineTest(() {
      test(
        'should return left(InternetConnectionFailure) when device is offline',
        () async {
          //act
          final result = await userRepositoryImpl.updateUserProfile(
            user: tUserEntity,
            newProfilePicture: tNewProfilePicture,
            newUsername: tNewUsername,
          );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(
              InternetConnectionFailure(message: noInternetConnectionMessage),
            ),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });

    runOnlineTest(() {
      test(
        'should return Left(InvalidUpdateFailure) when both newUsername and newProfilePicture are not provided',
        () async {
          //act
          final result = await userRepositoryImpl.updateUserProfile(
            user: tUserEntity,
            newProfilePicture: null,
            newUsername: null,
          );

          // assert
          expect(
            result.left,
            equals(InvalidUpdateFailure(message: 'No fields to update')),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );

      test(
        'should return Right(true) when both newProfilePicture and newUsername are provided',
        () async {
          //arrange
          when(
            () => mockUserRemoteDatabaseService.uploadImageToStorage(
              image: tNewProfilePicture,
            ),
          ).thenAnswer((_) async => tUploadedImageUrl);

          final expectedUserModel = UserModel(
            userId: tUserEntity.userId!,
            username: tNewUsername,
            email: tUserEntity.email,
            profilePicture: tUploadedImageUrl,
            updatedAt: DateTime.now(),
          );

          when(
            () => mockUserRemoteDatabaseService.updateUserProfile(
              user: expectedUserModel,
            ),
          ).thenAnswer((_) async => true);

          final result = await userRepositoryImpl.updateUserProfile(
            user: tUserEntity,
            newProfilePicture: tNewProfilePicture,
            newUsername: tNewUsername,
          );

          // assert
          expect(result, isA<Right<Failure, bool>>());
          expect(result.right, equals(true));
          verify(
            () => mockUserRemoteDatabaseService.uploadImageToStorage(
              image: tNewProfilePicture,
            ),
          ).called(1);
          verify(
            () => mockUserRemoteDatabaseService.updateUserProfile(
              user: expectedUserModel,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockUserRemoteDatabaseService);
        },
      );

      test(
        'should return Left(SupabaseStorageFailure) when SupabaseStorageException is thrown',
        () async {
          //arrange
          when(
            () => mockUserRemoteDatabaseService.uploadImageToStorage(
              image: tNewProfilePicture,
            ),
          ).thenThrow(
            SupabaseStorageException(message: 'Failed to upload image'),
          );

          //act
          final result = await userRepositoryImpl.updateUserProfile(
            user: tUserEntity,
            newProfilePicture: tNewProfilePicture,
            newUsername: tNewUsername,
          );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(SupabaseStorageFailure(message: 'Failed to upload image')),
          );
          verify(
            () => mockUserRemoteDatabaseService.uploadImageToStorage(
              image: tNewProfilePicture,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockUserRemoteDatabaseService);
        },
      );

      test(
        'should return Left(SupabaseDatabaseFailure) when SupabaseDatabaseException is thrown',
        () async {
          //arrange
          when(
            () => mockUserRemoteDatabaseService.uploadImageToStorage(
              image: tNewProfilePicture,
            ),
          ).thenAnswer((_) async => tUploadedImageUrl);

          final expectedUserModel = UserModel(
            userId: tUserEntity.userId!,
            username: tNewUsername,
            email: tUserEntity.email,
            profilePicture: tUploadedImageUrl,
            updatedAt: DateTime.now(),
          );

          when(
            () => mockUserRemoteDatabaseService.updateUserProfile(
              user: expectedUserModel,
            ),
          ).thenThrow(
            SupabaseDatabaseException(message: 'Failed to update user profile'),
          );

          //act
          final result = await userRepositoryImpl.updateUserProfile(
            user: tUserEntity,
            newProfilePicture: tNewProfilePicture,
            newUsername: tNewUsername,
          );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(
              SupabaseDatabaseFailure(message: 'Failed to update user profile'),
            ),
          );
          verify(
            () => mockUserRemoteDatabaseService.uploadImageToStorage(
              image: tNewProfilePicture,
            ),
          ).called(1);
          verify(
            () => mockUserRemoteDatabaseService.updateUserProfile(
              user: expectedUserModel,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockUserRemoteDatabaseService);
        },
      );

      test('should return Left(OtherFailure) when OtherExceptions is thrown', () async {
        when(
            () => mockUserRemoteDatabaseService.uploadImageToStorage(
              image: tNewProfilePicture,
            ),
          ).thenThrow(
            OtherExceptions(message: 'Error'),
          );

          //act
          final result = await userRepositoryImpl.updateUserProfile(
            user: tUserEntity,
            newProfilePicture: tNewProfilePicture,
            newUsername: tNewUsername,
          );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(OtherFailure(message: 'Error')),
          );
          verify(
            () => mockUserRemoteDatabaseService.uploadImageToStorage(
              image: tNewProfilePicture,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockUserRemoteDatabaseService);
      });
    });
  });
}
