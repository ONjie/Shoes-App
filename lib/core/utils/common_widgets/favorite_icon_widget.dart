import 'package:flutter/material.dart';
import '../../../features/shoes/domain/entities/shoe_entity.dart';



class FavoriteIconWidget extends StatefulWidget {
  const FavoriteIconWidget({super.key, required this.shoe,});

  final ShoeEntity shoe;

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  late bool isFavorite = false;

  @override
  void initState() {
    isFavorite = widget.shoe.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
       /* BlocProvider.of<ShoesBloc>(context).add(isFavorite ?
        DeleteShoeFromFavoriteShoesEvent(shoeId: widget.shoe.id)
            :
        AddShoeToFavoriteShoesEvent(shoe: widget.shoe)
        );
        setState(() {
          isFavorite = !isFavorite;
        });*/
      },
      icon: Icon(
        isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
        size: 30,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
