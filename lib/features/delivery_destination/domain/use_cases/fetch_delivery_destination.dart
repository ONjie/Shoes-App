import 'package:either_dart/either.dart';
import 'package:shoes_app/features/delivery_destination/domain/entities/delivery_destination_entity.dart';
import 'package:shoes_app/features/delivery_destination/domain/repositories/delivery_destination_repository.dart';

import '../../../../core/core.dart';

class FetchDeliveryDestination {
  FetchDeliveryDestination({required this.deliveryDestinationRepository});

  final DeliveryDestinationRepository deliveryDestinationRepository;

  Future<Either<Failure, DeliveryDestinationEntity>> call({
    required int deliveryDestinationId,
  }) async => await deliveryDestinationRepository.fetchDeliveryDestination(
    deliveryDestinationId: deliveryDestinationId,
  );
}
