import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  const CartItemEntity({
    this.id,
    required this.shoeTitle,
    required this.image,
    required this.color,
    required this.price,
    required this.shoeSize,
    required this.quantity,
  });

  final int? id;
  final String shoeTitle;
  final String image;
  final String color;
  final double price;
  final int shoeSize;
  final int quantity;

  @override
  List<Object?> get props => [
    id,
    shoeTitle,
    image,
    color,
    price,
    shoeSize,
    quantity,
  ];

  static final mockCartItems = [
    CartItemEntity(
      shoeTitle: 'shoeTitle',
      image: 'image',
      color: 'ffffff',
      price: 100.00,
      shoeSize: 10,
      quantity: 1,
    ),
    CartItemEntity(
      shoeTitle: 'shoeTitle',
      image: 'image',
      color: 'ffffff',
      price: 100.00,
      shoeSize: 10,
      quantity: 1,
    ),
    CartItemEntity(
      shoeTitle: 'shoeTitle',
      image: 'image',
      color: 'ffffff',
      price: 100.00,
      shoeSize: 10,
      quantity: 1,
    ),
  ];
}
