import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shoes_app/features/user/domain/entities/user_entity.dart';

part 'user_model.g.dart';

typedef MapJson = Map<String, dynamic>;

@JsonSerializable()
class UserModel extends Equatable {
  const UserModel({
    this.userId,
    required this.username,
    required this.email,
    required this.profilePicture,
  });

  final String? userId;
  final String username;
  final String email;
  final String profilePicture;

  static UserModel fromJson(MapJson json) => _$UserModelFromJson(json);

  MapJson toJson() => _$UserModelToJson(this);

  UserEntity toUserEntity() => UserEntity(
    userId: userId,
    username: username,
    email: email,
    profilePicture: profilePicture,
  );

  @override
  List<Object?> get props => [userId, username, email, profilePicture];
}
