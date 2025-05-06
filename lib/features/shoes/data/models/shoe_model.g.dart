// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoeModel _$ShoeModelFromJson(Map<String, dynamic> json) => ShoeModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  price: (json['price'] as num).toDouble(),
  brand: json['brand'] as String,
  colors: (json['colors'] as List<dynamic>).map((e) => e as String).toList(),
  sizes:
      (json['sizes'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
  isPopular: json['isPopular'] as bool,
  isNew: json['isNew'] as bool,
  ratings: (json['ratings'] as num).toDouble(),
  category: json['category'] as String,
  isFavorite: json['isFavorite'] as bool? ?? false,
);

Map<String, dynamic> _$ShoeModelToJson(ShoeModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'images': instance.images,
  'price': instance.price,
  'brand': instance.brand,
  'colors': instance.colors,
  'sizes': instance.sizes,
  'isPopular': instance.isPopular,
  'isNew': instance.isNew,
  'category': instance.category,
  'ratings': instance.ratings,
  'isFavorite': instance.isFavorite,
};
