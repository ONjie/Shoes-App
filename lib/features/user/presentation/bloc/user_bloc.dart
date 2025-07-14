import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoes_app/core/utils/map_failure_to_message/map_failure_to_message.dart';
import 'package:shoes_app/features/user/domain/entities/user_entity.dart';
import 'package:shoes_app/features/user/domain/use_cases/update_user_profile.dart';

import '../../domain/use_cases/fetch_user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FetchUser fetchUser;
  final UpdateUserProfile updateUserProfile;
  UserBloc({required this.fetchUser, required this.updateUserProfile})
    : super(UserState(userStatus: UserStatus.initial)) {
    on<FetchUserEvent>(_onFetchUser);
    on<UpdateUserProfileEvent>(_onUpdateUserProfile);
  }

  _onFetchUser(FetchUserEvent event, Emitter<UserState> emit) async {

    emit(
          UserState(
            userStatus: UserStatus.loading
          ),
        );

    final userOrFailure = await fetchUser.call();

    userOrFailure.fold(
      (failure) {
        emit(
          UserState(
            userStatus: UserStatus.fetchUserError,
            errorMessage: mapFailureToMessage(failure: failure),
          ),
        );
      },
      (user) {
        emit(UserState(userStatus: UserStatus.userFetched, user: user));
      },
    );
  }

  _onUpdateUserProfile(
    UpdateUserProfileEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserState(userStatus: UserStatus.loading));

    final isUpdatedOrFailure = await updateUserProfile.call(
      user: event.user,
      newUsername: event.newUsername,
      newProfilePicture: event.newProfilePicture,
    );

    isUpdatedOrFailure.fold(
      (failure) {
        emit(
          UserState(
            userStatus: UserStatus.updateUserProfileError,
            errorMessage: mapFailureToMessage(failure: failure),
          ),
        );
      },
      (isUpdated) {
        emit(UserState(userStatus: UserStatus.userProfileUpdated));
      },
    );
  }
}
