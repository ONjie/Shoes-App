import 'package:either_dart/either.dart';
import 'package:shoes_app/core/failures/failures.dart';

typedef BoolOrFailure = Either<Failure, bool>;

abstract class AuthenticationRepository {
  Future<BoolOrFailure> signUp({
    required String username,
    required String email,
    required String password,
  });
  Future<BoolOrFailure> signIn({
    required String email,
    required String password,
  });
  Future<BoolOrFailure> checkAuthState();
  Future<BoolOrFailure> signOut();
  Future<BoolOrFailure> sendResetPasswordOTP({required String email});
  Future<BoolOrFailure> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  });
}
