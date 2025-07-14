import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: "Step Into Style",
              body:
                  "Discover the latest sneakers, timeless classics, and everything in between — all in one app.",
              image: _buildImage('assets/lottie/shoe_animation.json'),
              decoration: _pageDecoration(context: context),
            ),
            PageViewModel(
              title: "Discover & Favorite",
              body:
                  "Browse top brands, compare styles and favorite what you love.",
              image: _buildImage('assets/lottie/shoes_animation.json'),
              decoration: _pageDecoration(context: context),
            ),
            PageViewModel(
              title: "Add to Cart",
              body:
                  "Easily add your favorite shoes to the cart and manage your selections.",
              image: _buildImage('assets/lottie/cart_animation.json'),
              decoration: _pageDecoration(context: context),
            ),
            PageViewModel(
              title: "Secure Checkout",
              body:
                  "Pay securely using Stripe and track your order right from the app.",
              image: _buildImage('assets/lottie/stripe_animation.json'),
              decoration: _pageDecoration(context: context),
            ),
          ],
          onDone: () {
            context.go('/sign_in');
          },
          onSkip: () {
            context.go('/sign_in');
          },
          showSkipButton: true,
          skip: const Text("Skip"),
          next: const Icon(Icons.arrow_forward_ios),
          done: const Text(
            "Done",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          dotsDecorator: DotsDecorator(
            size: const Size(10, 10),
            activeSize: const Size(22, 10),
            activeColor: Theme.of(context).colorScheme.primary,
            color: Theme.of(context).colorScheme.secondary,
            spacing: const EdgeInsets.symmetric(horizontal: 3),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String path) => Lottie.asset(path, height: 300);

  PageDecoration _pageDecoration({required BuildContext context}) {
    return PageDecoration(
      titleTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
      bodyTextStyle: Theme.of(
        context,
      ).textTheme.bodyMedium!.copyWith(fontSize: 18),
      imagePadding: EdgeInsets.all(24),
      contentMargin: EdgeInsets.all(16),
    );
  }
}
