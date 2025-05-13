import 'package:flutter/material.dart';


class IncreaseDecreaseCartItemQuantityCardWidget extends StatelessWidget {
  const IncreaseDecreaseCartItemQuantityCardWidget({super.key, required this.sign});

  final String sign;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          sign,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}

