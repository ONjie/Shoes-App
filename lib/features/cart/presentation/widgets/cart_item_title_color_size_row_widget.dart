import 'package:flutter/material.dart';
import 'package:shoes_app/core/core.dart';


class CartItemTitleColorSizeRowWidget extends StatelessWidget {
  const CartItemTitleColorSizeRowWidget({
    super.key,
    required this.itemTitle,
    required this.itemColor,
    required this.itemSize,
  });

  final String itemTitle;
  final String itemColor;
  final int itemSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            itemTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
          ),
        ),
        colorAndSizeRow(context: context),
      ],
    );
  }

  Widget colorAndSizeRow({required BuildContext context}) {
    return Row(
      children: [
        CircleAvatar(
          radius: 11,
          backgroundColor: shoeColorConverterWidget(colorValue: itemColor)
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '-',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '$itemSize',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
        ),
      ],
    );
  }
}
