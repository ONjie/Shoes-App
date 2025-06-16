import 'package:either_dart/either.dart';
import 'package:shoes_app/core/core.dart';

abstract class CheckoutRepository {
  Future<Either<Failure, bool>> makePayment({required int totalCost});
}
