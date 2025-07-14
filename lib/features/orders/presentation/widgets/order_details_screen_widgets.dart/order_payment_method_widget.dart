import 'package:flutter/material.dart';

class OrderPaymentMethodWidget extends StatelessWidget {
  const OrderPaymentMethodWidget({super.key, required this.paymentMethod});

  final String paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment Method', style: Theme.of(context).textTheme.bodyMedium),
          Text(
            paymentMethod,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
