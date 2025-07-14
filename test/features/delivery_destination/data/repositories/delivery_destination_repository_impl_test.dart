import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/delivery_destination/data/data_sources/remote_data/delivery_destination_remote_database_service.dart';
import 'package:shoes_app/features/delivery_destination/data/models/delivery_destination_model.dart';
import 'package:shoes_app/features/delivery_destination/data/repositories/delivery_destination_repository_impl.dart';
import 'package:shoes_app/features/delivery_destination/domain/entities/delivery_destination_entity.dart';

class MockDeliveryDestinationRemoteDatabaseService extends Mock
    implements DeliveryDestinationRemoteDatabaseService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late DeliveryDestinationRepositoryImpl deliveryDestinationRepositoryImpl;
  late MockDeliveryDestinationRemoteDatabaseService
  mockDeliveryDestinationRemoteDatabaseService;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockDeliveryDestinationRemoteDatabaseService =
        MockDeliveryDestinationRemoteDatabaseService();

    deliveryDestinationRepositoryImpl = DeliveryDestinationRepositoryImpl(
      deliveryDestinationRemoteDatabaseService:
          mockDeliveryDestinationRemoteDatabaseService,
      networkInfo: mockNetworkInfo,
    );
  });

  void runOnlineTest(Function body) {
    group('when the device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runOfflineTest(Function body) {
    group('when the device is onffline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  final tDeliveryDestinationModel = DeliveryDestinationModel(
    id: 1,
    name: 'name',
    country: 'country',
    city: 'city',
    contactNumber: 'contactNumber',
    googlePlusCode: 'googlePlusCode',
    updatedAt: DateTime.now(),
  );

  final tDeliveryDestinationEntityOne = DeliveryDestinationEntity(
    name: 'name',
    country: 'country',
    city: 'city',
    contactNumber: 'contactNumber',
    googlePlusCode: 'googlePlusCode',
  );

  final tDeliveryDestinationEntityTwo = DeliveryDestinationEntity(
    id: 1,
    name: 'name',
    country: 'country',
    city: 'city',
    contactNumber: 'contactNumber',
    googlePlusCode: 'googlePlusCode',
  );

  const tDeliveryDestinationId = 1;
  group('addDeliveryDestination', () {
    test('checks if the device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      deliveryDestinationRepositoryImpl.addDeliveryDestination(
        deliveryDestination: tDeliveryDestinationEntityOne,
      );

      verify(() => mockNetworkInfo.isConnected).called(1);
      verifyNoMoreInteractions(mockNetworkInfo);
    });

    runOfflineTest(() {
      test(
        'should return Left(InternetConnectioFailure) when device is offline',
        () async {
          //act
          final result = await deliveryDestinationRepositoryImpl
              .addDeliveryDestination(
                deliveryDestination: tDeliveryDestinationEntityOne,
              );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(
              InternetConnectionFailure(message: noInternetConnectionMessage),
            ),
          );

          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });

    runOnlineTest(() {
      test(
        'should return Right(true) when new delivery destination is added succesfully',
        () async {
          //arrange
          final tExpectedDeliveryDestinationModel = DeliveryDestinationModel(
            country: tDeliveryDestinationEntityOne.country,
            city: tDeliveryDestinationEntityOne.city,
            name: tDeliveryDestinationEntityOne.name,
            contactNumber: tDeliveryDestinationEntityOne.contactNumber,
            googlePlusCode: tDeliveryDestinationEntityOne.googlePlusCode,
          );
          when(
            () => mockDeliveryDestinationRemoteDatabaseService
                .addDeliveryDestination(
                  deliveryDestination: tExpectedDeliveryDestinationModel,
                ),
          ).thenAnswer((_) async {});

          //act
          final result = await deliveryDestinationRepositoryImpl
              .addDeliveryDestination(
                deliveryDestination: tDeliveryDestinationEntityOne,
              );

          //assert
          expect(result, isA<Right<Failure, bool>>());
          expect(result.right, equals(true));
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () => mockDeliveryDestinationRemoteDatabaseService
                .addDeliveryDestination(
                  deliveryDestination: tExpectedDeliveryDestinationModel,
                ),
          ).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
          verifyNoMoreInteractions(
            mockDeliveryDestinationRemoteDatabaseService,
          );
        },
      );

      test(
        'should return Left(SupabaseDatabaseFailure) when SupabaseDatabaseException is thrown',
        () async {
          //arrange
          final tExpectedDeliveryDestinationModel = DeliveryDestinationModel(
            country: tDeliveryDestinationEntityOne.country,
            city: tDeliveryDestinationEntityOne.city,
            name: tDeliveryDestinationEntityOne.name,
            contactNumber: tDeliveryDestinationEntityOne.contactNumber,
            googlePlusCode: tDeliveryDestinationEntityOne.googlePlusCode,
          );
          when(
            () => mockDeliveryDestinationRemoteDatabaseService
                .addDeliveryDestination(
                  deliveryDestination: tExpectedDeliveryDestinationModel,
                ),
          ).thenThrow(
            SupabaseDatabaseException(
              message: 'Failed to add delivery destination',
            ),
          );

          //act
          final result = await deliveryDestinationRepositoryImpl
              .addDeliveryDestination(
                deliveryDestination: tDeliveryDestinationEntityOne,
              );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(
              SupabaseDatabaseFailure(
                message: 'Failed to add delivery destination',
              ),
            ),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () => mockDeliveryDestinationRemoteDatabaseService
                .addDeliveryDestination(
                  deliveryDestination: tExpectedDeliveryDestinationModel,
                ),
          ).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
          verifyNoMoreInteractions(
            mockDeliveryDestinationRemoteDatabaseService,
          );
        },
      );
    });
  });

  group('deleteDeliveryDestination', () {
    test('checks if the device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      deliveryDestinationRepositoryImpl.deleteDeliveryDestination(
        deliveryDestinationId: tDeliveryDestinationId,
      );

      verify(() => mockNetworkInfo.isConnected).called(1);
      verifyNoMoreInteractions(mockNetworkInfo);
    });

    runOfflineTest(() {
      test(
        'should return Left(InternetConnectioFailure) when device is offline',
        () async {
          //act
          final result = await deliveryDestinationRepositoryImpl
              .deleteDeliveryDestination(
                deliveryDestinationId: tDeliveryDestinationId,
              );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(
              InternetConnectionFailure(message: noInternetConnectionMessage),
            ),
          );

          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });

    runOnlineTest(() {
      test(
        'should return Right(true) when new delivery destination is added succesfully',
        () async {
          //arrange
          when(
            () => mockDeliveryDestinationRemoteDatabaseService
                .deleteDeliveryDestination(
                  deliveryDestinationId: tDeliveryDestinationId,
                ),
          ).thenAnswer((_) async {});

          //act
          final result = await deliveryDestinationRepositoryImpl
              .deleteDeliveryDestination(
                deliveryDestinationId: tDeliveryDestinationId,
              );

          //assert
          expect(result, isA<Right<Failure, bool>>());
          expect(result.right, equals(true));
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () => mockDeliveryDestinationRemoteDatabaseService
                .deleteDeliveryDestination(
                  deliveryDestinationId: tDeliveryDestinationId,
                ),
          ).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
          verifyNoMoreInteractions(
            mockDeliveryDestinationRemoteDatabaseService,
          );
        },
      );

      test(
        'should return Left(SupabaseDatabaseFailure) when SupabaseDatabaseException is thrown',
        () async {
          //arrange
          when(
            () => mockDeliveryDestinationRemoteDatabaseService
                .deleteDeliveryDestination(
                  deliveryDestinationId: tDeliveryDestinationId,
                ),
          ).thenThrow(
            SupabaseDatabaseException(
              message: 'Failed to delete delivery destination',
            ),
          );

          //act
          final result = await deliveryDestinationRepositoryImpl
              .deleteDeliveryDestination(
                deliveryDestinationId: tDeliveryDestinationId,
              );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(
              SupabaseDatabaseFailure(
                message: 'Failed to delete delivery destination',
              ),
            ),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () => mockDeliveryDestinationRemoteDatabaseService
                .deleteDeliveryDestination(
                  deliveryDestinationId: tDeliveryDestinationId,
                ),
          ).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
          verifyNoMoreInteractions(
            mockDeliveryDestinationRemoteDatabaseService,
          );
        },
      );
    });
  });

  group('fetchDeliveryDestinations', () {
    test('checks if the device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      deliveryDestinationRepositoryImpl.fetchDeliveryDestinations();

      verify(() => mockNetworkInfo.isConnected).called(1);
      verifyNoMoreInteractions(mockNetworkInfo);
    });

    runOfflineTest(() {
      test(
        'should return Left(InternetConnectioFailure) when device is offline',
        () async {
          //act
          final result =
              await deliveryDestinationRepositoryImpl
                  .fetchDeliveryDestinations();

          //assert
          expect(result, isA<Left<Failure, List<DeliveryDestinationEntity>>>());
          expect(
            result.left,
            equals(
              InternetConnectionFailure(message: noInternetConnectionMessage),
            ),
          );

          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });

    runOnlineTest(() {
      test(
        'should return Right(true) when new delivery destination is added succesfully',
        () async {
          //arrange
          when(
            () =>
                mockDeliveryDestinationRemoteDatabaseService
                    .fetchDeliveryDestinations(),
          ).thenAnswer((_) async => [tDeliveryDestinationModel]);

          //act
          final result =
              await deliveryDestinationRepositoryImpl
                  .fetchDeliveryDestinations();

          //assert
          expect(
            result,
            isA<Right<Failure, List<DeliveryDestinationEntity>>>(),
          );
          expect(
            result.right,
            equals([tDeliveryDestinationModel.toDeliveryDestinationEntity()]),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () =>
                mockDeliveryDestinationRemoteDatabaseService
                    .fetchDeliveryDestinations(),
          ).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
          verifyNoMoreInteractions(
            mockDeliveryDestinationRemoteDatabaseService,
          );
        },
      );

      test(
        'should return Left(SupabaseDatabaseFailure) when SupabaseDatabaseException is thrown',
        () async {
          //arrange
          when(
            () =>
                mockDeliveryDestinationRemoteDatabaseService
                    .fetchDeliveryDestinations(),
          ).thenThrow(
            SupabaseDatabaseException(
              message: 'Failed to fetch delivery destinations',
            ),
          );

          //act
          final result =
              await deliveryDestinationRepositoryImpl
                  .fetchDeliveryDestinations();

          //assert
          expect(result, isA<Left<Failure, List<DeliveryDestinationEntity>>>());
          expect(
            result.left,
            equals(
              SupabaseDatabaseFailure(
                message: 'Failed to fetch delivery destinations',
              ),
            ),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () =>
                mockDeliveryDestinationRemoteDatabaseService
                    .fetchDeliveryDestinations(),
          ).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
          verifyNoMoreInteractions(
            mockDeliveryDestinationRemoteDatabaseService,
          );
        },
      );
    });
  });

  group('updateDeliveryDestination', () {
       test('checks if the device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      deliveryDestinationRepositoryImpl.updateDeliveryDestination(
        deliveryDestination: tDeliveryDestinationEntityOne,
      );

      verify(() => mockNetworkInfo.isConnected).called(1);
      verifyNoMoreInteractions(mockNetworkInfo);
    });

    runOfflineTest(() {
      test(
        'should return Left(InternetConnectioFailure) when device is offline',
        () async {
          //act
          final result = await deliveryDestinationRepositoryImpl
              .updateDeliveryDestination(
                deliveryDestination: tDeliveryDestinationEntityOne,
              );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(
              InternetConnectionFailure(message: noInternetConnectionMessage),
            ),
          );

          verify(() => mockNetworkInfo.isConnected).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    });

    runOnlineTest(() {
      test(
        'should return Right(true) when new delivery destination is added succesfully',
        () async {
          //arrange
          final tExpectedDeliveryDestinationModel = DeliveryDestinationModel(
            id: tDeliveryDestinationEntityTwo.id,
            country: tDeliveryDestinationEntityTwo.country,
            city: tDeliveryDestinationEntityTwo.city,
            name: tDeliveryDestinationEntityTwo.name,
            contactNumber: tDeliveryDestinationEntityTwo.contactNumber,
            googlePlusCode: tDeliveryDestinationEntityTwo.googlePlusCode,
          );
          when(
            () => mockDeliveryDestinationRemoteDatabaseService
                .updateDeliveryDestination(
                  deliveryDestination: tExpectedDeliveryDestinationModel,
                ),
          ).thenAnswer((_) async {});

          //act
          final result = await deliveryDestinationRepositoryImpl
              .updateDeliveryDestination(
                deliveryDestination: tDeliveryDestinationEntityTwo,
              );

          //assert
          expect(result, isA<Right<Failure, bool>>());
          expect(result.right, equals(true));
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () => mockDeliveryDestinationRemoteDatabaseService
                .updateDeliveryDestination(
                  deliveryDestination: tExpectedDeliveryDestinationModel,
                ),
          ).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
          verifyNoMoreInteractions(
            mockDeliveryDestinationRemoteDatabaseService,
          );
        },
      );

      test(
        'should return Left(SupabaseDatabaseFailure) when SupabaseDatabaseException is thrown',
        () async {
          //arrange
          final tExpectedDeliveryDestinationModel = DeliveryDestinationModel(
            id: tDeliveryDestinationEntityTwo.id,
            country: tDeliveryDestinationEntityTwo.country,
            city: tDeliveryDestinationEntityTwo.city,
            name: tDeliveryDestinationEntityTwo.name,
            contactNumber: tDeliveryDestinationEntityTwo.contactNumber,
            googlePlusCode: tDeliveryDestinationEntityTwo.googlePlusCode,
          );
          when(
            () => mockDeliveryDestinationRemoteDatabaseService
                .updateDeliveryDestination(
                  deliveryDestination: tExpectedDeliveryDestinationModel,
                ),
          ).thenThrow(
            SupabaseDatabaseException(
              message: 'Failed to update delivery destination',
            ),
          );

          //act
          final result = await deliveryDestinationRepositoryImpl
              .updateDeliveryDestination(
                deliveryDestination: tDeliveryDestinationEntityTwo,
              );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(
              SupabaseDatabaseFailure(
                message: 'Failed to update delivery destination',
              ),
            ),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () => mockDeliveryDestinationRemoteDatabaseService
                .updateDeliveryDestination(
                  deliveryDestination: tExpectedDeliveryDestinationModel,
                ),
          ).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
          verifyNoMoreInteractions(
            mockDeliveryDestinationRemoteDatabaseService,
          );
        },
      );
    });
 
  });
}
