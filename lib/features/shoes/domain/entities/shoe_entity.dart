import 'package:equatable/equatable.dart';

class ShoeEntity extends Equatable{

  const ShoeEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.price,
    required this.brand,
    required this.colors,
    required this.sizes,
    required this.isPopular,
    required this.isNew,
    required this.ratings,
    required this.category,
    required this.isFavorite,
});

  final int id;
  final String title;
  final String description;
  final List<String> images;
  final double price;
  final String brand;
  final List<String> colors;
  final List<int> sizes;
  final bool isPopular;
  final bool isNew;
  final String category;
  final double ratings;
  final bool isFavorite;



  @override
  List<Object?> get props => [
    id,
    title,
    description,
    images,
    price,
    brand,
    colors,
    sizes,
    isPopular,
    isNew,
    category,
    ratings,
    isFavorite
  ];
}