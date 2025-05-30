part of 'delivery_destination_bloc.dart';

enum DeliveryDestinationStatus {
  initial,
  loading,
  deliveryDestinationAdded,
  addDeliveryDestinationError,
  deliveryDestinationFetched,
  fetchDeliveryDestinationError,
  deliveryDestinationsFetched,
  fetchDeliveryDestinationsError,
  deliveryDestinationUpdated,
  updateDeliveryDestinationError,
  deliveryDestinationDeleted,
  deleteDeliveryDestinationError,
}

class DeliveryDestinationState extends Equatable {
  const DeliveryDestinationState({
    required this.deliveryDestinationStatus,
    this.deliveryDestinations,
    this.deliveryDestination,
    this.message
  });

  final DeliveryDestinationStatus deliveryDestinationStatus;
  final List<DeliveryDestinationEntity>? deliveryDestinations;
  final DeliveryDestinationEntity? deliveryDestination;
  final String? message;

  @override
  List<Object?> get props => [
    deliveryDestinationStatus,
    deliveryDestinations,
    deliveryDestination,
    message,
  ];
}

