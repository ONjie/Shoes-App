import 'package:equatable/equatable.dart';

class OrderedItemEntity extends Equatable{

  const OrderedItemEntity({
    required this.title,
    required this.image,
    required this.color,
    required this.price,
    required this.size,
    required this.quantity,
  });

  final String title;
  final String image;
  final String color;
  final double price;
  final int size;
  final int quantity;

  @override
  List<Object?> get props => [
    title,
    image,
    color,
    price,
    size,
    quantity
  ];



}