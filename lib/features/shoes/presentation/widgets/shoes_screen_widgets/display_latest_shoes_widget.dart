import 'package:flutter/material.dart';
import '../../../../../core/core.dart';
import '../../../domain/entities/shoe_entity.dart';


class DisplayLatestShoesWidget extends StatelessWidget {
  const DisplayLatestShoesWidget({super.key, required this.latestShoes});

  final List<ShoeEntity> latestShoes;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'New Collections',
          style:Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(
          height: 10,
        ),
        ShoesListViewWidget(
          shoes: latestShoes,
        ),
      ],
    );
  }
}
