import 'dart:io';
import 'package:either_dart/either.dart';
import '../../../../core/core.dart';
import '../repositories/user_repository.dart';

class UpdateProfilePicture {
  UpdateProfilePicture({required this.userRepository});

  final UserRepository userRepository;

  Future<Either<Failure, bool>> call({
    required String userId,
    required File newProfilePicture,
  }) async => await userRepository.updateProfilePicture(
    userId: userId,
    newProfilePicture: newProfilePicture,
  );
}
