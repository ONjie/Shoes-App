import 'package:either_dart/either.dart';
import 'package:shoes_app/features/delivery_destination/domain/entities/delivery_destination_entity.dart';

import '../../../../core/core.dart';

abstract class DeliveryDestinationRepository {
  Future<Either<Failure, List<DeliveryDestinationEntity>>>
  fetchDeliveryDestinations();

  Future<Either<Failure, bool>> addDeliveryDestination({
    required DeliveryDestinationEntity deliveryDestination,
  });

  Future<Either<Failure, bool>> updateDeliveryDestination({
    required DeliveryDestinationEntity deliveryDestination,
  });

  Future<Either<Failure, bool>> deleteDeliveryDestination({
    required int deliveryDestinationId,
  });
}
