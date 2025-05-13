import 'package:flutter/material.dart';

class DeliveryChargeRowWidget extends StatelessWidget {
  const DeliveryChargeRowWidget({super.key, required this.deliveryCharge, required this.textColor});

  final int deliveryCharge;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Delivery charge:',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor),
        ),
        Text(
          '\$$deliveryCharge',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor),
        ),
      ],
    );
  }
}
