import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoes_api/env/env.dart';
import 'package:shoes_app/core/route/route_config.dart';
import 'package:shoes_app/core/utils/theme/theme.dart';
import 'package:shoes_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:shoes_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:shoes_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/shoes/presentation/bloc/shoes_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  await Supabase.initialize(anonKey: Env.supabaseKey, url: Env.supabaseUrl);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.locator<AuthenticationBloc>()),
        BlocProvider(create: (context) => di.locator<ShoesBloc>()),
        BlocProvider(create: (context) => di.locator<CartBloc>()),
        BlocProvider(create: (context) => di.locator<UserBloc>())
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Shoes App',
        theme: appTheme,
      ),
    );
  }
}
