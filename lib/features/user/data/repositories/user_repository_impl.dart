import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/user/data/data_sources/remote_data/user_remote_database_service.dart';

import 'package:shoes_app/features/user/domain/entities/user_entity.dart';

import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({
    required this.networkInfo,
    required this.userRemoteDatabaseService,
  });

  final NetworkInfo networkInfo;

  final UserRemoteDatabaseService userRemoteDatabaseService;

  
  @override
  Future<Either<Failure, UserEntity>> fetchUser() async {
    if (!await networkInfo.isConnected) {
      return Left(
        InternetConnectionFailure(message: noInternetConnectionMessage),
      );
    }

    try {
      final result = await userRemoteDatabaseService.fetchUser();

      return Right(result.toUserEntity());
    } on SupabaseDatabaseException catch (e) {
      return Left(SupabaseDatabaseFailure(message: e.message));
    }
  }

  @override
  Future<EitherFailureOrBool> updateProfilePicture({
    required String userId,
    required File newProfilePicture,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(
        InternetConnectionFailure(message: noInternetConnectionMessage),
      );
    }

    try {
      final uploadedImageUrl = await userRemoteDatabaseService
          .uploadImageToStorage(image: newProfilePicture);

      final result = await userRemoteDatabaseService.updateProfilePicture(
        userId: userId,
        newProfilePicture: uploadedImageUrl,
      );

      return Right(result);
    } on SupabaseStorageException catch (e) {
      return Left(SupabaseStorageFailure(message: e.message));
    } on SupabaseDatabaseException catch (e) {
      return Left(SupabaseDatabaseFailure(message: e.message));
    } on OtherExceptions catch (e) {
      return Left(OtherFailure(message: e.message));
    }
  }

  @override
  Future<EitherFailureOrBool> updateUsername({
    required String userId,
    required String newUsername,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(
        InternetConnectionFailure(message: noInternetConnectionMessage),
      );
    }

    try {
      final result = await userRemoteDatabaseService.updateUsername(
        userId: userId,
        newUsername: newUsername,
      );

      return Right(result);
    } on SupabaseDatabaseException catch (e) {
      return Left(SupabaseDatabaseFailure(message: e.message));
    }
  }
}
