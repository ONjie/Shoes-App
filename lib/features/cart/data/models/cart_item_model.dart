import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/cart_item_entity.dart';

class CartItemModel extends Equatable{

  const CartItemModel({
    this.id,
    required this.shoeTitle,
    required this.image,
    required this.color,
    required this.price,
    required this.shoeSize,
    required this.quantity
});

  final int? id;
  final String shoeTitle;
  final String image;
  final String color;
  final double price;
  final int shoeSize;
  final int quantity;

  @override
  List<Object?> get props => [
    id,
    shoeTitle,
    image,
    color,
    price,
    shoeSize,
    quantity,
  ];

  CartItemEntity toCartItemEntity() => CartItemEntity(
    id: id,
    shoeTitle: shoeTitle,
    image: image,
    color: color,
    price: price,
    shoeSize: shoeSize,
    quantity: quantity,
  );

  static CartItemModel fromCartItem({required CartItem cartItem}) => CartItemModel(
      id: cartItem.id!,
      shoeTitle: cartItem.shoeTitle,
      image: cartItem.image,
      color: cartItem.color,
      price: cartItem.price,
      shoeSize: cartItem.shoeSize,
      quantity: cartItem.quantity,
    );

  static CartItemModel fromCartItemEntity({required CartItemEntity cartItem}) => CartItemModel(
    id: cartItem.id,
    shoeTitle: cartItem.shoeTitle,
    image: cartItem.image,
    color: cartItem.color,
    price: cartItem.price,
    shoeSize: cartItem.shoeSize,
    quantity: cartItem.quantity,
  );
}