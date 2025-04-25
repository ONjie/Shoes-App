import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shoes_app/core/network/network_info.dart';
import 'package:shoes_app/features/authentication/data/datasources/remote%20data/supabase_auth_service.dart';
import 'package:shoes_app/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:shoes_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/check_auth_state.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/send_reset_password_otp.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/sign_in.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/sign_out.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/sign_up.dart';
import 'package:shoes_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/authentication/domain/use_cases/reset_password.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerFactory(
    () => AuthenticationBloc(
      signUp: locator(),
      signIn: locator(),
      checkAuthState: locator(),
      signOut: locator(),
      sendResetPasswordOTP: locator(),
      resetPassword: locator(),
    ),
  );

  //registering use_cases
  // authentication use_cases
  locator.registerLazySingleton(
    () => SignUp(authenticationRepository: locator()),
  );
  locator.registerLazySingleton(
    () => SignIn(authenticationRepository: locator()),
  );
  locator.registerLazySingleton(
    () => SignOut(authenticationRepository: locator()),
  );
  locator.registerLazySingleton(
    () => CheckAuthState(authenticationRepository: locator()),
  );
  locator.registerLazySingleton(
    () => SendResetPasswordOTP(authenticationRepository: locator()),
  );
  locator.registerLazySingleton(
    () => ResetPassword(authenticationRepository: locator()),
  );

  //registering repositories
  locator.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      supabaseAuthService: locator(),
      networkInfo: locator(),
    ),
  );

  //registering remoteDataSources
  locator.registerLazySingleton<SupabaseAuthService>(
    () => SupabaseAuthServiceImpl(supabaseClient: locator()),
  );

  //registering SupabaseClient
  final supabaseClient = Supabase.instance.client;
  locator.registerLazySingleton(() => supabaseClient);

  //registering networkInfo
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: locator()),
  );

  //registering InternetConnectionChecker
  locator.registerLazySingleton(
    () => InternetConnectionChecker.createInstance(),
  );
}
