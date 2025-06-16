import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shoes_app/features/orders/data/models/ordered_item_model.dart';
import 'package:shoes_app/features/orders/domain/entities/ordered_item_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tOrderedItemModel = OrderedItemModel(
    title: 'title',
    image: 'image',
    color: 'color',
    price: 100.00,
    size: 10,
    quantity: 1,
  );

  const tOrderedItemEntity = OrderedItemEntity(
    title: 'title',
    image: 'image',
    color: 'color',
    price: 100.00,
    size: 10,
    quantity: 1,
  );

  group('OrderedItemModel', () {
    test('fromJson should return a valid model when successful', () async {
      //arrange
      final jsonMap =
          json.decode(fixture('ordered_items.json')) as List<dynamic>;

      //act
      final result = OrderedItemModel.fromJson(jsonMap[0]);

      //assert
      expect(result, isA<OrderedItemModel>());
      expect(result, equals(tOrderedItemModel));
    });
    test(
      'toJson should return a JSON map containing the proper data',
      () async {
        //arrange
        final expectedJson =
            json.decode(fixture('ordered_items.json')) as List<dynamic>;

        //act
        final result = tOrderedItemModel.toJson();

        //assert
        expect(result, isA<Map<String, dynamic>>());
        expect(result, equals(expectedJson[0]));
      },
    );
    test(
      'fromOrderedItemEntity should return a valid model when successful',
      () async {
        //arrange & act
        final result = OrderedItemModel.fromOrderedItemEntity(
          tOrderedItemEntity,
        );

        //assert
        expect(result, isA<OrderedItemModel>());
        expect(result, equals(tOrderedItemModel));
      },
    );
    test('toOrderedItemEntity should return a valid model when successful', () {
      //arrange & act
      final result = tOrderedItemModel.toOrderedItemEntity();

      //assert
      expect(result, isA<OrderedItemEntity>());
      expect(result, equals(tOrderedItemEntity));
    });
  });
}
