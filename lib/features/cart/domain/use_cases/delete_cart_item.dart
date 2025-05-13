import 'package:either_dart/either.dart';

import '../../../../core/core.dart';
import '../repositories/cart_repository.dart';


class DeleteCartItem{
  final CartRepository cartRepository;

  DeleteCartItem({required this.cartRepository});

  Future<Either<Failure, bool>> call({required int cartItemId})
  async => await cartRepository.deleteCartItem(cartItemId: cartItemId);
}