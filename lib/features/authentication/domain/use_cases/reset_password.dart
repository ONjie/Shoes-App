import 'package:either_dart/either.dart';
import 'package:shoes_app/features/authentication/domain/repositories/authentication_repository.dart';

import '../../../../core/failures/failures.dart';

class ResetPassword {
  final AuthenticationRepository authenticationRepository;

  ResetPassword({required this.authenticationRepository});
  
  Future<Either<Failure, bool>> execute({
    required String email,
    required String otp,
    required String newPassword,
  }) async => await authenticationRepository.resetPassword(
      email: email,
      otp: otp,
      newPassword: newPassword,
    );
}
