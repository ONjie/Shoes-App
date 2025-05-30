part of 'delivery_destination_bloc.dart';

sealed class DeliveryDestinationEvent extends Equatable {}

class AddDeliveryDestinationEvent extends DeliveryDestinationEvent {
  final DeliveryDestinationEntity deliveryDestination;

  AddDeliveryDestinationEvent({required this.deliveryDestination});

  @override
  List<Object?> get props => [deliveryDestination];
}

class FetchDeliveryDestinationsEvent extends DeliveryDestinationEvent {
  @override
  List<Object?> get props => [];
}

class FetchDeliveryDestinationEvent extends DeliveryDestinationEvent {
  final int deliveryDestinationId;

  FetchDeliveryDestinationEvent({required this.deliveryDestinationId});

  @override
  List<Object?> get props => [deliveryDestinationId];
}

class DeleteDeliveryDestinationEvent extends DeliveryDestinationEvent {
  final int deliveryDestinationId;

  DeleteDeliveryDestinationEvent({required this.deliveryDestinationId});

  @override
  List<Object?> get props => [deliveryDestinationId];
}

class UpdateDeliveryDestinationEvent extends DeliveryDestinationEvent {
  final DeliveryDestinationEntity deliveryDestination;

  UpdateDeliveryDestinationEvent({required this.deliveryDestination});

  @override
  List<Object?> get props => [deliveryDestination];
}
