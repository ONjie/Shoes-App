import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/delivery_destination/domain/use_cases/add_delivery_destination.dart';
import 'package:shoes_app/features/delivery_destination/domain/use_cases/delete_delivery_destination.dart';
import 'package:shoes_app/features/delivery_destination/domain/use_cases/update_delivery_destination.dart';

import '../../domain/entities/delivery_destination_entity.dart';
import '../../domain/use_cases/fetch_delivery_destinations.dart';

part 'delivery_destination_event.dart';
part 'delivery_destination_state.dart';

class DeliveryDestinationBloc
    extends Bloc<DeliveryDestinationEvent, DeliveryDestinationState> {
  final AddDeliveryDestination addDeliveryDestination;
  final FetchDeliveryDestinations fetchDeliveryDestinations;
  final UpdateDeliveryDestination updateDeliveryDestination;
  final DeleteDeliveryDestination deleteDeliveryDestination;
  DeliveryDestinationBloc({
    required this.addDeliveryDestination,
    required this.fetchDeliveryDestinations,
    required this.updateDeliveryDestination,
    required this.deleteDeliveryDestination,
  }) : super(
         DeliveryDestinationState(
           deliveryDestinationStatus: DeliveryDestinationStatus.initial,
         ),
       ) {
    on<AddDeliveryDestinationEvent>(_onAddDeliveryDestination);
    on<FetchDeliveryDestinationsEvent>(_onFetchDeliveryDestinations);
    on<UpdateDeliveryDestinationEvent>(_onUpdateDeliveryDestination);
    on<DeleteDeliveryDestinationEvent>(_onDeleteDeliveryDestination);
  }

  _onAddDeliveryDestination(
    AddDeliveryDestinationEvent event,
    Emitter<DeliveryDestinationState> emit,
  ) async {
    emit(
      DeliveryDestinationState(
        deliveryDestinationStatus: DeliveryDestinationStatus.loading,
      ),
    );

    final successOrFailure = await addDeliveryDestination.call(
      deliveryDestination: event.deliveryDestination,
    );

    successOrFailure.fold(
      (failure) {
        emit(
          DeliveryDestinationState(
            deliveryDestinationStatus:
                DeliveryDestinationStatus.addDeliveryDestinationError,
            message: mapFailureToMessage(failure: failure),
          ),
        );
      },
      (success) {
        emit(
          DeliveryDestinationState(
            deliveryDestinationStatus:
                DeliveryDestinationStatus.deliveryDestinationAdded,
          ),
        );
      },
    );
  }

  _onFetchDeliveryDestinations(
    FetchDeliveryDestinationsEvent event,
    Emitter<DeliveryDestinationState> emit,
  ) async {
    emit(
      DeliveryDestinationState(
        deliveryDestinationStatus: DeliveryDestinationStatus.loading,
      ),
    );

    final deliveryDestinationsOrFailure =
        await fetchDeliveryDestinations.call();

    deliveryDestinationsOrFailure.fold(
      (failure) {
        emit(
          DeliveryDestinationState(
            deliveryDestinationStatus:
                DeliveryDestinationStatus.fetchDeliveryDestinationsError,
            message: mapFailureToMessage(failure: failure),
          ),
        );
      },
      (deliveryDestinations) {
        emit(
          DeliveryDestinationState(
            deliveryDestinationStatus:
                DeliveryDestinationStatus.deliveryDestinationsFetched,
            deliveryDestinations: deliveryDestinations,
          ),
        );
      },
    );
  }

  _onUpdateDeliveryDestination(
    UpdateDeliveryDestinationEvent event,
    Emitter<DeliveryDestinationState> emit,
  ) async {
    emit(
      DeliveryDestinationState(
        deliveryDestinationStatus: DeliveryDestinationStatus.loading,
      ),
    );

    final successOrFailure = await updateDeliveryDestination.call(
      deliveryDestination: event.deliveryDestination,
    );

    successOrFailure.fold(
      (failure) {
        emit(
          DeliveryDestinationState(
            deliveryDestinationStatus:
                DeliveryDestinationStatus.updateDeliveryDestinationError,
            message: mapFailureToMessage(failure: failure),
          ),
        );
      },
      (success) {
        emit(
          DeliveryDestinationState(
            deliveryDestinationStatus:
                DeliveryDestinationStatus.deliveryDestinationUpdated,
          ),
        );
      },
    );
  }

  _onDeleteDeliveryDestination(
    DeleteDeliveryDestinationEvent event,
    Emitter<DeliveryDestinationState> emit,
  ) async {
    emit(
      DeliveryDestinationState(
        deliveryDestinationStatus: DeliveryDestinationStatus.loading,
      ),
    );

    final successOrFailure = await deleteDeliveryDestination.call(
      deliveryDestinationId: event.deliveryDestinationId,
    );

    successOrFailure.fold(
      (failure) {
        emit(
          DeliveryDestinationState(
            deliveryDestinationStatus:
                DeliveryDestinationStatus.deleteDeliveryDestinationError,
            message: mapFailureToMessage(failure: failure),
          ),
        );
      },
      (success) {
        emit(
          DeliveryDestinationState(
            deliveryDestinationStatus:
                DeliveryDestinationStatus.deliveryDestinationDeleted,
          ),
        );
      },
    );
  }
}
