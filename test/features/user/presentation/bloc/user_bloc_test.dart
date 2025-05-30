import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/user/domain/entities/user_entity.dart';
import 'package:shoes_app/features/user/domain/use_cases/fetch_user.dart';
import 'package:shoes_app/features/user/domain/use_cases/update_user_profile.dart';
import 'package:shoes_app/features/user/presentation/bloc/user_bloc.dart';

class MockFetchUser extends Mock implements FetchUser {}

class MockUpdateUserProfile extends Mock implements UpdateUserProfile {}

void main() {
  late UserBloc userBloc;
  late MockFetchUser mockFetchUser;
  late MockUpdateUserProfile mockUpdateUserProfile;

  setUp(() {
    mockFetchUser = MockFetchUser();
    mockUpdateUserProfile = MockUpdateUserProfile();
    userBloc = UserBloc(
      fetchUser: mockFetchUser,
      updateUserProfile: mockUpdateUserProfile,
    );
  });

  const tUser = UserEntity(
    userId: 'userId',
    username: 'username',
    email: 'email',
    profilePicture: 'profilePicture',
  );

  final tNewProfilePicture = File('new_profile_picture.jpeg');
  const tNewUsername = 'newUsername';

  group('_onFetchUser', () {
    blocTest(
      'should emit [UserStatus.fetchUserError] when call is unsuccessful',
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
            UserState(
              userStatus: UserStatus.fetchUserError,
              errorMessage: 'Failed to fetch user',
            ),
          ],
    );

    blocTest(
      'should emit [UserStatus.userFetched] when call is successful',
      setUp: () {
        when(() => mockFetchUser.call()).thenAnswer((_) async => Right(tUser));
      },
      build: () => userBloc,
      act: (bloc) => bloc.add(FetchUserEvent()),
      expect:
          () => [
            UserState(userStatus: UserStatus.userFetched, user: tUser),
          ],
    );
  });

  group('_onUpdateUserProfile', () {
    blocTest(
      'should emit [UserStatus.loading, UserStatus.updateUserProfileError] when call is unsuccessful',
      setUp: () {
        when(
          () => mockUpdateUserProfile(
            user: tUser,
            newUsername: tNewUsername,
            newProfilePicture: tNewProfilePicture,
          ),
        ).thenAnswer(
          (_) async => Left(
            SupabaseDatabaseFailure(message: 'Failed to update user profile'),
          ),
        );
      },
      build: () => userBloc,
      act:
          (bloc) => bloc.add(
            UpdateUserProfileEvent(
              user: tUser,
              newUsername: tNewUsername,
              newProfilePicture: tNewProfilePicture,
            ),
          ),
      expect:
          () => [
            UserState(userStatus: UserStatus.loading),
            UserState(
              userStatus: UserStatus.updateUserProfileError,
              errorMessage: 'Failed to update user profile',
            ),
          ],
    );

    blocTest(
      'should emit [UserStatus.loading, UserStatus.userProfileUpdated] when call is successful',
      setUp: () {
        when(
          () => mockUpdateUserProfile(
            user: tUser,
            newUsername: tNewUsername,
            newProfilePicture: tNewProfilePicture,
          ),
        ).thenAnswer((_) async => Right(true));
      },
      build: () => userBloc,
      act:
          (bloc) => bloc.add(
            UpdateUserProfileEvent(
              user: tUser,
              newUsername: tNewUsername,
              newProfilePicture: tNewProfilePicture,
            ),
          ),
      expect:
          () => [
            UserState(userStatus: UserStatus.loading),
            UserState(userStatus: UserStatus.userProfileUpdated),
          ],
    );
  });
}
