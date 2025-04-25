import 'package:either_dart/either.dart';
import 'package:shoes_app/core/failures/failures.dart';
import 'package:shoes_app/features/authentication/domain/repositories/authentication_repository.dart';

class SendResetPasswordOTP {
  final AuthenticationRepository authenticationRepository;

  SendResetPasswordOTP({required this.authenticationRepository});

  Future<Either<Failure, bool>> execute({required String email}) async =>
      await authenticationRepository.sendResetPasswordOTP(email: email);
}
