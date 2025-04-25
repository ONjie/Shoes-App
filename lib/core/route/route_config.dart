import 'package:go_router/go_router.dart';
import 'package:shoes_app/features/authentication/presentation/screens/home_screen.dart';
import 'package:shoes_app/features/authentication/presentation/screens/reset_password_screen.dart';
import 'package:shoes_app/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:shoes_app/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:shoes_app/features/authentication/presentation/screens/splash_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name:'Splash Screen',
      path: '/',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      name: 'Home Screen',
      path: '/home',
      builder: (context, state) => HomeScreen(),
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

  ],
);
