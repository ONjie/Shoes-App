import 'package:flutter/material.dart';


class TotalCostRowWidget extends StatelessWidget {
  const TotalCostRowWidget({super.key, required this.totalCost, required this.textColor});

  final int totalCost;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Total:',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor),
        ),
        Text(
          '\$$totalCost',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor),
        ),
      ],
    );
  }
}
