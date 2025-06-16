import 'package:go_router/go_router.dart';
import 'package:shoes_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:shoes_app/features/delivery_destination/domain/entities/delivery_destination_entity.dart';
import 'package:shoes_app/features/delivery_destination/presentation/screens/add_delivery_destination_screen.dart';
import 'package:shoes_app/features/delivery_destination/presentation/screens/edit_delivery_destination_screen.dart';
import 'package:shoes_app/features/shoes/presentation/screens/brands_screen.dart';
import 'package:shoes_app/features/shoes/presentation/screens/home_screen.dart';
import 'package:shoes_app/features/authentication/presentation/screens/reset_password_screen.dart';
import 'package:shoes_app/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:shoes_app/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:shoes_app/features/authentication/presentation/screens/splash_screen.dart';
import 'package:shoes_app/features/shoes/presentation/screens/shoe_details_screen.dart';
import 'package:shoes_app/features/shoes/presentation/screens/shoes_by_brand_screen.dart';
import 'package:shoes_app/features/user/domain/entities/user_entity.dart';
import 'package:shoes_app/features/user/presentation/screens/edit_profile_screen.dart';

import '../../features/authentication/presentation/screens/change_password_screen.dart';
import '../../features/authentication/presentation/screens/forgot_password_screen.dart';
import '../../features/checkout/presentation/screens/checkout_screen.dart';
import '../../features/delivery_destination/presentation/screens/delivery_destinations_screen.dart';
import '../../features/delivery_destination/presentation/screens/select_delivery_destination_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'Splash Screen',
      path: '/',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      name: 'Home Screen',
      path: '/home/:screenIndex',
      builder: (context, state) {
        final screenIndex = state.pathParameters['screenIndex'];
        return HomeScreen(screenIndex: int.tryParse(screenIndex!)!);
      },
    ),
    GoRoute(
      name: 'SignIn Screen',
      path: '/sign_in',
      builder: (context, state) => SignInScreen(),
    ),
    GoRoute(
      name: 'SignUp Screen',
      path: '/sign_up',
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      name: 'Forgot Password Screen',
      path: '/forgot_password',
      builder: (context, state) => ForgotPasswordScreen(),
    ),
    GoRoute(
      name: 'Reset Password Screen',
      path: '/reset_password',
      builder: (context, state) => ResetPasswordScreen(),
    ),
    GoRoute(
      name: 'Shoes By Brand Screen',
      path: '/shoes_by_brand/:brand',
      builder: (context, state) {
        final brand = state.pathParameters['brand'];
        return ShoesByBrandScreen(brand: brand!);
      },
    ),
    GoRoute(
      name: 'Brand Screen',
      path: '/brands',
      builder: (context, state) => BrandsScreen(),
    ),
    GoRoute(
      name: 'Shoe Details Screen',
      path: '/shoe_details/:shoeId',
      builder: (context, state) {
        final shoeId = state.pathParameters['shoeId'];
        return ShoeDetailsScreen(shoeId: int.tryParse(shoeId!)!);
      },
    ),
    GoRoute(
      name: 'Edit Profile Screen',
      path: '/edit_profile',
      builder: (context, state) {
        final user = state.extra as UserEntity;
        return EditProfileScreen(user: user);
      },
    ),
    GoRoute(
      name: 'Change Password Screen',
      path: '/change_password/:email',
      builder: (context, state) {
        final email = state.pathParameters['email'];
        return ChangePasswordScreen(email: email!);
      },
    ),
    GoRoute(
      name: 'Delviery Destination Screen',
      path: '/delivery_destinations',
      builder: (context, state) => DeliveryDestinationsScreen(),
    ),
    GoRoute(
      name: 'Add Delviery Destination Screen',
      path: '/add_delivery_destination',
      builder: (context, state) => AddDeliveryDestinationScreen(),
    ),
    GoRoute(
      name: 'Edit Delviery Destination Screen',
      path: '/edit_delivery_destination',
      builder: (context, state) {
        final deliveryDestination = state.extra as DeliveryDestinationEntity;
        return EditDeliveryDestinationScreen(
          deliveryDestination: deliveryDestination,
        );
      },
    ),
    GoRoute(
      name: 'Select Delviery Destination Screen',
      path: '/select_delivery_destination',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final cartItems = extra['cartItems']! as List<CartItemEntity>;
        final totalCost = extra['totalCost']! as double;

        return SelectDeliveryDestinationScreen(
          cartItems: cartItems,
          totalCost: totalCost,
        );
      },
    ),
    GoRoute(
      name: 'Checkout Screen',
      path: '/checkout',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final cartItems = extra['cartItems']! as List<CartItemEntity>;
        final totalCost = extra['totalCost']! as double;
        final deliveryDestination =
            extra['deliveryDestination'] as DeliveryDestinationEntity;

        return CheckoutScreen(
          cartItems: cartItems,
          totalCost: totalCost,
          deliveryDestination: deliveryDestination
        );
      },
    ),
  ],
);
