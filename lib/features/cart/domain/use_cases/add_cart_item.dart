import 'package:either_dart/either.dart';

import '../../../../core/core.dart';
import '../entities/cart_item_entity.dart';
import '../repositories/cart_repository.dart';

class AddCartItem{
  final CartRepository cartRepository;

  AddCartItem({required this.cartRepository});

  Future<Either<Failure, int>> call({required CartItemEntity cartItem})
  async => await cartRepository.addCartItem(cartItem: cartItem);

}