part of 'cart_bloc.dart';

enum CartItemsStatus {
  initial,
  loading,
  cartItemsLoaded,
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
    this.deliveryCharge,
    this.successMessage,
    this.errorMessage,
    this.numberOfItems
  });

  final CartItemsStatus cartItemsStatus;
  final List<CartItemEntity>? cartItems;
  final double? totalShoesPrice;
  final double? totalCost;
  final double? deliveryCharge;
  final String? successMessage;
  final String? errorMessage;
  final int? numberOfItems;

  @override
  List<Object?> get props => [
    cartItemsStatus,
    cartItems,
    totalShoesPrice,
    totalCost,
    deliveryCharge,
    successMessage,
    errorMessage,
    numberOfItems
  ];
}
