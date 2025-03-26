import 'dart:convert';

import 'package:shoes_api/src/shoes/models/shoe.dart';
import 'package:shoes_api/src/shoes/models/shoe_data.dart';
import 'package:test/test.dart';

import '../../../fixtures/fixture_reader.dart';

  void main() async {
  group('Shoe', () {
    const tShoe = Shoe(
      id: 1,
      title: 'Title',
      description: 'Description',
      images: ['image1', 'image2', 'image3'],
      price: 100,
      brand: 'Shoe',
      colors: ['color1', 'color2', 'color3'],
      sizes: [1, 2, 3, 4, 5],
      isPopular: true,
      isNew: true,
      category: 'Men',
      ratings: 1.5,
    );

   
    test('fromJson should return a valid model when successful', () async {
      //arrange
      final jsonMap =
          json.decode(fixture('shoes_data.json')) as Map<String, dynamic>;

      //act
      final result = ShoesData.fromJson(jsonMap);

      //assert
      expect(result, isA<ShoesData>());
      expect(result.shoesData, equals([tShoe, tShoe]));
    });

  });
}