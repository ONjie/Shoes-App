import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shoes_app/features/shoes/data/models/shoe_model.dart';
import 'package:shoes_app/features/shoes/domain/entities/shoe_entity.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  group('ShoeModel', () {
    const tShoeModel = ShoeModel(
      id: 1,
      title: 'title',
      description: 'description',
      images: ['image1', 'image2', 'image3'],
      price: 100,
      brand: 'brand',
      colors: ['color1', 'color2', 'color3'],
      sizes: [1, 2, 3, 4, 5],
      isPopular: true,
      isNew: true,
      category: 'category',
      ratings: 1.5,
      isFavorite: false,
    );

    const tShoeEntity = ShoeEntity(
      id: 1,
      title: 'title',
      description: 'description',
      images: ['image1', 'image2', 'image3'],
      price: 100,
      brand: 'brand',
      colors: ['color1', 'color2', 'color3'],
      sizes: [1, 2, 3, 4, 5],
      isPopular: true,
      isNew: true,
      category: 'category',
      ratings: 1.5,
      isFavorite: false,
    );

    test('fromJson should return a valid model when successful', () async {
      //arrange
      final jsonMap = json.decode(fixture('shoes.json')) as List<dynamic>;

      //act
      final result = ShoeModel.fromJson(jsonMap[0]);

      //assert
      expect(result, isA<ShoeModel>());
      expect(result, tShoeModel);
    });

    test('toShoeEntity should return a valid ShoeEntity', () async {
      //arrange & act
      final result = tShoeModel.toShoeEntity();

      //assert
      expect(result, isA<ShoeEntity>());
      expect(result, tShoeEntity);
    });

    test('fromShoeEntity should return a valid ShoeModel', () async {
      //arrange & act
      final result = ShoeModel.fromShoeEntity(shoeEntity: tShoeEntity);

      //assert
      expect(result, isA<ShoeModel>());
      expect(result, tShoeModel);
    });
  });
}
