import 'package:shoes_api/src/shoes/models/shoe.dart';

class ShoesData {

  ShoesData({
    required this.shoesData,
  });

  factory ShoesData.fromJson(Map<String, dynamic> json) {
    return ShoesData(
      shoesData: (json['shoes_data'] as List<dynamic>)
          .map((shoe) => Shoe.fromJson(shoe as Map<String, dynamic>))
          .toList(),
    );
  }
  final List<Shoe> shoesData;
}
