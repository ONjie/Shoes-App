import 'package:either_dart/either.dart';
import 'package:shoes_app/core/exceptions/exceptions.dart';
import 'package:shoes_app/core/failures/failures.dart';
import 'package:shoes_app/core/network/network_info.dart';
import 'package:shoes_app/core/utils/text/error_messages.dart';
import 'package:shoes_app/features/authentication/data/datasources/remote%20data/supabase_auth_service.dart';
import 'package:shoes_app/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final SupabaseAuthService supabaseAuthService;
  final NetworkInfo networkInfo;
  AuthenticationRepositoryImpl({
    required this.supabaseAuthService,
    required this.networkInfo,
  });
  @override
  Future<BoolOrFailure> checkAuthState() async {
    if (!await networkInfo.isConnected) {
      return Left(
        InternetConnectionFailure(message: noInternetConnectionMessage),
      );
    }
    try {
      final result = await supabaseAuthService.checkAuthState();
      return Right(result);
    } on SupabaseAuthException catch (e) {
      return Left(SupabaseAuthFailure(message: e.message));
    } on OtherExceptions catch (e) {
      return Left(OtherFailure(message: e.message));
    }
  }

  @override
  Future<BoolOrFailure> signIn({
    required String email,
    required String password,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(
        InternetConnectionFailure(message: noInternetConnectionMessage),
      );
    }

    try {
      await supabaseAuthService.signIn(email: email, password: password);

      return Right(true);
    } on SupabaseAuthException catch (e) {
      return Left(SupabaseAuthFailure(message: e.message));
    } on OtherExceptions catch (e) {
      return Left(OtherFailure(message: e.message));
    }
  }

  @override
  Future<BoolOrFailure> signOut() async {
    if (!await networkInfo.isConnected) {
      return Left(
        InternetConnectionFailure(message: noInternetConnectionMessage),
      );
    }

    try {
      await supabaseAuthService.signOut();
      return Right(true);
    } on SupabaseAuthException catch (e) {
      return Left(SupabaseAuthFailure(message: e.message));
    }
  }

  @override
  Future<BoolOrFailure> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(
        InternetConnectionFailure(message: noInternetConnectionMessage),
      );
    }

    try {
      final userId = await supabaseAuthService.signUp(
        email: email,
        password: password,
      );
      await supabaseAuthService.createAccount(
        email: email,
        username: username,
        userId: userId,
      );
      return Right(true);
    } on SupabaseAuthException catch (e) {
      return Left(SupabaseAuthFailure(message: e.message));
    } on OtherExceptions catch (e) {
      return Left(OtherFailure(message: e.message));
    }
  }

  @override
  Future<BoolOrFailure> sendResetPasswordOTP({required String email}) async {
    if (!await networkInfo.isConnected) {
      return Left(
        InternetConnectionFailure(message: noInternetConnectionMessage),
      );
    }

    try {
      await supabaseAuthService.sendResetPasswordOTP(email: email);

      return Right(true);
    } on SupabaseAuthException catch (e) {
      return Left(SupabaseAuthFailure(message: e.message));
    } on OtherExceptions catch (e) {
      return Left(OtherFailure(message: e.message));
    }
  }

  @override
  Future<BoolOrFailure> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(
        InternetConnectionFailure(message: noInternetConnectionMessage),
      );
    }

    try {
      await supabaseAuthService.verifyOTP(email: email, otp: otp);
      await supabaseAuthService.updatePassword(newPassword: newPassword);

      return Right(true);
    } on SupabaseAuthException catch (e) {
      return Left(SupabaseAuthFailure(message: e.message));
    } on OtherExceptions catch (e) {
      return Left(OtherFailure(message: e.message));
    }
  }
}
