// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  userId: json['userId'] as String?,
  username: json['username'] as String,
  email: json['email'] as String,
  profilePicture: json['profilePicture'] as String,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'userId': instance.userId,
  'username': instance.username,
  'email': instance.email,
  'profilePicture': instance.profilePicture,
};
