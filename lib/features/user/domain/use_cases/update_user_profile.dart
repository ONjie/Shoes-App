import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:shoes_app/features/user/domain/repositories/user_repository.dart';

import '../../../../core/core.dart';
import '../entities/user_entity.dart';

class UpdateUserProfile {
  final UserRepository userRepository;

  UpdateUserProfile({required this.userRepository});

  Future<Either<Failure, bool>> call({
    required UserEntity user,
     String? newUsername,
     File? newProfilePicture,
  }) async => await userRepository.updateUserProfile(
    user: user,
    newUsername: newUsername,
    newProfilePicture: newProfilePicture,
  );
}
