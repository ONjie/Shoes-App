import 'package:go_router/go_router.dart';
import 'package:shoes_app/features/shoes/presentation/screens/brands_screen.dart';
import 'package:shoes_app/features/shoes/presentation/screens/home_screen.dart';
import 'package:shoes_app/features/authentication/presentation/screens/reset_password_screen.dart';
import 'package:shoes_app/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:shoes_app/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:shoes_app/features/authentication/presentation/screens/splash_screen.dart';
import 'package:shoes_app/features/shoes/presentation/screens/shoes_by_brand_screen.dart';

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
  ],
);
