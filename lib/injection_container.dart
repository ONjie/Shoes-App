import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/authentication/data/datasources/remote%20data/supabase_auth_service.dart';
import 'package:shoes_app/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:shoes_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/check_auth_state.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/send_reset_password_otp.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/sign_in.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/sign_out.dart';
import 'package:shoes_app/features/authentication/domain/use_cases/sign_up.dart';
import 'package:shoes_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:shoes_app/features/cart/data/data_sources/local_data/cart_local_database_service.dart';
import 'package:shoes_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:shoes_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:shoes_app/features/cart/domain/use_cases/use_cases.dart';
import 'package:shoes_app/features/checkout/data/data_sources/remote_data/stripe_payment_service.dart';
import 'package:shoes_app/features/checkout/data/repositories/checkout_repository_impl.dart';
import 'package:shoes_app/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:shoes_app/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:shoes_app/features/delivery_destination/data/data_sources/remote_data/delivery_destination_remote_database_service.dart';
import 'package:shoes_app/features/delivery_destination/data/repositories/delivery_destination_repository_impl.dart';
import 'package:shoes_app/features/delivery_destination/domain/repositories/delivery_destination_repository.dart';
import 'package:shoes_app/features/delivery_destination/domain/use_cases/add_delivery_destination.dart';
import 'package:shoes_app/features/delivery_destination/presentation/bloc/delivery_destination_bloc.dart';
import 'package:shoes_app/features/orders/data/data_sources/remote_data/orders_remote_database_service.dart';
import 'package:shoes_app/features/orders/data/repositories/orders_repository_impl.dart';
import 'package:shoes_app/features/orders/domain/use_cases/create_order.dart';
import 'package:shoes_app/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:shoes_app/features/shoes/data/data_sources/local_data/shoes_local_database_service.dart';
import 'package:shoes_app/features/shoes/data/data_sources/remote_data/shoes_api_service.dart';
import 'package:shoes_app/features/shoes/data/repositories/shoes_repository_impl.dart';
import 'package:shoes_app/features/shoes/domain/repositories/shoes_repository.dart';
import 'package:shoes_app/features/shoes/presentation/bloc/shoes_bloc.dart';
import 'package:shoes_app/features/user/data/data_sources/remote_data/user_remote_database_service.dart';
import 'package:shoes_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:shoes_app/features/user/domain/repositories/user_repository.dart';
import 'package:shoes_app/features/user/domain/use_cases/fetch_user.dart';
import 'package:shoes_app/features/user/domain/use_cases/update_user_profile.dart';
import 'package:shoes_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/authentication/domain/use_cases/reset_password.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/checkout/domain/use_cases/make_payment.dart';
import 'features/delivery_destination/domain/use_cases/delete_delivery_destination.dart';
import 'features/delivery_destination/domain/use_cases/fetch_delivery_destinations.dart';
import 'features/delivery_destination/domain/use_cases/update_delivery_destination.dart';
import 'features/orders/domain/repositories/orders_repository.dart';
import 'features/orders/domain/use_cases/delete_order.dart';
import 'features/orders/domain/use_cases/fetch_order.dart';
import 'features/orders/domain/use_cases/fetch_orders.dart';
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
      fetchFavoriteShoes: locator(),
      addShoeToFavoriteShoes: locator(),
      deleteShoeFromFavoriteShoes: locator(),
    ),
  );

  //cart bloc
  locator.registerFactory(
    () => CartBloc(
      addCartItem: locator(),
      deleteCartItem: locator(),
      deleteCartItems: locator(),
      fetchCartItems: locator(),
      updateCartItemQuantity: locator(),
    ),
  );

  //user bloc
  locator.registerFactory(
    () => UserBloc(fetchUser: locator(), updateUserProfile: locator()),
  );

  //delivery destionation bloc
  locator.registerFactory(
    () => DeliveryDestinationBloc(
      addDeliveryDestination: locator(),
      fetchDeliveryDestinations: locator(),
      updateDeliveryDestination: locator(),
      deleteDeliveryDestination: locator(),
    ),
  );

  //checkout bloc
  locator.registerFactory(() => CheckoutBloc(makePayment: locator()));

  // orders bloc
  locator.registerFactory(
    () => OrdersBloc(
      createOrder: locator(),
      fetchOrders: locator(),
      fetchOrder: locator(),
      deleteOrder: locator(),
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

  //cart use_cases
  locator.registerLazySingleton(() => AddCartItem(cartRepository: locator()));
  locator.registerLazySingleton(
    () => DeleteCartItem(cartRepository: locator()),
  );
  locator.registerLazySingleton(
    () => DeleteCartItems(cartRepository: locator()),
  );
  locator.registerLazySingleton(
    () => UpdateCartItemQuantity(cartRepository: locator()),
  );
  locator.registerLazySingleton(
    () => FetchCartItems(cartRepository: locator()),
  );

  // user use_cases
  locator.registerLazySingleton(() => FetchUser(userRepository: locator()));
  locator.registerLazySingleton(
    () => UpdateUserProfile(userRepository: locator()),
  );

  // delivery destination use_cases
  locator.registerLazySingleton(
    () => AddDeliveryDestination(deliveryDestinationRepository: locator()),
  );
  locator.registerLazySingleton(
    () => FetchDeliveryDestinations(deliveryDestinationRepository: locator()),
  );
  locator.registerLazySingleton(
    () => UpdateDeliveryDestination(deliveryDestinationRepository: locator()),
  );
  locator.registerLazySingleton(
    () => DeleteDeliveryDestination(deliveryDestinationRepository: locator()),
  );

  // checkout use_cases
  locator.registerLazySingleton(
    () => MakePayment(checkoutRepository: locator()),
  );

  // orders use_cases
  locator.registerLazySingleton(() => CreateOrder(ordersRepository: locator()));
  locator.registerLazySingleton(() => FetchOrders(ordersRepository: locator()));
  locator.registerLazySingleton(() => FetchOrder(ordersRepository: locator()));
  locator.registerLazySingleton(() => DeleteOrder(ordersRepository: locator()));

  //registering repositories

  //authentication repository
  locator.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      supabaseAuthService: locator(),
      networkInfo: locator(),
      userRemoteDatabaseService: locator(),
    ),
  );

  //shoes repository
  locator.registerLazySingleton<ShoesRepository>(
    () => ShoesRepositoryImpl(
      networkInfo: locator(),
      shoesApiService: locator(),
      shoesLocalDatabaseService: locator(),
    ),
  );

  //cart repository
  locator.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(cartLocalDatabaseService: locator()),
  );

  // user repository
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      networkInfo: locator(),
      userRemoteDatabaseService: locator(),
    ),
  );

  // delivery destination repository
  locator.registerLazySingleton<DeliveryDestinationRepository>(
    () => DeliveryDestinationRepositoryImpl(
      deliveryDestinationRemoteDatabaseService: locator(),
      networkInfo: locator(),
    ),
  );

  // checkout repository
  locator.registerLazySingleton<CheckoutRepository>(
    () => CheckoutRepositoryImpl(
      stripePaymentService: locator(),
      networkInfo: locator(),
    ),
  );

  // orders repository
  locator.registerLazySingleton<OrdersRepository>(
    () => OrdersRepositoryImpl(
      networkInfo: locator(),
      ordersRemoteDatabaseService: locator(),
    ),
  );

  //registering dataSources
  // authentication datasource
  locator.registerLazySingleton<SupabaseAuthService>(
    () => SupabaseAuthServiceImpl(supabaseClient: locator()),
  );

  // shoes datasources
  //remote data
  locator.registerLazySingleton<ShoesApiService>(
    () => ShoesApiServiceImpl(dio: locator()),
  );

  //local data
  locator.registerLazySingleton<ShoesLocalDatabaseService>(
    () => ShoesLocalDatabaseServiceImpl(appDatabase: locator()),
  );

  //cart datasources
  //local data
  locator.registerLazySingleton<CartLocalDatabaseService>(
    () => CartLocalDatabaseServiceImpl(appDatabase: locator()),
  );

  //user dataosurces
  locator.registerLazySingleton<UserRemoteDatabaseService>(
    () => UserRemoteDatabaseServiceImpl(supabaseClient: locator()),
  );

  // delivery destination datasources
  locator.registerLazySingleton<DeliveryDestinationRemoteDatabaseService>(
    () =>
        DeliveryDestinationRemoteDatabaseServiceImpl(supabaseClient: locator()),
  );

  // checkout datasources
  locator.registerLazySingleton<StripePaymentService>(
    () => StripePaymentServiceImpl(dio: locator(), stripe: locator()),
  );

  // orders datasources
  locator.registerLazySingleton<OrdersRemoteDatabaseService>(
    () => OrdersRemoteDatabaseServiceImpl(supabaseClient: locator()),
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

  //registering Drift's AppDatabase
  final appDatabase = AppDatabase();
  locator.registerLazySingleton(() => appDatabase);

  // registering Stripe
  final stripe = Stripe.instance;
  locator.registerLazySingleton(() => stripe);
}
