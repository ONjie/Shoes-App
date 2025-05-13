import 'dart:io';
import 'package:either_dart/either.dart';
import '../../../../core/core.dart';
import '../entities/user_entity.dart';

typedef EitherFailureOrBool = Either<Failure, bool>;

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> fetchUser();
  Future<EitherFailureOrBool> updateUsername({required String userId, required String newUsername});
  Future<EitherFailureOrBool> updateProfilePicture({
    required String userId,
    required File newProfilePicture,
  });
}
