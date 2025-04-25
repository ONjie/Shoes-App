import 'package:either_dart/either.dart';
import 'package:shoes_app/core/failures/failures.dart';

import '../repositories/authentication_repository.dart';

class CheckAuthState {
  final AuthenticationRepository authenticationRepository;

  CheckAuthState({required this.authenticationRepository});

  Future<Either<Failure, bool>> execute() async =>
      await authenticationRepository.checkAuthState();
}
