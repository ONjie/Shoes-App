import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/delivery_destination/domain/entities/delivery_destination_entity.dart';
import 'package:shoes_app/features/delivery_destination/domain/repositories/delivery_destination_repository.dart';
import 'package:shoes_app/features/delivery_destination/domain/use_cases/fetch_delivery_destinations.dart';

class MockDeliveryDestinationRepository extends Mock
    implements DeliveryDestinationRepository {}

void main() {
  late FetchDeliveryDestinations fetchDeliveryDestinations;
  late MockDeliveryDestinationRepository mockDeliveryDestinationRepository;

  setUp(() {
    mockDeliveryDestinationRepository = MockDeliveryDestinationRepository();
    fetchDeliveryDestinations = FetchDeliveryDestinations(
      deliveryDestinationRepository: mockDeliveryDestinationRepository,
    );
  });

  const tDeliveryDestination = DeliveryDestinationEntity(
    id: 1,
    country: 'country',
    city: 'city',
    name: 'name',
    contactNumber: 'contactNumber',
    googlePlusCode: 'googlePlusCode',
  );


  test(
    'should return Right(List<DeliveryDestination>) when call to DeliveryDestinationRespository is succesful',
    () async {
      //arange
      when(
        () => mockDeliveryDestinationRepository.fetchDeliveryDestinations(),
      ).thenAnswer((_) async => Right([tDeliveryDestination]));

      //act
      final result = await fetchDeliveryDestinations.call();

      //assert
      expect(result, isA<Right<Failure, List<DeliveryDestinationEntity>>>());
      expect(result.right, equals([tDeliveryDestination]));
      verify(
        () => mockDeliveryDestinationRepository.fetchDeliveryDestinations(),
      ).called(1);
      verifyNoMoreInteractions(mockDeliveryDestinationRepository);
    },
  );
}
