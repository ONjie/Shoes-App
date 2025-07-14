import 'package:flutter/material.dart';

import '../../../domain/entities/favorite_shoe_entity.dart';
import 'favorite_shoe_card.dart';

class FavoriteShoesGridViewWidget extends StatelessWidget {
  const FavoriteShoesGridViewWidget({
    super.key,
    required this.favoriteShoes,
  });

  final List<FavoriteShoeEntity> favoriteShoes;
 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: favoriteShoes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 5,
        ),
        itemBuilder: (context, index) {
          return FavoriteShoeCard(favoriteShoe: favoriteShoes[index]);
        },
      ),
    );
  }
}
