import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'shoe.g.dart';

@JsonSerializable()
class Shoe extends Equatable {
  const Shoe({
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
    required this.category,
    required this.ratings,
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

  static Shoe fromJson(Map<String, dynamic> json) => _$ShoeFromJson(json);

  Map<String, dynamic> toJson() => _$ShoeToJson(this);

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
      ];
}