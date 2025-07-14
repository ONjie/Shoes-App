import 'package:shoes_app/core/exceptions/exceptions.dart';
import 'package:shoes_app/core/utils/text/error_messages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupabaseAuthService {
  Future<String> signUp({required String email, required String password});
  Future<void> signIn({required String email, required String password});
  Future<bool> checkAuthState();
  Future<void> signOut();
  Future<void> sendResetPasswordOTP({required String email});
  Future<void> verifyOTP({required String email, required String otp});
  Future<void> updatePassword({required String newPassword});
}

class SupabaseAuthServiceImpl implements SupabaseAuthService {
  final SupabaseClient supabaseClient;
  SupabaseAuthServiceImpl({required this.supabaseClient});

  @override
  Future<bool> checkAuthState() async {
    try {
      final session = supabaseClient.auth.currentSession;

      if (session == null) {
        throw SupabaseAuthException(message: noUserFoundMessage);
      }
      return true;
    } catch (e) {
      if (e is SupabaseAuthException) {
        rethrow;
      }
      throw OtherExceptions(message: e.toString());
    }
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      if (e is AuthException) {
        throw SupabaseAuthException(message: e.message);
      } else {
        throw OtherExceptions(message: e.toString());
      }
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      throw SupabaseAuthException(message: e.toString());
    }
  }

  @override
  Future<String> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: 'io.supabase.flutterquickstart://login-callback/',
      );

      return response.user!.id;
    } catch (e) {
      if (e is AuthException) {
        throw SupabaseAuthException(message: e.message);
      }
      throw OtherExceptions(message: e.toString());
    }
  }

  @override
  Future<void> sendResetPasswordOTP({required String email}) async {
    try {
      await supabaseClient.auth.resetPasswordForEmail(email);
    } catch (e) {
      if (e is AuthException) {
        throw SupabaseAuthException(message: e.message);
      } else {
        throw OtherExceptions(message: e.toString());
      }
    }
  }

  @override
  Future<void> updatePassword({required String newPassword}) async {
    try {
      await supabaseClient.auth.updateUser(
        UserAttributes(password: newPassword),
      );
    } catch (e) {
      if (e is AuthException) {
        throw SupabaseAuthException(message: e.message);
      } else {
        throw OtherExceptions(message: e.toString());
      }
    }
  }

  @override
  Future<void> verifyOTP({required String email, required String otp}) async {
    try {
      await supabaseClient.auth.verifyOTP(
        type: OtpType.recovery,
        email: email,
        token: otp,
      );
    } catch (e) {
      if (e is AuthException) {
        throw SupabaseAuthException(message: e.message);
      } else {
        throw OtherExceptions(message: e.toString());
      }
    }
  }
}
