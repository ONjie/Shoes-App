import 'package:flutter/material.dart';

import '../../../domain/entities/favorite_shoe_entity.dart';
import 'favorite_shoe_card.dart';

class FavoriteShoesGridViewWidget extends StatelessWidget {
  const FavoriteShoesGridViewWidget({
    super.key,
    required this.favoriteShoes,
    required this.screenHeight,
    required this.screenWidth,
  });

  final List<FavoriteShoeEntity> favoriteShoes;
  final double screenHeight;
  final double screenWidth;

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
            crossAxisSpacing: 2,
            mainAxisSpacing: 4,
            childAspectRatio: screenWidth / (screenHeight / 1.4),
        ),
        itemBuilder: (context, index){
          return FavoriteShoeCard(favoriteShoe: favoriteShoes[index],);
        },
      ),
    );
  }
}
