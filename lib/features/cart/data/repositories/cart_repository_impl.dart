import 'package:either_dart/either.dart';
import 'package:shoes_app/features/cart/data/data_sources/local_data/cart_local_database_service.dart';
import 'package:shoes_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:shoes_app/features/cart/domain/repositories/cart_repository.dart';

import '../../../../core/core.dart';
import '../models/cart_item_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDatabaseService cartLocalDatabaseService;

  CartRepositoryImpl({required this.cartLocalDatabaseService});

  @override
  Future<EitherFailureOrInt> addCartItem({
    required CartItemEntity cartItem,
  }) async {
    try {
      final cartItemToBeAdded = CartItemModel.fromCartItemEntity(
        cartItem: cartItem,
      );

      final insertedId = await cartLocalDatabaseService.addCartItem(
        cartItem: cartItemToBeAdded,
      );

      if (insertedId <= 0) {
        return Left(LocalDatabaseFailure(message: addCartItemErrorMessage));
      }

      return Right(insertedId);
    } catch (e) {
      return Left(OtherFailure(message: e.toString()));
    }
  }

  @override
  Future<EitherFailureOrBool> deleteCartItem({required int cartItemId}) async {
    try {
      final isDeleted = await cartLocalDatabaseService.deleteCartItem(
        cartItemId: cartItemId,
      );

      if (!isDeleted) {
        return Left(LocalDatabaseFailure(message: deleteCartItemErrorMessage));
      }

      return Right(isDeleted);
    } catch (e) {
      return Left(OtherFailure(message: e.toString()));
    }
  }

  @override
  Future<EitherFailureOrInt> deleteCartItems() async {
    try {
      final deletedRows = await cartLocalDatabaseService.deleteCartItems();

      if (deletedRows <= 0) {
        return Left(
          LocalDatabaseFailure(message: deleteAllCartItemsErrorMessage),
        );
      }

      return Right(deletedRows);
    } catch (e) {
      return Left(OtherFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartItemEntity>>> fetchCartItems() async {
    try {
      final fetchedCartItems = await cartLocalDatabaseService.fetchCartItems();

      if (fetchedCartItems.isEmpty) {
        return Left(
          LocalDatabaseFailure(message: fetchAllCartItemsErrorMessage),
        );
      }

      final cartItems =
          fetchedCartItems
              .map((fetchedCartItem) => fetchedCartItem.toCartItemEntity())
              .toList();

      return Right(cartItems);
    } catch (e) {
      return Left(OtherFailure(message: e.toString()));
    }
  }

  @override
  Future<EitherFailureOrBool> updateCartItem({
    required CartItemEntity cartItem,
  }) async {
    try {
      final cartItemToBeUpdated = CartItemModel.fromCartItemEntity(
        cartItem: cartItem,
      );

      final isUpdated = await cartLocalDatabaseService.updateCartItem(
        cartItem: cartItemToBeUpdated,
      );

      if (!isUpdated) {
        return Left(LocalDatabaseFailure(message: updateCartItemErrorMessage));
      }

      return Right(isUpdated);
    } catch (e) {
      return Left(OtherFailure(message: e.toString()));
    }
  }

  @override
  Future<EitherFailureOrInt> updateCartItemQuantity({
    required int cartItemId,
    required int quantity,
  }) async {
    try {
      final rowId = await cartLocalDatabaseService.updateCartItemQuantity(
        cartItemId: cartItemId,
        quantity: quantity,
      );

      if (rowId <= 0) {
        return Left(
          LocalDatabaseFailure(message: updateCartItemQuantityErrorMessage),
        );
      }

      return Right(rowId);
    } catch (e) {
      return Left(OtherFailure(message: e.toString()));
    }
  }
}
