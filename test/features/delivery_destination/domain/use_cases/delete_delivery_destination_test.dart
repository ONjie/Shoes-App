import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/delivery_destination/domain/repositories/delivery_destination_repository.dart';
import 'package:shoes_app/features/delivery_destination/domain/use_cases/delete_delivery_destination.dart';

class MockDeliveryDestinationRepository extends Mock
    implements DeliveryDestinationRepository {}

void main() {
  late DeleteDeliveryDestination deleteDeliveryDestination;
  late MockDeliveryDestinationRepository mockDeliveryDestinationRepository;

  setUp(() {
    mockDeliveryDestinationRepository = MockDeliveryDestinationRepository();
    deleteDeliveryDestination = DeleteDeliveryDestination(
      deliveryDestinationRepository: mockDeliveryDestinationRepository,
    );
  });

  
  const tDeliveryDestinationId = 1;

  test(
    'should return Right(true) when call to DeliveryDestinationRespository is succesful',
    () async {
      //arange
      when(
        () => mockDeliveryDestinationRepository.deleteDeliveryDestination(
          deliveryDestinationId: any(named: 'deliveryDestinationId'),
        ),
      ).thenAnswer((_) async => Right(true));

      //act
      final result = await deleteDeliveryDestination(
        deliveryDestinationId: tDeliveryDestinationId,
      );

      //assert
      expect(result, isA<Right<Failure, bool>>());
      expect(result.right, equals(true));
      verify(
        () => mockDeliveryDestinationRepository.deleteDeliveryDestination(
          deliveryDestinationId: any(named: 'deliveryDestinationId'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockDeliveryDestinationRepository);
    },
  );
}
