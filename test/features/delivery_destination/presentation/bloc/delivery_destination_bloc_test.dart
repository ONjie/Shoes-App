import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/failures/failures.dart';
import 'package:shoes_app/features/delivery_destination/domain/entities/delivery_destination_entity.dart';
import 'package:shoes_app/features/delivery_destination/domain/use_cases/add_delivery_destination.dart';
import 'package:shoes_app/features/delivery_destination/domain/use_cases/delete_delivery_destination.dart';
import 'package:shoes_app/features/delivery_destination/domain/use_cases/fetch_delivery_destination.dart';
import 'package:shoes_app/features/delivery_destination/domain/use_cases/fetch_delivery_destinations.dart';
import 'package:shoes_app/features/delivery_destination/domain/use_cases/update_delivery_destination.dart';
import 'package:shoes_app/features/delivery_destination/presentation/bloc/delivery_destination_bloc.dart';

class MockAddDeliveryDestination extends Mock
    implements AddDeliveryDestination {}

class MockFetchDeliveryDestinations extends Mock
    implements FetchDeliveryDestinations {}

class MockFetchDeliveryDestination extends Mock
    implements FetchDeliveryDestination {}

class MockUpdateDeliveryDestination extends Mock
    implements UpdateDeliveryDestination {}

class MockDeleteDeliveryDestination extends Mock
    implements DeleteDeliveryDestination {}

void main() {
  late DeliveryDestinationBloc deliveryDestinationBloc;
  late MockAddDeliveryDestination mockAddDeliveryDestination;
  late MockFetchDeliveryDestinations mockFetchDeliveryDestinations;
  late MockFetchDeliveryDestination mockFetchDeliveryDestination;
  late MockUpdateDeliveryDestination mockUpdateDeliveryDestination;
  late MockDeleteDeliveryDestination mockDeleteDeliveryDestination;

  setUp(() {
    mockAddDeliveryDestination = MockAddDeliveryDestination();
    mockFetchDeliveryDestinations = MockFetchDeliveryDestinations();
    mockFetchDeliveryDestination = MockFetchDeliveryDestination();
    mockUpdateDeliveryDestination = MockUpdateDeliveryDestination();
    mockDeleteDeliveryDestination = MockDeleteDeliveryDestination();

    deliveryDestinationBloc = DeliveryDestinationBloc(
      addDeliveryDestination: mockAddDeliveryDestination,
      fetchDeliveryDestinations: mockFetchDeliveryDestinations,
      fetchDeliveryDestination: mockFetchDeliveryDestination,
      updateDeliveryDestination: mockUpdateDeliveryDestination,
      deleteDeliveryDestination: mockDeleteDeliveryDestination,
    );
  });

  const tDeliveryDestinationOne = DeliveryDestinationEntity(
    country: 'country',
    city: 'city',
    name: 'name',
    contactNumber: 'contactNumber',
    googlePlusCode: 'googlePlusCode',
  );

  const tDeliveryDestinationTwo = DeliveryDestinationEntity(
    id: 1,
    country: 'country',
    city: 'city',
    name: 'name',
    contactNumber: 'contactNumber',
    googlePlusCode: 'googlePlusCode',
  );

  group('_onAddDeliveryDestination', () {
    blocTest(
      'should emit [DeliveryDestinationStatus.loading, DeliveryDestinationStatus.addDeliveryDestinationError] when call is unsuccessful',
      setUp: () {
        when(
          () => mockAddDeliveryDestination.call(
            deliveryDestination: tDeliveryDestinationOne,
          ),
        ).thenAnswer(
          (_) async => Left(
            SupabaseDatabaseFailure(
              message: 'Failed to add delivery destination',
            ),
          ),
        );
      },
      build: () => deliveryDestinationBloc,
      act:
          (bloc) => deliveryDestinationBloc.add(
            AddDeliveryDestinationEvent(
              deliveryDestination: tDeliveryDestinationOne,
            ),
          ),
      expect:
          () => <DeliveryDestinationState>[
            DeliveryDestinationState(
              deliveryDestinationStatus: DeliveryDestinationStatus.loading,
            ),
            DeliveryDestinationState(
              deliveryDestinationStatus:
                  DeliveryDestinationStatus.addDeliveryDestinationError,
              message: 'Failed to add delivery destination',
            ),
          ],
    );

    blocTest(
      'should emit [DeliveryDestinationStatus.loading, DeliveryDestinationStatus.deliveryDestinationAdded] when call is successful',
      setUp: () {
        when(
          () => mockAddDeliveryDestination.call(
            deliveryDestination: tDeliveryDestinationOne,
          ),
        ).thenAnswer((_) async => Right(true));
      },
      build: () => deliveryDestinationBloc,
      act:
          (bloc) => deliveryDestinationBloc.add(
            AddDeliveryDestinationEvent(
              deliveryDestination: tDeliveryDestinationOne,
            ),
          ),
      expect:
          () => <DeliveryDestinationState>[
            DeliveryDestinationState(
              deliveryDestinationStatus: DeliveryDestinationStatus.loading,
            ),
            DeliveryDestinationState(
              deliveryDestinationStatus:
                  DeliveryDestinationStatus.deliveryDestinationAdded,
            ),
          ],
    );
  });

  group('_onFetchDeliveryDestinations', () {
    blocTest(
      'should emit [DeliveryDestinationStatus.fetchDeliveryDestinationsError] when call is unsuccessful',
      setUp: () {
        when(() => mockFetchDeliveryDestinations.call()).thenAnswer(
          (_) async => Left(
            SupabaseDatabaseFailure(
              message: 'Failed to fetch delivery destinations',
            ),
          ),
        );
      },
      build: () => deliveryDestinationBloc,
      act:
          (bloc) =>
              deliveryDestinationBloc.add(FetchDeliveryDestinationsEvent()),
      expect:
          () => <DeliveryDestinationState>[
            DeliveryDestinationState(
              deliveryDestinationStatus:
                  DeliveryDestinationStatus.fetchDeliveryDestinationsError,
              message: 'Failed to fetch delivery destinations',
            ),
          ],
    );

    blocTest(
      'should emit [ DeliveryDestinationStatus.deliveryDestinationsFetched] when call is successful',
      setUp: () {
        when(
          () => mockFetchDeliveryDestinations.call(),
        ).thenAnswer((_) async => Right([tDeliveryDestinationTwo]));
      },
      build: () => deliveryDestinationBloc,
      act:
          (bloc) =>
              deliveryDestinationBloc.add(FetchDeliveryDestinationsEvent()),
      expect:
          () => <DeliveryDestinationState>[
            DeliveryDestinationState(
              deliveryDestinationStatus:
                  DeliveryDestinationStatus.deliveryDestinationsFetched,
              deliveryDestinations: [tDeliveryDestinationTwo],
            ),
          ],
    );
  });

  group('_onFetchDeliveryDestination', () {
    blocTest(
      'should emit [DeliveryDestinationStatus.loading, DeliveryDestinationStatus.fetchDeliveryDestinationError] when call is unsuccessful',
      setUp: () {
        when(
          () => mockFetchDeliveryDestination.call(
            deliveryDestinationId: tDeliveryDestinationTwo.id!,
          ),
        ).thenAnswer(
          (_) async => Left(
            SupabaseDatabaseFailure(
              message: 'Failed to fetch delivery destination',
            ),
          ),
        );
      },
      build: () => deliveryDestinationBloc,
      act:
          (bloc) => deliveryDestinationBloc.add(
            FetchDeliveryDestinationEvent(
              deliveryDestinationId: tDeliveryDestinationTwo.id!,
            ),
          ),
      expect:
          () => <DeliveryDestinationState>[
            DeliveryDestinationState(
              deliveryDestinationStatus: DeliveryDestinationStatus.loading,
            ),
            DeliveryDestinationState(
              deliveryDestinationStatus:
                  DeliveryDestinationStatus.fetchDeliveryDestinationError,
              message: 'Failed to fetch delivery destination',
            ),
          ],
    );

    blocTest(
      'should emit [DeliveryDestinationStatus.loading, DeliveryDestinationStatus.deliveryDestinationFetched] when call is successful',
      setUp: () {
        when(
          () => mockFetchDeliveryDestination.call(
            deliveryDestinationId: tDeliveryDestinationTwo.id!,
          ),
        ).thenAnswer((_) async => Right(tDeliveryDestinationTwo));
      },
      build: () => deliveryDestinationBloc,
      act:
          (bloc) => deliveryDestinationBloc.add(
            FetchDeliveryDestinationEvent(
              deliveryDestinationId: tDeliveryDestinationTwo.id!,
            ),
          ),
      expect:
          () => <DeliveryDestinationState>[
            DeliveryDestinationState(
              deliveryDestinationStatus: DeliveryDestinationStatus.loading,
            ),
            DeliveryDestinationState(
              deliveryDestinationStatus:
                  DeliveryDestinationStatus.deliveryDestinationFetched,
              deliveryDestination: tDeliveryDestinationTwo,
            ),
          ],
    );
  });

  group('_onUpdateDeliveryDestination', () {
    blocTest(
      'should emit [DeliveryDestinationStatus.loading, DeliveryDestinationStatus.updateDeliveryDestinationError] when call is unsuccessful',
      setUp: () {
        when(
          () => mockUpdateDeliveryDestination.call(
            deliveryDestination: tDeliveryDestinationTwo,
          ),
        ).thenAnswer(
          (_) async => Left(
            SupabaseDatabaseFailure(
              message: 'Failed to update delivery destination',
            ),
          ),
        );
      },
      build: () => deliveryDestinationBloc,
      act:
          (bloc) => deliveryDestinationBloc.add(
            UpdateDeliveryDestinationEvent(
              deliveryDestination: tDeliveryDestinationTwo,
            ),
          ),
      expect:
          () => <DeliveryDestinationState>[
            DeliveryDestinationState(
              deliveryDestinationStatus: DeliveryDestinationStatus.loading,
            ),
            DeliveryDestinationState(
              deliveryDestinationStatus:
                  DeliveryDestinationStatus.updateDeliveryDestinationError,
              message: 'Failed to update delivery destination',
            ),
          ],
    );

    blocTest(
      'should emit [DeliveryDestinationStatus.loading, DeliveryDestinationStatus.deliveryDestinationUpdated] when call is successful',
      setUp: () {
        when(
          () => mockUpdateDeliveryDestination.call(
            deliveryDestination: tDeliveryDestinationTwo,
          ),
        ).thenAnswer((_) async => Right(true));
      },
      build: () => deliveryDestinationBloc,
      act:
          (bloc) => deliveryDestinationBloc.add(
            UpdateDeliveryDestinationEvent(
              deliveryDestination: tDeliveryDestinationTwo,
            ),
          ),
      expect:
          () => <DeliveryDestinationState>[
            DeliveryDestinationState(
              deliveryDestinationStatus: DeliveryDestinationStatus.loading,
            ),
            DeliveryDestinationState(
              deliveryDestinationStatus:
                  DeliveryDestinationStatus.deliveryDestinationUpdated,
            ),
          ],
    );
  });

  group('_onDeleteDeliveryDestination', () {
    blocTest(
      'should emit [DeliveryDestinationStatus.loading, DeliveryDestinationStatus.deleteDeliveryDestinationError] when call is unsuccessful',
      setUp: () {
        when(
          () => mockDeleteDeliveryDestination.call(
            deliveryDestinationId: tDeliveryDestinationTwo.id!,
          ),
        ).thenAnswer(
          (_) async => Left(
            SupabaseDatabaseFailure(
              message: 'Failed to delete delivery destination',
            ),
          ),
        );
      },
      build: () => deliveryDestinationBloc,
      act:
          (bloc) => deliveryDestinationBloc.add(
            DeleteDeliveryDestinationEvent(
              deliveryDestinationId: tDeliveryDestinationTwo.id!,
            ),
          ),
      expect:
          () => <DeliveryDestinationState>[
            DeliveryDestinationState(
              deliveryDestinationStatus: DeliveryDestinationStatus.loading,
            ),
            DeliveryDestinationState(
              deliveryDestinationStatus:
                  DeliveryDestinationStatus.deleteDeliveryDestinationError,
              message: 'Failed to delete delivery destination',
            ),
          ],
    );

    blocTest(
      'should emit [DeliveryDestinationStatus.loading, DeliveryDestinationStatus.deliveryDestinationDeleted] when call is successful',
      setUp: () {
        when(
          () => mockDeleteDeliveryDestination.call(
            deliveryDestinationId: tDeliveryDestinationTwo.id!,
          ),
        ).thenAnswer((_) async => Right(true));
      },
      build: () => deliveryDestinationBloc,
      act:
          (bloc) => deliveryDestinationBloc.add(
            DeleteDeliveryDestinationEvent(
              deliveryDestinationId: tDeliveryDestinationTwo.id!,
            ),
          ),
      expect:
          () => <DeliveryDestinationState>[
            DeliveryDestinationState(
              deliveryDestinationStatus: DeliveryDestinationStatus.loading,
            ),
            DeliveryDestinationState(
              deliveryDestinationStatus:
                  DeliveryDestinationStatus.deliveryDestinationDeleted,
            ),
          ],
    );
  });
}
