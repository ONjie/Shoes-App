import 'package:either_dart/either.dart';
import 'package:shoes_app/features/delivery_destination/domain/entities/delivery_destination_entity.dart';
import 'package:shoes_app/features/delivery_destination/domain/repositories/delivery_destination_repository.dart';

import '../../../../core/core.dart';


class FetchDeliveryDestinations{

  FetchDeliveryDestinations({required this.deliveryDestinationRepository});

  final DeliveryDestinationRepository deliveryDestinationRepository;

  Future<Either<Failure, List<DeliveryDestinationEntity>>> call()
  async => await deliveryDestinationRepository.fetchDeliveryDestinations();
}