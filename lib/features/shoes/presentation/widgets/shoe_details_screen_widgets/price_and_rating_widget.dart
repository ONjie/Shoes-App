import 'package:flutter/material.dart';

class PriceAndRatingWidget extends StatelessWidget {
  const PriceAndRatingWidget({super.key, required this.price, required this.ratings});

  final int price;
  final double ratings;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '\$$price',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            Icon(
              Icons.star,
              color: Theme.of(context).colorScheme.outline,
              size: 23,
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              "$ratings",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
