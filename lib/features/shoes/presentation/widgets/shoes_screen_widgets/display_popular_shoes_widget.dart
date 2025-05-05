import 'package:flutter/material.dart';
import '../../../../../core/core.dart';
import '../../../domain/entities/shoe_entity.dart';



class DisplayPopularShoesWidget extends StatelessWidget {
  const DisplayPopularShoesWidget({super.key, required this.popularShoes});

  final List<ShoeEntity> popularShoes;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Most Popular',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(
          height: 10,
        ),
        ShoesListViewWidget(
          shoes: popularShoes,
        ),
      ],
    );
  }
}
