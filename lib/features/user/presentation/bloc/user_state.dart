part of 'user_bloc.dart';

enum UserStatus {
  initial,
  loading,
  userFetched,
  fetchUserError,
  userProfileUpdated,
  updateUserProfileError,
}

class UserState extends Equatable {
  final UserStatus userStatus;
  final UserEntity? user;
  final String? errorMessage;

  const UserState({required this.userStatus, this.user, this.errorMessage});

  @override
  List<Object?> get props => [userStatus, user, errorMessage];
}
