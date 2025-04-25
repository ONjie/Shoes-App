import 'package:either_dart/either.dart';
import 'package:shoes_app/core/failures/failures.dart';
import 'package:shoes_app/features/authentication/domain/repositories/authentication_repository.dart';


class SignOut{

  final AuthenticationRepository authenticationRepository;

  SignOut({required this.authenticationRepository});

  Future<Either<Failure, bool>> execute()
  async => await authenticationRepository.signOut();
}