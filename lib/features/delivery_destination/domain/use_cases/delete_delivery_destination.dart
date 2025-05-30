import 'package:either_dart/either.dart';
import 'package:shoes_app/features/delivery_destination/domain/repositories/delivery_destination_repository.dart';

import '../../../../core/core.dart';


class DeleteDeliveryDestination {
  DeleteDeliveryDestination({required this.deliveryDestinationRepository});

  final DeliveryDestinationRepository deliveryDestinationRepository;

  Future<Either<Failure, bool>> call({
    required int deliveryDestinationId,
  }) async => await deliveryDestinationRepository.deleteDeliveryDestination(
    deliveryDestinationId: deliveryDestinationId,
  );
}
