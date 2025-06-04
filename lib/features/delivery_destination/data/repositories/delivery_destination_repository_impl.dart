import 'package:either_dart/either.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/delivery_destination/data/data_sources/remote_data/delivery_destination_remote_database_service.dart';
import 'package:shoes_app/features/delivery_destination/data/models/delivery_destination_model.dart';

import 'package:shoes_app/features/delivery_destination/domain/entities/delivery_destination_entity.dart';

import '../../domain/repositories/delivery_destination_repository.dart';

class DeliveryDestinationRepositoryImpl
    implements DeliveryDestinationRepository {
  DeliveryDestinationRepositoryImpl({
    required this.deliveryDestinationRemoteDatabaseService,
    required this.networkInfo,
  });

  final DeliveryDestinationRemoteDatabaseService
  deliveryDestinationRemoteDatabaseService;

  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, bool>> addDeliveryDestination({
    required DeliveryDestinationEntity deliveryDestination,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(
        InternetConnectionFailure(message: noInternetConnectionMessage),
      );
    }

    try {
      final deliveryDestinationModel = DeliveryDestinationModel(
        country: deliveryDestination.country,
        city: deliveryDestination.city,
        name: deliveryDestination.name,
        contactNumber: deliveryDestination.contactNumber,
        googlePlusCode: deliveryDestination.googlePlusCode,
      );

      await deliveryDestinationRemoteDatabaseService.addDeliveryDestination(
        deliveryDestination: deliveryDestinationModel,
      );
      return Right(true);
    } on SupabaseDatabaseException catch (e) {
      return Left(SupabaseDatabaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteDeliveryDestination({
    required int deliveryDestinationId,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(
        InternetConnectionFailure(message: noInternetConnectionMessage),
      );
    }

    try {
      await deliveryDestinationRemoteDatabaseService.deleteDeliveryDestination(
        deliveryDestinationId: deliveryDestinationId,
      );
      return Right(true);
    } on SupabaseDatabaseException catch (e) {
      return Left(SupabaseDatabaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, DeliveryDestinationEntity>> fetchDeliveryDestination({
    required int deliveryDestinationId,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(
        InternetConnectionFailure(message: noInternetConnectionMessage),
      );
    }

    try {
      final result = await deliveryDestinationRemoteDatabaseService
          .fetchDeliveryDestination(
            deliveryDestinationId: deliveryDestinationId,
          );
      return Right(result.toDeliveryDestinationEntity());
    } on SupabaseDatabaseException catch (e) {
      return Left(SupabaseDatabaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<DeliveryDestinationEntity>>>
  fetchDeliveryDestinations() async {
    if (!await networkInfo.isConnected) {
      return Left(
        InternetConnectionFailure(message: noInternetConnectionMessage),
      );
    }

    try {
      final results =
          await deliveryDestinationRemoteDatabaseService
              .fetchDeliveryDestinations();

      final deliveryDestinations =
          results.map((e) => e.toDeliveryDestinationEntity()).toList();
      return Right(deliveryDestinations);
    } on SupabaseDatabaseException catch (e) {
      return Left(SupabaseDatabaseFailure(message: e.message));
    } on OtherExceptions catch (e) {
      return Left(OtherFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> updateDeliveryDestination({
    required DeliveryDestinationEntity deliveryDestination,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(
        InternetConnectionFailure(message: noInternetConnectionMessage),
      );
    }

    try {
      final deliveryDestinationModel = DeliveryDestinationModel(
        id: deliveryDestination.id,
        country: deliveryDestination.country,
        city: deliveryDestination.city,
        name: deliveryDestination.name,
        contactNumber: deliveryDestination.contactNumber,
        googlePlusCode: deliveryDestination.googlePlusCode,
      );

      await deliveryDestinationRemoteDatabaseService.updateDeliveryDestination(
        deliveryDestination: deliveryDestinationModel,
      );

      return Right(true);
    } on SupabaseDatabaseException catch (e) {
      return Left(SupabaseDatabaseFailure(message: e.message));
    }
  }
}
