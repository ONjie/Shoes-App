import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';
import '../../../domain/entities/favorite_shoe_entity.dart';
import 'favorite_shoe_favorite_icon_widget.dart';

class FavoriteShoeCard extends StatelessWidget {
  const FavoriteShoeCard({super.key, required this.favoriteShoe});

  final FavoriteShoeEntity favoriteShoe;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go('/shoe_details/${favoriteShoe.shoeId}');
      },
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Stack(
              children: [
                ShoeImageWidget(
                  imageUrl: favoriteShoe.image,
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
                  child: FavoriteShoeFavoriteIconWidget(
                    favoriteShoe: favoriteShoe,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ShoeTitleAndPriceWidget(
                shoeTitle: favoriteShoe.title,
                shoePrice: favoriteShoe.price,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
