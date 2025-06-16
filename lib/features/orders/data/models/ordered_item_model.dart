import 'package:equatable/equatable.dart';

import '../../domain/entities/ordered_item_entity.dart';

typedef MapJson = Map<String, dynamic>;

class OrderedItemModel extends Equatable {
  const OrderedItemModel({
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

  static OrderedItemModel fromJson(MapJson json) => OrderedItemModel(
    title: json['title'] as String,
    image: json['image'] as String,
    color: json['color'] as String,
    price: json['price'] as double,
    size: json['size'] as int,
    quantity: json['quantity'] as int,
  );

  MapJson toJson() => {
    "title": title,
    "image": image,
    "color": color,
    "price": price,
    "size": size,
    "quantity": quantity,
  };

  static OrderedItemModel fromOrderedItemEntity(
    OrderedItemEntity orderedItemEntity,
  ) => OrderedItemModel(
    title: orderedItemEntity.title,
    image: orderedItemEntity.image,
    color: orderedItemEntity.color,
    price: orderedItemEntity.price,
    size: orderedItemEntity.size,
    quantity: orderedItemEntity.quantity,
  );

  OrderedItemEntity toOrderedItemEntity() => OrderedItemEntity(
    title: title,
    image: image,
    color: color,
    price: price,
    size: size,
    quantity: quantity,
  );

  @override
  List<Object?> get props => [title, image, color, price, size, quantity];
}
