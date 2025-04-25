import 'package:either_dart/either.dart';
import 'package:shoes_app/core/failures/failures.dart';
import 'package:shoes_app/features/authentication/domain/repositories/authentication_repository.dart';

class SignIn {
  final AuthenticationRepository authenticationRepository;

  SignIn({required this.authenticationRepository});

  Future<Either<Failure, bool>> execute({
    required String email,
    required String password,
  }) async =>
      await authenticationRepository.signIn(email: email, password: password);
}
