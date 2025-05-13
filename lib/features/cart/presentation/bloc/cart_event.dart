part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();
}

class AddCartItemToCartItemsEvent extends CartEvent{
  final CartItemEntity cartItem;

  const AddCartItemToCartItemsEvent({required this.cartItem});

  @override
  List<Object?> get props => [cartItem];
}

class DeleteCartItemsEvent extends CartEvent{
  @override
  List<Object?> get props => [];
}

class DeleteCartItemEvent extends CartEvent{
  final int cartItemId;

  const DeleteCartItemEvent({required this.cartItemId});

  @override
  List<Object?> get props => [cartItemId];


}

class FetchCartItemsEvent extends CartEvent{
  @override
  List<Object?> get props => [];

}

class UpdateCartItemQuantityEvent extends CartEvent{
  final int cartItemId;
  final int quantity;

  const UpdateCartItemQuantityEvent({required this.cartItemId, required this.quantity});

  @override
  List<Object?> get props => [cartItemId, quantity];
}