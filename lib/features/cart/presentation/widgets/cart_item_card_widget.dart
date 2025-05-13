import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../domain/entities/cart_item_entity.dart';
import 'cart_item_quantity_price_row_widget.dart';
import 'cart_item_title_color_size_row_widget.dart';

class CartItemCardWidget extends StatelessWidget {
  const CartItemCardWidget({super.key, required this.cartItem});

  final CartItemEntity cartItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ShoeImageWidget(
                imageUrl: cartItem.image,
                width: 90,
                height: 90,
                topRightRadius: 8,
                topLeftRadius: 8,
                bottomRightRadius: 8,
                bottomLeftRadius: 8,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: cartItemDetailsColumnWidget(cartItem: cartItem),
              ),
            ],
          ),
        ),
      ),
    );
  }

Widget cartItemDetailsColumnWidget({required CartItemEntity cartItem}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CartItemTitleColorSizeRowWidget(
        itemTitle: cartItem.shoeTitle,
        itemColor: cartItem.color,
        itemSize: cartItem.shoeSize,
      ),
      const SizedBox(
        height: 3,
      ),
     CartItemQuantityPriceRowWidget(cartItem: cartItem),
    ],
  );
}
}
