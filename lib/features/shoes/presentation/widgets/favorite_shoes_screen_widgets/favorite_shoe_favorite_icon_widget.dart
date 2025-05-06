import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/favorite_shoe_entity.dart';
import '../../bloc/shoes_bloc.dart';


class FavoriteShoeFavoriteIconWidget extends StatefulWidget {
  const FavoriteShoeFavoriteIconWidget({super.key, required this.favoriteShoe});

  final FavoriteShoeEntity favoriteShoe;

  @override
  State<FavoriteShoeFavoriteIconWidget> createState() => _FavoriteShoeFavoriteIconWidgetState();
}

class _FavoriteShoeFavoriteIconWidgetState extends State<FavoriteShoeFavoriteIconWidget> {

 late bool isFavorite = false;

    @override
    void initState() {
      isFavorite = widget.favoriteShoe.isFavorite;
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return IconButton(
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
          BlocProvider.of<ShoesBloc>(context).add(DeleteShoeFromFavoriteShoesEvent(shoeId: widget.favoriteShoe.shoeId));
          BlocProvider.of<ShoesBloc>(context).add(FetchFavoriteShoesEvent());
        },
        icon: Icon(
          isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          size: 30,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
  }
}
