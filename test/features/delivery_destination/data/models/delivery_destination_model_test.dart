import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shoes_app/features/delivery_destination/data/models/delivery_destination_model.dart';
import 'package:shoes_app/features/delivery_destination/domain/entities/delivery_destination_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tDeliveryDestinationModel = DeliveryDestinationModel(
    id: 1,
    name: 'name',
    country: 'country',
    city: 'city',
    contactNumber: 'contactNumber',
    googlePlusCode: 'googlePlusCode',
    updatedAt: DateTime.parse('2025-05-22T00:00:00'),
  );

  final tDeliveryDestinationEntity = DeliveryDestinationEntity(
    id: 1,
    name: 'name',
    country: 'country',
    city: 'city',
    contactNumber: 'contactNumber',
    googlePlusCode: 'googlePlusCode',
  );

  group('DeliveryDestinationModel', () {
    test('fromJson should return a valid model when successful', () async {
      //arrange
      final jsonMap =
          json.decode(fixture('delivery_destinations.json')) as List<dynamic>;

      //act
      final result = DeliveryDestinationModel.fromJson(jsonMap[0]);

      //assert
      expect(result, isA<DeliveryDestinationModel>());
      expect(result, equals(tDeliveryDestinationModel));
    });

    test(
      'toJson should return a JSON map containing the proper data',
      () async {
        //arrange
        final jsonMap =
            json.decode(fixture('delivery_destinations.json')) as List<dynamic>;

        //act
        final result = tDeliveryDestinationModel.toJson();

        //assert
        expect(result, isA<MapJson>());
        expect(result, equals(jsonMap[0]));
      },
    );

    test(
      'toDeliveryDestinationEntity should return a valid DeliveryDestinationEntity when successful',
      () async {
        //arrange&act
        final result = tDeliveryDestinationModel.toDeliveryDestinationEntity();

        //assert
        expect(result, isA<DeliveryDestinationEntity>());
        expect(result, equals(tDeliveryDestinationEntity));
      },
    );
  });
}
