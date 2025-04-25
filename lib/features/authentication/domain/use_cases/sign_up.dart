import 'package:either_dart/either.dart';
import 'package:shoes_app/core/failures/failures.dart';
import '../repositories/authentication_repository.dart';

class SignUp {
  final AuthenticationRepository authenticationRepository;

  SignUp({required this.authenticationRepository});

  Future<Either<Failure, bool>> execute({
    required String username,
    required String email,
    required String password,
  }) async => await authenticationRepository.signUp(
    username: username,
    email: email,
    password: password,
  );
}
