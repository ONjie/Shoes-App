import 'package:equatable/equatable.dart';

class FavoriteShoeEntity extends Equatable {
  const FavoriteShoeEntity({
    this.id,
    required this.shoeId,
    required this.title,
    required this.image,
    required this.price,
    required this.ratings,
    required this.isFavorite,
  });

  final int? id;
  final int shoeId;
  final String title;
  final String image;
  final double price;
  final double ratings;
  final bool isFavorite;

  @override
  List<Object?> get props => [
    id,
    shoeId,
    title,
    image,
    price,
    ratings,
    isFavorite,
  ];

  static final mockFavoriteShoes = [
    FavoriteShoeEntity(
      shoeId: 1,
      title: 'title',
      image: 'image',
      price: 100.00,
      ratings: 3.4,
      isFavorite: true,
    ),
    FavoriteShoeEntity(
      shoeId: 2,
      title: 'title',
      image: 'image',
      price: 100.00,
      ratings: 3.4,
      isFavorite: true,
    ),
    FavoriteShoeEntity(
      shoeId: 3,
      title: 'title',
      image: 'image',
      price: 100.00,
      ratings: 3.4,
      isFavorite: true,
    ),
    FavoriteShoeEntity(
      shoeId: 4,
      title: 'title',
      image: 'image',
      price: 100.00,
      ratings: 3.4,
      isFavorite: true,
    ),
     FavoriteShoeEntity(
      shoeId: 5,
      title: 'title',
      image: 'image',
      price: 100.00,
      ratings: 3.4,
      isFavorite: true,
    ),
     FavoriteShoeEntity(
      shoeId: 6,
      title: 'title',
      image: 'image',
      price: 100.00,
      ratings: 3.4,
      isFavorite: true,
    ),
  ];
}
