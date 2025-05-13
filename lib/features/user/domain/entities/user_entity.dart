import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    this.userId,
    required this.username,
    required this.email,
    required this.profilePicture,
  });

  final String? userId;
  final String username;
  final String email;
  final String profilePicture;

  @override
  List<Object?> get props => [userId, username, email, profilePicture];
}
