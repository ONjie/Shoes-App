import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart_bloc.dart';
import '../../domain/entities/cart_item_entity.dart';
import 'cart_item_increase_decrease_quantity_card_widget.dart';


class CartItemQuantityRowWidget extends StatefulWidget {
  const CartItemQuantityRowWidget({
    super.key,
    required this.cartItem,
  });

  final CartItemEntity cartItem;

  @override
  State<CartItemQuantityRowWidget> createState() =>
      _CartItemQuantityRowWidgetState();
}

class _CartItemQuantityRowWidgetState extends State<CartItemQuantityRowWidget> {
  late int quantity = widget.cartItem.quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        decreaseQuantity(),
        const SizedBox(
          width: 5,
        ),
        Text(
          '${widget.cartItem.quantity}',
          style: Theme.of(context).textTheme.bodyMedium
        ),
        const SizedBox(
          width: 5,
        ),
        increaseQuantity(),
      ],
    );
  }

  Widget increaseQuantity() {
    return GestureDetector(
      onTap: () {
        setState(() {
          quantity = widget.cartItem.quantity + 1;
        });

        BlocProvider.of<CartBloc>(context).add(
          UpdateCartItemQuantityEvent(cartItemId: widget.cartItem.id!,
            quantity: quantity,
          ),
        );
      },
      child: const IncreaseDecreaseCartItemQuantityCardWidget(sign: '+'),
    );
  }

  Widget decreaseQuantity() {
    return GestureDetector(
      onTap: () {
        if (widget.cartItem.quantity > 1) {
          setState(() {
            quantity = widget.cartItem.quantity - 1;
          });
        }

        BlocProvider.of<CartBloc>(context).add(
          UpdateCartItemQuantityEvent(cartItemId: widget.cartItem.id!,
              quantity: quantity,
          ),
        );
      },
      child: const IncreaseDecreaseCartItemQuantityCardWidget(sign: '-'),
    );
  }
}
