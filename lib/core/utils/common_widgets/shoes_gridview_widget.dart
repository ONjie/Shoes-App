import 'package:flutter/material.dart';

import '../../../features/shoes/domain/entities/shoe_entity.dart';
import '../../core.dart';

class ShoesGridViewWidget extends StatelessWidget {
  const ShoesGridViewWidget({super.key, required this.shoes});

  final List<ShoeEntity> shoes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: shoes.length,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 5,
        ),
        itemBuilder: (context, index) {
          return ShoeCardWidget(shoe: shoes[index]);
        },
      ),
    );
  }
}
