import 'package:flutter/material.dart';

class ItemCountAndTotalShoesPriceRowWidget extends StatelessWidget {
  const ItemCountAndTotalShoesPriceRowWidget({
    super.key,
    required this.numberOfItems,
    required this.totalShoesPrice,
    required this.textColor,
  });

  final int numberOfItems;
  final int totalShoesPrice;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$numberOfItems Items',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: textColor),
        ),
        Text(
          '\$$totalShoesPrice',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: textColor),
        ),
      ],
    );
  }
}
