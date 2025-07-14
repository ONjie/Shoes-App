import 'package:flutter/material.dart';
import 'package:shoes_app/features/orders/domain/entities/ordered_item_entity.dart';

import '../../../../../core/core.dart';

class OrderedItemCardWidget extends StatelessWidget {
  const OrderedItemCardWidget({super.key, required this.orderedItem});

  final OrderedItemEntity orderedItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      child: Row(
        children: [
          ShoeImageWidget(
            imageUrl: orderedItem.image,
            width: 100,
            height: 100,
            topRightRadius: 0,
            topLeftRadius: 0,
            bottomRightRadius: 0,
            bottomLeftRadius: 0,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildShoeTitleAndQuantityWidget(context: context),
                const SizedBox(height: 3),
                buildPriceAndColorWidget(context: context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildShoeTitleAndQuantityWidget({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                orderedItem.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Text(
              'Size: ${orderedItem.size}',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: 18),
            ),
          ],
        ),
        Text(
          'x${orderedItem.quantity}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
        ),
      ],
    );
  }

  Widget buildPriceAndColorWidget({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '\$${orderedItem.price.toInt()}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
        ),
        CircleAvatar(
          radius: 12,
          backgroundColor: shoeColorConverterWidget(
            colorValue: orderedItem.color,
          ),
        ),
      ],
    );
  }
}
