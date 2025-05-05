import 'package:flutter/material.dart';

import '../../../features/shoes/domain/entities/shoe_entity.dart';
import '../../core.dart';

class ShoesListViewWidget extends StatelessWidget {
  const ShoesListViewWidget({super.key, required this.shoes});

  final List<ShoeEntity> shoes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: shoes.length,
        itemBuilder: (context, index) {
          return ShoeCardWidget(shoe: shoes[index],);
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          width: 10,
        ),
      ),
    );
  }
}
