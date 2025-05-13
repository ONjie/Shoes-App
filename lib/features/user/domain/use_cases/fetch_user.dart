import 'package:either_dart/either.dart';
import 'package:shoes_app/features/user/domain/repositories/user_repository.dart';

import '../../../../core/core.dart';
import '../entities/user_entity.dart';

class FetchUser {
  FetchUser({required this.userRepository});

  final UserRepository userRepository;

  Future<Either<Failure, UserEntity>> call() async =>
      await userRepository.fetchUser();
}
