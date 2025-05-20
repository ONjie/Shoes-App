import 'dart:io';

import 'package:shoes_app/features/user/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/core.dart';

abstract class UserRemoteDatabaseService {
  Future<UserModel> fetchUser();
  Future<void> createUserAccount({
    required String username,
    required String email,
    required String userId,
  });

  Future<bool> updateUserProfile({required UserModel user});

  Future<String> uploadImageToStorage({required File image});
}

class UserRemoteDatabaseServiceImpl implements UserRemoteDatabaseService {
  final SupabaseClient supabaseClient;

  UserRemoteDatabaseServiceImpl({required this.supabaseClient});
  @override
  Future<void> createUserAccount({
    required String username,
    required String email,
    required String userId,
  }) async {
    try {
      await supabaseClient.from('accounts').insert({
        'id': userId,
        'username': username,
        'email': email,
        'profile_picture': '',
      });
    } catch (e) {
      throw SupabaseDatabaseException(message: e.toString());
    }
  }

  @override
  Future<UserModel> fetchUser() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;

      final response =
          await supabaseClient
              .from('accounts')
              .select()
              .eq('id', userId!)
              .single();

      return UserModel.fromJson(response);
    } catch (e) {
      throw SupabaseDatabaseException(message: e.toString());
    }
  }

  @override
  Future<String> uploadImageToStorage({required File image}) async {
    try {
      final fileName = DateTime.now().microsecondsSinceEpoch.toString();

      final filePath = 'profile_pictures/$fileName';

      final response = await supabaseClient.storage
          .from('shoes-app-bucket')
          .upload(filePath, image);

      if (response.isEmpty) {
        throw SupabaseStorageException(message: 'Fail to upload image');
      }

      final uploadedImageUrl = supabaseClient.storage
          .from('shoes-app-bucket')
          .createSignedUrl(filePath, 31556926);

      return uploadedImageUrl;
    } catch (e) {
      if (e is SupabaseStorageException) {
        rethrow;
      }
      throw OtherExceptions(message: e.toString());
    }
  }

  @override
  Future<bool> updateUserProfile({required UserModel user}) async {
    try {
      await supabaseClient
          .from('accounts')
          .update(user.toJson())
          .eq('id', user.userId!);

      return true;
    } catch (e) {
      throw SupabaseDatabaseException(message: e.toString());
    }
  }
}
