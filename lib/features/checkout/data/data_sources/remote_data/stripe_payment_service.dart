import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shoes_api/env/env.dart';
import 'package:shoes_app/core/core.dart';

abstract class StripePaymentService {
  Future<String> calculateAmount({required int totalCost});

  Future<String> createPaymentIntent({
    required String amount,
    required String currency,
  });
  Future<bool> initPaymentSheet({required String clientSecret});
  Future<bool> processPayment();
}

class StripePaymentServiceImpl implements StripePaymentService {
  final Dio dio;
  final Stripe stripe;

  StripePaymentServiceImpl({required this.dio, required this.stripe});

  @override
  Future<String> calculateAmount({required int totalCost}) async {
    return (totalCost * 100).toString();
  }

  @override
  Future<String> createPaymentIntent({
    required String amount,
    required String currency,
  }) async {
    try {
      final response = await dio.post(
        stripePaymentIntentUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Env.stripeSecretKey}',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
        data: {'currency': currency, 'amount': amount},
      );

      return response.data['client_secret'] as String;
    } on DioException catch (e) {
      throw StripePaymentException(message: e.response?.data['error']);
    }
  }

  @override
  Future<bool> initPaymentSheet({required String clientSecret}) async {
    try {
      await stripe.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Muhammed O Njie',
        ),
      );

      return true;
    } catch (e) {
      print('error: ${e.toString()}');
      throw StripePaymentException(message: e.toString());
    }
  }

  @override
  Future<bool> processPayment() async {
    try {
      await stripe.presentPaymentSheet();
      return true;
    } catch (e) {
      throw StripePaymentException(message: e.toString());
    }
  }
}
