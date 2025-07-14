import 'package:equatable/equatable.dart';

class ShoeEntity extends Equatable {
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
    isFavorite,
  ];

  static final mockShoes = [
    ShoeEntity(
      id: 1,
      title: 'title',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      images: ['image', 'image', 'image', 'image'],
      price: 100.00,
      brand: 'brand',
      colors: ['ffffff', 'ffffff', 'ffffff'],
      sizes: [1, 2, 3, 4, 5],
      isPopular: false,
      isNew: false,
      ratings: 3.4,
      category: 'category',
      isFavorite: false,
    ),
    ShoeEntity(
      id: 2,
      title: 'title',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      images: ['image', 'image', 'image', 'image'],
      price: 100.00,
      brand: 'brand',
      colors: ['ffffff', 'ffffff', 'ffffff'],
      sizes: [1, 2, 3, 4, 5],
      isPopular: false,
      isNew: false,
      ratings: 3.4,
      category: 'category',
      isFavorite: false,
    ),
    ShoeEntity(
      id: 3,
      title: 'title',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      images: ['image', 'image', 'image', 'image'],
      price: 100.00,
      brand: 'brand',
      colors: ['ffffff', 'ffffff', 'ffffff'],
      sizes: [1, 2, 3, 4, 5],
      isPopular: false,
      isNew: false,
      ratings: 3.4,
      category: 'category',
      isFavorite: false,
    ),
    ShoeEntity(
      id: 4,
      title: 'title',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      images: ['image', 'image', 'image', 'image'],
      price: 100.00,
      brand: 'brand',
      colors: ['ffffff', 'ffffff', 'ffffff'],
      sizes: [1, 2, 3, 4, 5],
      isPopular: false,
      isNew: false,
      ratings: 3.4,
      category: 'category',
      isFavorite: false,
    ),
     ShoeEntity(
      id: 5,
      title: 'title',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      images: ['image', 'image', 'image', 'image'],
      price: 100.00,
      brand: 'brand',
      colors: ['ffffff', 'ffffff', 'ffffff'],
      sizes: [1, 2, 3, 4, 5],
      isPopular: false,
      isNew: false,
      ratings: 3.4,
      category: 'category',
      isFavorite: false,
    ),
     ShoeEntity(
      id: 6,
      title: 'title',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      images: ['image', 'image', 'image', 'image'],
      price: 100.00,
      brand: 'brand',
      colors: ['ffffff', 'ffffff', 'ffffff'],
      sizes: [1, 2, 3, 4, 5],
      isPopular: false,
      isNew: false,
      ratings: 3.4,
      category: 'category',
      isFavorite: false,
    ),
  ];
}
