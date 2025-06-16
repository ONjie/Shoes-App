import 'package:either_dart/either.dart';
import 'package:shoes_app/core/core.dart';

import '../repositories/checkout_repository.dart';

class MakePayment {
  final CheckoutRepository checkoutRepository;

  MakePayment({required this.checkoutRepository});

  Future<Either<Failure, bool>> call({required int totalCost}) async =>
      checkoutRepository.makePayment(totalCost: totalCost);
}
