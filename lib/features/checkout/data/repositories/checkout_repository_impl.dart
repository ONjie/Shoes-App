import 'package:either_dart/either.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/checkout/data/data_sources/remote_data/stripe_payment_service.dart';

import '../../domain/repositories/checkout_repository.dart';

const currency = 'usd';

class CheckoutRepositoryImpl implements CheckoutRepository {
  final StripePaymentService stripePaymentService;
  final NetworkInfo networkInfo;

  CheckoutRepositoryImpl({
    required this.stripePaymentService,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, bool>> makePayment({required int totalCost}) async {
    if (!await networkInfo.isConnected) {
      return Left(
        InternetConnectionFailure(message: noInternetConnectionMessage),
      );
    }

    try {
      final calculatedAmount = await stripePaymentService.calculateAmount(
        totalCost: totalCost,
      );

      final clientSecret = await stripePaymentService.createPaymentIntent(
        amount: calculatedAmount,
        currency: currency,
      );

      await stripePaymentService.initPaymentSheet(clientSecret: clientSecret);

      final result = await stripePaymentService.processPayment();

      return Right(result);
    } on StripePaymentException catch (e) {
      return Left(StripePaymentFailure(message: e.message));
    }
  }
}
