import 'package:dio/dio.dart';
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
import 'package:shoes_app/features/shoes/data/data_sources/remote_data/shoes_api_service.dart';
import 'package:shoes_app/features/shoes/data/repositories/shoes_repository_impl.dart';
import 'package:shoes_app/features/shoes/domain/repositories/shoes_repository.dart';
import 'package:shoes_app/features/shoes/presentation/bloc/shoes_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/authentication/domain/use_cases/reset_password.dart';
import 'features/shoes/domain/use_cases/use_cases.dart';

final locator = GetIt.instance;

Future<void> init() async {
  //registering blocs

  //authentication bloc
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

  //shoes_bloc
  locator.registerFactory(
    () => ShoesBloc(
      fetchLatestShoes: locator(),
      fetchPopularShoes: locator(),
      fetchOtherShoes: locator(),
      fetchLatestShoesByBrand: locator(),
      fetchPopularShoesByBrand: locator(),
      fetchOtherShoesByBrand: locator(),
      fetchShoesSuggestions: locator(),
      fetchShoesByBrand: locator(),
      fetchShoesByCategory: locator(),
      fetchShoe: locator(),
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

  //shoes use_cases
  locator.registerLazySingleton(() => FetchShoe(shoesRepository: locator()));
  locator.registerLazySingleton(
    () => FetchLatestShoes(shoesRepository: locator()),
  );
  locator.registerLazySingleton(
    () => FetchPopularShoes(shoesRepository: locator()),
  );
  locator.registerLazySingleton(
    () => FetchOtherShoes(shoesRepository: locator()),
  );
  locator.registerLazySingleton(
    () => FetchPopularShoesByBrand(shoesRepository: locator()),
  );
  locator.registerLazySingleton(
    () => FetchLatestShoesByBrand(shoesRepository: locator()),
  );
  locator.registerLazySingleton(
    () => FetchOtherShoesByBrand(shoesRepository: locator()),
  );
  locator.registerLazySingleton(
    () => FetchShoesByCategory(shoesRepository: locator()),
  );
  locator.registerLazySingleton(
    () => FetchShoesByBrand(shoesRepository: locator()),
  );
  locator.registerLazySingleton(
    () => FetchShoesSuggestions(shoesRepository: locator()),
  );
  locator.registerLazySingleton(
    () => AddShoeToFavoriteShoes(shoesRepository: locator()),
  );
  locator.registerLazySingleton(
    () => FetchFavoriteShoes(shoesRepository: locator()),
  );
  locator.registerLazySingleton(
    () => DeleteShoeFromFavoriteShoes(shoesRepository: locator()),
  );

  //registering repositories

  //authentication repository
  locator.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      supabaseAuthService: locator(),
      networkInfo: locator(),
    ),
  );

  //shoes repository
  locator.registerLazySingleton<ShoesRepository>(
    () =>
        ShoesRepositoryImpl(networkInfo: locator(), shoesApiService: locator()),
  );

  //registering dataSources
  // authentication datasource
  locator.registerLazySingleton<SupabaseAuthService>(
    () => SupabaseAuthServiceImpl(supabaseClient: locator()),
  );

  // shoes datasources
  locator.registerLazySingleton<ShoesApiService>(
    () => ShoesApiServiceImpl(dio: locator()),
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

  //registering Dio
  final dio = Dio();
  locator.registerLazySingleton(() => dio);
}
