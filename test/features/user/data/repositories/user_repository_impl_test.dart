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

  const tUser = UserModel(
    userId: 'userId',
    username: 'username',
    email: 'email',
    profilePicture: 'profilePicture',
  );

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
        ).thenAnswer((_) async => tUser);

        //act
        final result = await userRepositoryImpl.fetchUser();

        //assert
        expect(result, isA<Right<Failure, UserEntity>>());
        expect(result.right, equals(tUser.toUserEntity()));
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

  group('updateProfilePicture', () {
    final tNewProfilePicture = File('new_profile_picture.jpeg');
    const tUploadedImageUrl = 'uploadedImageUrl';
    test('checks if the device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      userRepositoryImpl.updateProfilePicture(
        userId: tUser.userId!,
        newProfilePicture: tNewProfilePicture,
      );

      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    runOfflineTest(() {
      test(
        'should return left(InternetConnectionFailure) when device is offline',
        () async {
          //act
          final result = await userRepositoryImpl.updateProfilePicture(
            userId: tUser.userId!,
            newProfilePicture: tNewProfilePicture,
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
      test('should return Right(true) when call is successful', () async {
        //arrange
        when(
          () => mockUserRemoteDatabaseService.uploadImageToStorage(
            image: tNewProfilePicture,
          ),
        ).thenAnswer((_) async => tUploadedImageUrl);

        when(
          () => mockUserRemoteDatabaseService.updateProfilePicture(
            userId: tUser.userId!,
            newProfilePicture: tUploadedImageUrl,
          ),
        ).thenAnswer((_) async => true);

        //act
        final result = await userRepositoryImpl.updateProfilePicture(
          userId: tUser.userId!,
          newProfilePicture: tNewProfilePicture,
        );

        //assert
        expect(result, isA<Right<Failure, bool>>());
        expect(result.right, equals(true));
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(
          () => mockUserRemoteDatabaseService.uploadImageToStorage(
            image: tNewProfilePicture,
          ),
        ).called(1);
        verify(
          () => mockUserRemoteDatabaseService.updateProfilePicture(
            userId: tUser.userId!,
            newProfilePicture: tUploadedImageUrl,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockUserRemoteDatabaseService);
      });

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
          final result = await userRepositoryImpl.updateProfilePicture(
            userId: tUser.userId!,
            newProfilePicture: tNewProfilePicture,
          );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(SupabaseStorageFailure(message: 'Failed to upload image')),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () => mockUserRemoteDatabaseService.uploadImageToStorage(
              image: tNewProfilePicture,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
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

          when(
            () => mockUserRemoteDatabaseService.updateProfilePicture(
              userId: tUser.userId!,
              newProfilePicture: tUploadedImageUrl,
            ),
          ).thenThrow(
            SupabaseDatabaseException(
              message: 'Failed to update profile picture',
            ),
          );

          //act
          final result = await userRepositoryImpl.updateProfilePicture(
            userId: tUser.userId!,
            newProfilePicture: tNewProfilePicture,
          );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(
              SupabaseDatabaseFailure(
                message: 'Failed to update profile picture',
              ),
            ),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () => mockUserRemoteDatabaseService.uploadImageToStorage(
              image: tNewProfilePicture,
            ),
          ).called(1);
          verify(
            () => mockUserRemoteDatabaseService.updateProfilePicture(
              userId: tUser.userId!,
              newProfilePicture: tUploadedImageUrl,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
          verifyNoMoreInteractions(mockUserRemoteDatabaseService);
        },
      );

      test(
        'should return Left(OtherFailure) when OtherExceptions is thrown',
        () async {
          //arrange
          when(
            () => mockUserRemoteDatabaseService.uploadImageToStorage(
              image: tNewProfilePicture,
            ),
          ).thenThrow(OtherExceptions(message: 'Error'));

          //act
          final result = await userRepositoryImpl.updateProfilePicture(
            userId: tUser.userId!,
            newProfilePicture: tNewProfilePicture,
          );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(result.left, equals(OtherFailure(message: 'Error')));
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () => mockUserRemoteDatabaseService.uploadImageToStorage(
              image: tNewProfilePicture,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
          verifyNoMoreInteractions(mockUserRemoteDatabaseService);
        },
      );
    });
  });

  group('updateUsername', () {
    const tNewUsername = 'newUsername';
    test('checks if the device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      userRepositoryImpl.updateUsername(
        userId: tUser.userId!,
        newUsername: tNewUsername,
      );

      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    runOfflineTest(() {
      test(
        'should return left(InternetConnectionFailure) when device is offline',
        () async {
          //act
          final result = await userRepositoryImpl.updateUsername(
            userId: tUser.userId!,
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
      test('should return Right(true) when call is successful', () async {
        //arrange
        when(
          () => mockUserRemoteDatabaseService.updateUsername(
            userId: any(named: 'userId'),
            newUsername: any(named: 'newUsername'),
          ),
        ).thenAnswer((_) async => true);

        //act
        final result = await userRepositoryImpl.updateUsername(
          userId: tUser.userId!,
          newUsername: tNewUsername,
        );

        //assert
        expect(result, isA<Right<Failure, bool>>());
        expect(result.right, equals(true));
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(
          () => mockUserRemoteDatabaseService.updateUsername(
            userId: any(named: 'userId'),
            newUsername: any(named: 'newUsername'),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockUserRemoteDatabaseService);
      });

      test(
        'should return Left(SupabaseDatabaseFailure) when SupabaseDatabaseException is thrown',
        () async {
          //arrange
          when(
            () => mockUserRemoteDatabaseService.updateUsername(
              userId: any(named: 'userId'),
              newUsername: any(named: 'newUsername'),
            ),
          ).thenThrow(
            SupabaseDatabaseException(message: 'Failed to update username'),
          );

          //act
          final result = await userRepositoryImpl.updateUsername(
          userId: tUser.userId!,
          newUsername: tNewUsername,
        );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(
              SupabaseDatabaseFailure(message: 'Failed to update username'),
            ),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () => mockUserRemoteDatabaseService.updateUsername(
              userId: any(named: 'userId'),
              newUsername: any(named: 'newUsername'),
            ),
          ).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
          verifyNoMoreInteractions(mockUserRemoteDatabaseService);
        },
      );
    });
  });
}
