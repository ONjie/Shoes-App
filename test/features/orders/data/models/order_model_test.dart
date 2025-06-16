import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shoes_app/features/orders/data/models/order_model.dart';
import 'package:shoes_app/features/orders/data/models/ordered_item_model.dart';
import 'package:shoes_app/features/orders/domain/entities/order_entity.dart';
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

  final tOrderModel = OrderModel(
    id: 1,
    orderId: 1234,
    estimatedDeliveryDate: DateTime.parse('2025-05-22T00:00:00.000'),
    orderStatus: 'orderStatus',
    paymentMethod: 'paymentMethod',
    deliveryDestination: 'deliveryDestination',
    totalCost: 120.00,
    orderedItems: [tOrderedItemModel],
  );

  final tOrderEntity = OrderEntity(
    id: 1,
    orderId: 1234,
    estimatedDeliveryDate: DateTime.parse('2025-05-22T00:00:00.000'),
    orderStatus: 'orderStatus',
    paymentMethod: 'paymentMethod',
    deliveryDestination: 'deliveryDestination',
    totalCost: 120.00,
    orderedItems: [tOrderedItemEntity],
  );

  group('OrderModel', () {
    test('fromJson should return a valid model when successful', () async {
      //arrange
      final jsonMap =
          json.decode(fixture('orders.json')) as List<dynamic>;

      //act
      final result = OrderModel.fromJson(jsonMap[0]);

      //assert
      expect(result, isA<OrderModel>());
      expect(result, equals(tOrderModel));
    });
    test(
      'toJson should return a JSON map containing the proper data',
      () async {
        //arrange
        final expectedJson =
            json.decode(fixture('orders.json')) as List<dynamic>;

        //act
        final result = tOrderModel.toJson();

        //assert
        expect(result, isA<Map<String, dynamic>>());
        expect(result, equals(expectedJson[0]));
      },
    );
    test(
      'fromOrderEntity should return a valid model when successful',
      () async {
        //arrange & act
        final result = OrderModel.fromOrderEntity(
          tOrderEntity,
        );

        //assert
        expect(result, isA<OrderModel>());
        expect(result, equals(tOrderModel));
      },
    );
    test('toOrderEntity should return a valid model when successful', () {
      //arrange & act
      final result = tOrderModel.toOrderEntity();

      //assert
      expect(result, isA<OrderEntity>());
      expect(result, equals(tOrderEntity));
    });
  });
}
