import 'package:equatable/equatable.dart';
import 'package:shoes_app/features/user/domain/entities/user_entity.dart';

typedef MapJson = Map<String, dynamic>;

class UserModel extends Equatable {
  const UserModel({
    this.userId,
    required this.username,
    required this.email,
    required this.profilePicture,
    required this.updatedAt
  });

  final String? userId;
  final String username;
  final String email;
  final String profilePicture;
  final DateTime updatedAt;

  static UserModel fromJson(MapJson json) => UserModel(
    userId: json['id'] as String?,
    username: json['username'] as String,
    email: json['email'] as String,
    profilePicture: json['profile_picture'] as String,
    updatedAt: DateTime.parse(json['updated_at'])
  );

  MapJson toJson() => {
    'id': userId,
    'username': username,
    'email': email,
    'profile_picture': profilePicture,
    'updated_at': updatedAt.toString(),
  };

  UserEntity toUserEntity() => UserEntity(
    userId: userId,
    username: username,
    email: email,
    profilePicture: profilePicture,
  );

  @override
  List<Object?> get props => [userId, username, email, profilePicture];
}
