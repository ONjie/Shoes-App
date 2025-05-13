import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../../cart/domain/use_cases/use_cases.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddCartItem addCartItem;
  final DeleteCartItems deleteCartItems;
  final DeleteCartItem deleteCartItem;
  final FetchCartItems fetchCartItems;
  final UpdateCartItemQuantity updateCartItemQuantity;

  CartBloc({
    required this.addCartItem,
    required this.deleteCartItems,
    required this.deleteCartItem,
    required this.fetchCartItems,
    required this.updateCartItemQuantity,
  }) : super(const CartState(cartItemsStatus: CartItemsStatus.initial)) {
    on<AddCartItemToCartItemsEvent>(_onAddCartItemToCartItems);
    on<DeleteCartItemsEvent>(_onDeleteCartItems);
    on<DeleteCartItemEvent>(_onDeleteCartItem);
    on<FetchCartItemsEvent>(_onFetchCartItems);
    on<UpdateCartItemQuantityEvent>(_onUpdateCartItemQuantity);
  }

  _onAddCartItemToCartItems(
    AddCartItemToCartItemsEvent event,
    Emitter<CartState> emit,
  ) async {
    final insertedIdOrFailure = await addCartItem.call(
      cartItem: event.cartItem,
    );

    insertedIdOrFailure.fold(
      (failure) {
        emit(
          CartState(
            cartItemsStatus: CartItemsStatus.addCartIemToCartItemsError,
            errorMessage: failure.message,
          ),
        );
      },
      (insertedId) {
        emit(
          CartState(
            cartItemsStatus: CartItemsStatus.cartItemAdded,
            successMessage: cartItemAddedSuccessfully,
          ),
        );
      },
    );
  }

  _onDeleteCartItems(
    DeleteCartItemsEvent event,
    Emitter<CartState> emit,
  ) async {
    final deleteRowsOrFailure = await deleteCartItems.call();

    deleteRowsOrFailure.fold(
      (failure) {
        emit(
          CartState(
            cartItemsStatus: CartItemsStatus.deleteCartItemsError,
            errorMessage: failure.message,
          ),
        );
      },
      (deleteRows) {
        emit(
          const CartState(cartItemsStatus: CartItemsStatus.cartItemsDeleted),
        );
      },
    );
  }

  _onDeleteCartItem(DeleteCartItemEvent event, Emitter<CartState> emit) async {
    final isDeletedOrFailure = await deleteCartItem.call(
      cartItemId: event.cartItemId,
    );

    isDeletedOrFailure.fold(
      (failure) {
        emit(
          CartState(
            cartItemsStatus: CartItemsStatus.deleteCartItemError,
            errorMessage: failure.message,
          ),
        );
      },
      (isDeleted) {
        emit(const CartState(cartItemsStatus: CartItemsStatus.cartItemDeleted));
      },
    );
  }

  _onFetchCartItems(FetchCartItemsEvent event, Emitter<CartState> emit) async {
    late double totalShoesPrice = 0;
    late double totalCost = 0;
    const double deliveryCharge = 20;
    late int numberOfItems = 0;

    emit(const CartState(cartItemsStatus: CartItemsStatus.loading));

    final cartItemsOrFailure = await fetchCartItems.call();

    cartItemsOrFailure.fold(
      (failure) {
        emit(
          CartState(
            cartItemsStatus: CartItemsStatus.fetchCartItemsError,
            errorMessage: failure.message,
          ),
        );
      },
      (cartItems) {
        for (var item in cartItems) {
          totalShoesPrice += (item.price * item.quantity);
          numberOfItems += (item.quantity);
        }
        totalCost = totalShoesPrice + deliveryCharge;
        emit(
          CartState(
            cartItemsStatus: CartItemsStatus.cartItemsLoaded,
            cartItems: cartItems,
            totalShoesPrice: totalShoesPrice,
            totalCost: totalCost,
            deliveryCharge: deliveryCharge,
            numberOfItems: numberOfItems
          ),
        );
      },
    );
  }

  _onUpdateCartItemQuantity(
    UpdateCartItemQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    final rowNumberOrFailure = await updateCartItemQuantity.call(
      cartItemId: event.cartItemId,
      quantity: event.quantity,
    );

    rowNumberOrFailure.fold(
      (failure) {
        emit(
          CartState(
            cartItemsStatus: CartItemsStatus.updateCartItemQuantityError,
            errorMessage: failure.message,
          ),
        );
      },
      (rowNumber) {
        emit(
          const CartState(
            cartItemsStatus: CartItemsStatus.cartItemQuantityUpdated,
          ),
        );
      },
    );
  }
}
