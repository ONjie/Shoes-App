import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/shoe_entity.dart';



part 'shoe_model.g.dart';

@JsonSerializable()

class ShoeModel extends Equatable{
  const ShoeModel({
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
     this.isFavorite = false,
  });

  final int id;
  final String title;
  final String description;
  final List<String> images;
  final double price;
  final String  brand;
  final List<String> colors;
  final List<int> sizes;
  final bool isPopular;
  final bool isNew;
  final String category;
  final double ratings;
  final bool? isFavorite;

 ShoeModel copyWith({
    int? id,
    String? title,
    String? description,
    List<String>? images,
    double? price,
    String?  brand,
    List<String>? colors,
    List<int>? sizes,
    bool? isPopular,
    bool? isNew,
    String? category,
    double? ratings,
    bool? isFavorite,
}){
   return ShoeModel(
       id: id ?? this.id,
       title: title ?? this.title,
       description: description ?? this.description,
       images: images ?? this.images,
       price: price ?? this.price,
       brand: brand ?? this.brand,
       colors: colors ?? this.colors,
       sizes: sizes ?? this.sizes,
       isPopular: isPopular ?? this.isPopular,
       isNew: isNew ?? this.isNew,
       ratings: ratings ?? this.ratings,
       category: category ?? this.category,
       isFavorite: isFavorite ?? this.isFavorite,
   );
 }

  static ShoeModel fromJson(Map<String, dynamic> json) => _$ShoeModelFromJson(json);

  ShoeEntity toShoeEntity() => ShoeEntity(
  id: id,
  title: title,
  description: description,
  images: images,
  price: price,
  brand: brand,
  colors: colors,
  sizes: sizes,
  isPopular: isPopular,
  isNew: isNew,
  ratings: ratings,
  category: category,
  isFavorite: isFavorite!,
  );

 static ShoeModel fromShoeEntity({required ShoeEntity shoeEntity}) => ShoeModel(
          id: shoeEntity.id,
          title: shoeEntity.title,
          description: shoeEntity.description,
          images: shoeEntity.images,
          price: shoeEntity.price,
          brand: shoeEntity.brand,
          colors: shoeEntity.colors,
          sizes: shoeEntity.sizes,
          isPopular: shoeEntity.isPopular,
          isNew: shoeEntity.isNew,
          ratings: shoeEntity.ratings,
          category: shoeEntity.category,
          isFavorite: shoeEntity.isFavorite,
      );

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

}