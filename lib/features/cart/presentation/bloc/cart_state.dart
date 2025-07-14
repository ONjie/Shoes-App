part of 'cart_bloc.dart';

enum CartItemsStatus {
  initial,
  loading,
  cartItemsFetched,
  cartItemAdded,
  cartItemDeleted,
  cartItemQuantityUpdated,
  cartItemsDeleted,
  fetchCartItemsError,
  deleteCartItemsError,
  deleteCartItemError,
  updateCartItemQuantityError,
  addCartIemToCartItemsError,
}

class CartState extends Equatable {
  const CartState({
    required this.cartItemsStatus,
    this.cartItems,
    this.totalShoesPrice,
    this.totalCost,
    this.message,
    this.numberOfItems,
  });

  final CartItemsStatus cartItemsStatus;
  final List<CartItemEntity>? cartItems;
  final double? totalShoesPrice;
  final double? totalCost;
  final String? message;
  final int? numberOfItems;

  @override
  List<Object?> get props => [
    cartItemsStatus,
    cartItems,
    totalShoesPrice,
    totalCost,
    message,
    numberOfItems,
  ];
}
