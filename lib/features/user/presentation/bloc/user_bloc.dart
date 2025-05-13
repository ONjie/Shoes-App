import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoes_app/core/utils/map_failure_to_message/map_failure_to_message.dart';
import 'package:shoes_app/features/user/domain/entities/user_entity.dart';

import '../../domain/use_cases/fetch_user.dart';
import '../../domain/use_cases/update_profile_picture.dart';
import '../../domain/use_cases/update_username.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FetchUser fetchUser;
  final UpdateProfilePicture updateProfilePicture;
  final UpdateUsername updateUsername;
  UserBloc({
    required this.fetchUser,
    required this.updateProfilePicture,
    required this.updateUsername,
  }) : super(UserState(userStatus: UserStatus.initial)) {
    on<FetchUserEvent>(_onFetchUser);
    on<UpdateProfilePictureEvent>(_onUpdateProfilePicture);
    on<UpdateUsernameEvent>(_onUpdateUsername);
  }

  _onFetchUser(FetchUserEvent event, Emitter<UserState> emit) async {
    emit(UserState(userStatus: UserStatus.loading));

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

  _onUpdateProfilePicture(
    UpdateProfilePictureEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserState(userStatus: UserStatus.loading));

    final isUpdatedOrFailure = await updateProfilePicture.call(
      userId: event.userId,
      newProfilePicture: event.newProfilePicture,
    );

    isUpdatedOrFailure.fold(
      (failure) {
        emit(
          UserState(
            userStatus: UserStatus.updateProfilePictureError,
            errorMessage: mapFailureToMessage(failure: failure),
          ),
        );
      },
      (isUpdated) {
        emit(UserState(userStatus: UserStatus.profilePictureUpdated));
      },
    );
  }

  _onUpdateUsername(UpdateUsernameEvent event, Emitter<UserState> emit) async {
    emit(UserState(userStatus: UserStatus.loading));

    final isUpdatedOrFailure = await updateUsername.call(
      userId: event.userId,
      newUsername: event.newUsername,
    );

    isUpdatedOrFailure.fold(
      (failure) {
        emit(
          UserState(
            userStatus: UserStatus.updateUsernameError,
            errorMessage: mapFailureToMessage(failure: failure),
          ),
        );
      },
      (isUpdated) {
        emit(UserState(userStatus: UserStatus.usernameUpdated));
      },
    );
  }
}
