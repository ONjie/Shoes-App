import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/delivery_destination/domain/entities/delivery_destination_entity.dart';
import 'package:shoes_app/features/delivery_destination/domain/repositories/delivery_destination_repository.dart';
import 'package:shoes_app/features/delivery_destination/domain/use_cases/add_delivery_destination.dart';

class MockDeliveryDestinationRepository extends Mock
    implements DeliveryDestinationRepository {}

void main() {
  late AddDeliveryDestination addDeliveryDestination;
  late MockDeliveryDestinationRepository mockDeliveryDestinationRepository;

  setUp(() {
    mockDeliveryDestinationRepository = MockDeliveryDestinationRepository();
    addDeliveryDestination = AddDeliveryDestination(
      deliveryDestinationRepository: mockDeliveryDestinationRepository,
    );
  });

  const tDeliveryDestination = DeliveryDestinationEntity(
    country: 'country',
    city: 'city',
    name: 'name',
    contactNumber: 'contactNumber',
    googlePlusCode: 'googlePlusCode',
  );

  test(
    'should return Right(true) when call to DeliveryDestinationRespository is succesful',
    () async {
      //arange
      when(
        () => mockDeliveryDestinationRepository.addDeliveryDestination(
          deliveryDestination: tDeliveryDestination,
        ),
      ).thenAnswer((_) async => Right(true));

      //act
      final result = await addDeliveryDestination.call(
        deliveryDestination: tDeliveryDestination,
      );

      //assert
      expect(result, isA<Right<Failure, bool>>());
      expect(result.right, equals(true));
      verify(
        () => mockDeliveryDestinationRepository.addDeliveryDestination(
          deliveryDestination: tDeliveryDestination,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockDeliveryDestinationRepository);
    },
  );
}
