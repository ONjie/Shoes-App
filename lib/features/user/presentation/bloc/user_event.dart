part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {}

class FetchUserEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}

class UpdateProfilePictureEvent extends UserEvent {
  final File newProfilePicture;
  final String userId;

  UpdateProfilePictureEvent({
    required this.newProfilePicture,
    required this.userId,
  });

  @override
  List<Object?> get props => [newProfilePicture, userId];
}

class UpdateUsernameEvent extends UserEvent {
  final String newUsername;
  final String userId;

  UpdateUsernameEvent({required this.newUsername, required this.userId});

  @override
  List<Object?> get props => [newUsername, userId];
}
