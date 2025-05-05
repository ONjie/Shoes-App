import 'package:flutter/material.dart';

import '../../../features/shoes/domain/entities/shoe_entity.dart';
import '../../core.dart';


class ShoeCardWidget extends StatelessWidget {
  const ShoeCardWidget({super.key, required this.shoe,});

  final ShoeEntity shoe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       
      },
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ShoeImageWidget(
                  imageUrl: shoe.images[0],
                  width: 170,
                  height: 170,
                  topRightRadius: 15,
                  topLeftRadius: 15,
                  bottomRightRadius: 0,
                  bottomLeftRadius: 0,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: FavoriteIconWidget(shoe: shoe),
                ),
              ]
            ),
            Expanded(
              child: ShoeTitleAndPriceWidget(shoeTitle: shoe.title, shoePrice: shoe.price,)
            ),
          ],
        ),
      ),
    );
  }
}
