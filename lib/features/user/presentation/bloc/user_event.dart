part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {}

class FetchUserEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}

class UpdateUserProfileEvent extends UserEvent {
  final File? newProfilePicture;
  final String? newUsername;
  final UserEntity user;

  UpdateUserProfileEvent({
    required this.user,
    this.newProfilePicture,
    this.newUsername,
  });

  @override
  List<Object?> get props => [newProfilePicture, newUsername];
}

