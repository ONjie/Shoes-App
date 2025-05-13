import 'package:flutter/material.dart';
import '../../domain/entities/cart_item_entity.dart';
import 'cart_item_quantity_row_widget.dart';


class CartItemQuantityPriceRowWidget extends StatelessWidget {
  const CartItemQuantityPriceRowWidget({super.key, required this.cartItem,});

  final CartItemEntity cartItem;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CartItemQuantityRowWidget(cartItem: cartItem,),
        Text(
          '\$${cartItem.price.toInt()}',
          style: Theme.of(context).textTheme.bodyMedium
        ),
      ],
    );
  }
}
