import 'package:either_dart/either.dart';

import '../../../../core/core.dart';
import '../repositories/user_repository.dart';

class UpdateUsername {
  UpdateUsername({required this.userRepository});

  final UserRepository userRepository;

  Future<Either<Failure, bool>> call({
    required String userId,
    required String newUsername,
  }) async => await userRepository.updateUsername(
    userId: userId,
    newUsername: newUsername,
  );
}
