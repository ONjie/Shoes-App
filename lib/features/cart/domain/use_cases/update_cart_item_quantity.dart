import 'package:either_dart/either.dart';

import '../../../../core/core.dart';
import '../repositories/cart_repository.dart';

class UpdateCartItemQuantity{
  final CartRepository cartRepository;

  UpdateCartItemQuantity({required this.cartRepository});

  Future<Either<Failure, int>> call({required int cartItemId, required int quantity})
  async => await cartRepository.updateCartItemQuantity(cartItemId: cartItemId, quantity: quantity);
}