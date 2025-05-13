import 'package:either_dart/either.dart';

import '../../../../core/core.dart';
import '../repositories/cart_repository.dart';

class DeleteCartItems{
  final CartRepository cartRepository;

  DeleteCartItems({required this.cartRepository});

  Future<Either<Failure, int>> call()
  async => await cartRepository.deleteCartItems();
}