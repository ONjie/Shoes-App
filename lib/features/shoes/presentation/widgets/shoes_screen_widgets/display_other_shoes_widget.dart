import 'package:flutter/material.dart';
import '../../../../../core/core.dart';
import '../../../domain/entities/shoe_entity.dart';


class DisplayOtherShoesWidget extends StatelessWidget {
  const DisplayOtherShoesWidget({super.key, required this.otherShoes});

  final List<ShoeEntity> otherShoes;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'More Collections',
          style: Theme.of(context).textTheme.labelLarge
        ),
        const SizedBox(
          height: 10,
        ),
        ShoesListViewWidget(
          shoes: otherShoes,
        ),
      ],
    );
  }
}
