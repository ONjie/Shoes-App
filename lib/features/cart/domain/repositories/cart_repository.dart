import 'package:either_dart/either.dart';

import '../../../../core/core.dart';
import '../entities/cart_item_entity.dart';

typedef EitherFailureOrInt = Either<Failure, int>;
typedef EitherFailureOrBool = Either<Failure, bool>;

abstract class CartRepository {
  Future<EitherFailureOrInt> addCartItem({required CartItemEntity cartItem});

  Future<Either<Failure, List<CartItemEntity>>> fetchCartItems();

  Future<EitherFailureOrBool> updateCartItem({
    required CartItemEntity cartItem,
  });

  Future<EitherFailureOrBool> deleteCartItem({required int cartItemId});

  Future<EitherFailureOrInt> updateCartItemQuantity({
    required int cartItemId,
    required int quantity,
  });

  Future<EitherFailureOrInt> deleteCartItems();
}
