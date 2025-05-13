import 'package:flutter_test/flutter_test.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/cart/data/models/cart_item_model.dart';
import 'package:shoes_app/features/cart/domain/entities/cart_item_entity.dart';

void main() {
  const tCartItemModel = CartItemModel(
    id: 1,
    shoeTitle: 'Title',
    image: 'Image1',
    color: 'Color',
    price: 100.0,
    shoeSize: 14,
    quantity: 1,
  );

  const tCartItemEntity = CartItemEntity(
    id: 1,
    shoeTitle: 'Title',
    image: 'Image1',
    color: 'Color',
    price: 100.0,
    shoeSize: 14,
    quantity: 1,
  );

  const tCartItem = CartItem(
    id: 1,
    shoeTitle: 'Title',
    image: 'Image1',
    color: 'Color',
    price: 100.0,
    shoeSize: 14,
    quantity: 1,
  );


  test(
    'toCartItemEntity should return a valid CartItemEntity when conversion is successful',
    () async {
      //arrange & act
      final result = tCartItemModel.toCartItemEntity();

      //assert
      expect(result, isA<CartItemEntity>());
      expect(result, equals(tCartItemEntity));
    },
  );

  test(
    'fromCartItemEntity should return a valid CartItemModel when conversion is successful',
    () async {
      //arrange & act
      final result = CartItemModel.fromCartItemEntity(
        cartItem: tCartItemEntity,
      );

      //assert
      expect(result, isA<CartItemModel>());
      expect(result, equals(tCartItemModel));
    },
  );

   test(
    'fromCartItem should return a valid CartItemModel when conversion is successful',
    () async {
      //arrange & act
      final result = CartItemModel.fromCartItem(
        cartItem: tCartItem,
      );

      //assert
      expect(result, isA<CartItemModel>());
      expect(result, equals(tCartItemModel));
    },
  );
}
