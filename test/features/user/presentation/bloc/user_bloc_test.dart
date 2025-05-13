import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/user/domain/entities/user_entity.dart';
import 'package:shoes_app/features/user/domain/use_cases/fetch_user.dart';
import 'package:shoes_app/features/user/domain/use_cases/update_profile_picture.dart';
import 'package:shoes_app/features/user/domain/use_cases/update_username.dart';
import 'package:shoes_app/features/user/presentation/bloc/user_bloc.dart';

class MockFetchUser extends Mock implements FetchUser {}

class MockUpdateProfilePicture extends Mock implements UpdateProfilePicture {}

class MockUpdateUsername extends Mock implements UpdateUsername {}

void main() {
  late UserBloc userBloc;
  late MockFetchUser mockFetchUser;
  late MockUpdateProfilePicture mockUpdateProfilePicture;
  late MockUpdateUsername mockUpdateUsername;

  setUp(() {
    mockFetchUser = MockFetchUser();
    mockUpdateProfilePicture = MockUpdateProfilePicture();
    mockUpdateUsername = MockUpdateUsername();

    userBloc = UserBloc(
      fetchUser: mockFetchUser,
      updateProfilePicture: mockUpdateProfilePicture,
      updateUsername: mockUpdateUsername,
    );
  });

  const tUser = UserEntity(
    userId: 'userId',
    username: 'username',
    email: 'email',
    profilePicture: 'profilePicture',
  );

  group('_onFetchUser', () {
    blocTest(
      'should emit [UserStatus.loading, UserStatus.fetchUserError] when call is unsuccessful',
      setUp: () {
        when(() => mockFetchUser.call()).thenAnswer(
          (_) async =>
              Left(SupabaseDatabaseFailure(message: 'Failed to fetch user')),
        );
      },
      build: () => userBloc,
      act: (bloc) => bloc.add(FetchUserEvent()),
      expect:
          () => [
            UserState(userStatus: UserStatus.loading),
            UserState(
              userStatus: UserStatus.fetchUserError,
              errorMessage: 'Failed to fetch user',
            ),
          ],
    );

    blocTest(
      'should emit [UserStatus.loading, UserStatus.userFetched] when call is successful',
      setUp: () {
        when(() => mockFetchUser.call()).thenAnswer((_) async => Right(tUser));
      },
      build: () => userBloc,
      act: (bloc) => bloc.add(FetchUserEvent()),
      expect:
          () => [
            UserState(userStatus: UserStatus.loading),
            UserState(userStatus: UserStatus.userFetched, user: tUser),
          ],
    );
  });

  group('_onUpdateProfilePicture', () {
    final tNewProfilePicture = File('newProfilePicture');
    blocTest(
      'should emit [UserStatus.loading, UserStatus.updateProfilePictureError] when call is unsuccessful',
      setUp: () {
        when(
          () => mockUpdateProfilePicture.call(
            userId: tUser.userId!,
            newProfilePicture: tNewProfilePicture,
          ),
        ).thenAnswer(
          (_) async => Left(
            SupabaseDatabaseFailure(
              message: 'Failed to update profile picture',
            ),
          ),
        );
      },
      build: () => userBloc,
      act:
          (bloc) => bloc.add(
            UpdateProfilePictureEvent(
              newProfilePicture: tNewProfilePicture,
              userId: tUser.userId!,
            ),
          ),
      expect:
          () => [
            UserState(userStatus: UserStatus.loading),
            UserState(
              userStatus: UserStatus.updateProfilePictureError,
              errorMessage: 'Failed to update profile picture',
            ),
          ],
    );

    blocTest(
      'should emit [UserStatus.loading, UserStatus.profilePictureUpdated] when call is successful',
      setUp: () {
        when(
          () => mockUpdateProfilePicture.call(
            userId: tUser.userId!,
            newProfilePicture: tNewProfilePicture,
          ),
        ).thenAnswer((_) async => Right(true));
      },
      build: () => userBloc,
      act:
          (bloc) => bloc.add(
            UpdateProfilePictureEvent(
              newProfilePicture: tNewProfilePicture,
              userId: tUser.userId!,
            ),
          ),
      expect:
          () => [
            UserState(userStatus: UserStatus.loading),
            UserState(userStatus: UserStatus.profilePictureUpdated),
          ],
    );
  });

  group('_onUpdateUsername', () {
    const tNewUsername = 'newUsername';
    blocTest(
      'should emit [UserStatus.loading, UserStatus.updateUsernameError] when call is unsuccessful',
      setUp: () {
        when(
          () => mockUpdateUsername.call(
            userId: tUser.userId!,
            newUsername: tNewUsername,
          ),
        ).thenAnswer(
          (_) async => Left(
            SupabaseDatabaseFailure(message: 'Failed to update username'),
          ),
        );
      },
      build: () => userBloc,
      act:
          (bloc) => bloc.add(
            UpdateUsernameEvent(
              newUsername: tNewUsername,
              userId: tUser.userId!,
            ),
          ),
      expect:
          () => [
            UserState(userStatus: UserStatus.loading),
            UserState(
              userStatus: UserStatus.updateUsernameError,
              errorMessage: 'Failed to update username',
            ),
          ],
    );

    blocTest(
      'should emit [UserStatus.loading, UserStatus.usernameUpdated] when call is successful',
      setUp: () {
        when(
          () => mockUpdateUsername.call(
            userId: tUser.userId!,
            newUsername: tNewUsername,
          ),
        ).thenAnswer((_) async => Right(true));
      },
      build: () => userBloc,
      act:
          (bloc) => bloc.add(
            UpdateUsernameEvent(
              newUsername: tNewUsername,
              userId: tUser.userId!,
            ),
          ),
      expect:
          () => [
            UserState(userStatus: UserStatus.loading),
            UserState(userStatus: UserStatus.usernameUpdated),
          ],
    );
  });
}
