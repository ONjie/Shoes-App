import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_app/core/core.dart';


class SplashScreenErrorWidget extends StatelessWidget {
  const SplashScreenErrorWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.fromLTRB(12, 16, 12, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ErrorStateWidget(message: message),
                SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    context.go('/');
                  },
                  child: Text(
                    'Retry',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
