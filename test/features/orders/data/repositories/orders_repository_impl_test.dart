import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/orders/data/data_sources/remote_data/orders_remote_database_service.dart';
import 'package:shoes_app/features/orders/data/models/order_model.dart';
import 'package:shoes_app/features/orders/data/models/ordered_item_model.dart';
import 'package:shoes_app/features/orders/data/repositories/orders_repository_impl.dart';
import 'package:shoes_app/features/orders/domain/entities/order_entity.dart';

class MockOrdersRemoteDatabaseService extends Mock
    implements OrdersRemoteDatabaseService {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late OrdersRepositoryImpl ordersRepositoryImpl;
  late MockOrdersRemoteDatabaseService mockOrdersRemoteDatabaseService;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockOrdersRemoteDatabaseService = MockOrdersRemoteDatabaseService();
    mockNetworkInfo = MockNetworkInfo();

    ordersRepositoryImpl = OrdersRepositoryImpl(
      networkInfo: mockNetworkInfo,
      ordersRemoteDatabaseService: mockOrdersRemoteDatabaseService,
    );
  });

  const orderedItemModel = OrderedItemModel(
    title: 'title',
    image: 'image',
    color: 'color',
    price: 100.00,
    size: 10,
    quantity: 1,
  );

  final orderModel = OrderModel(
    orderId: 1234,
    estimatedDeliveryDate: DateTime.parse('2025-05-22T00:00:00.000'),
    orderStatus: 'orderStatus',
    paymentMethod: 'paymentMethod',
    deliveryDestination: 'deliveryDestination',
    totalCost: 120,
    orderedItems: [orderedItemModel],
  );

  void runOnlineTest(Function body) {
    group('when device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runOfflineTest(Function body) {
    group('when device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('createOrder', () {
    test('checks if the device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      //act
      await ordersRepositoryImpl.createOrder(order: orderModel.toOrderEntity());

      verify(() => mockNetworkInfo.isConnected).called(1);
      verifyNoMoreInteractions(mockNetworkInfo);
    });

    runOfflineTest(() {
      test(
        'should return Left(InternetConnectionFailure) when device is offline',
        () async {
          //act
          final result = await ordersRepositoryImpl.createOrder(
            order: orderModel.toOrderEntity(),
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
      test('should return Right(true) when call is successful', () async {
        //arrange
        when(
          () => mockOrdersRemoteDatabaseService.createOrder(order: orderModel),
        ).thenAnswer((_) async => true);

        //act
        final result = await ordersRepositoryImpl.createOrder(
          order: orderModel.toOrderEntity(),
        );

        //assert
        expect(result, isA<Right<Failure, bool>>());
        expect(result.right, equals(true));
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(
          () => mockOrdersRemoteDatabaseService.createOrder(order: orderModel),
        ).called(1);
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockOrdersRemoteDatabaseService);
      });

      test(
        'should return Left(SupabaseDatabaseFailure) when SupabaseDatabaseException is thrown',
        () async {
          //arrange
          when(
            () =>
                mockOrdersRemoteDatabaseService.createOrder(order: orderModel),
          ).thenThrow(SupabaseDatabaseException(message: 'No orders found'));

          //act
          final result = await ordersRepositoryImpl.createOrder(
            order: orderModel.toOrderEntity(),
          );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(SupabaseDatabaseFailure(message: 'No orders found')),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () =>
                mockOrdersRemoteDatabaseService.createOrder(order: orderModel),
          ).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
          verifyNoMoreInteractions(mockOrdersRemoteDatabaseService);
        },
      );
    });
  });

  group('deleteOrder', () {
    test('checks if the device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      //act
      await ordersRepositoryImpl.deleteOrder(orderId: orderModel.orderId);

      verify(() => mockNetworkInfo.isConnected).called(1);
      verifyNoMoreInteractions(mockNetworkInfo);
    });

    runOfflineTest(() {
      test(
        'should return Left(InternetConnectionFailure) when device is offline',
        () async {
          //act
          final result = await ordersRepositoryImpl.deleteOrder(
            orderId: orderModel.orderId,
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
      test('should return Right(true) when call is successful', () async {
        //arrange
        when(
          () => mockOrdersRemoteDatabaseService.deleteOrder(
            orderId: orderModel.orderId,
          ),
        ).thenAnswer((_) async => true);

        //act
        final result = await ordersRepositoryImpl.deleteOrder(
          orderId: orderModel.orderId,
        );

        //assert
        expect(result, isA<Right<Failure, bool>>());
        expect(result.right, equals(true));
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(
          () => mockOrdersRemoteDatabaseService.deleteOrder(
            orderId: orderModel.orderId,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockOrdersRemoteDatabaseService);
      });

      test(
        'should return Left(SupabaseDatabaseFailure) when SupabaseDatabaseException is thrown',
        () async {
          //arrange
          when(
            () => mockOrdersRemoteDatabaseService.deleteOrder(
              orderId: orderModel.orderId,
            ),
          ).thenThrow(
            SupabaseDatabaseException(message: 'Failed to delete order'),
          );

          //act
          final result = await ordersRepositoryImpl.deleteOrder(
            orderId: orderModel.orderId,
          );

          //assert
          expect(result, isA<Left<Failure, bool>>());
          expect(
            result.left,
            equals(SupabaseDatabaseFailure(message: 'Failed to delete order')),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () =>
                mockOrdersRemoteDatabaseService.deleteOrder(orderId: orderModel.orderId),
          ).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
          verifyNoMoreInteractions(mockOrdersRemoteDatabaseService);
        },
      );
    });
  });

  group('fetchOrder', () {
    test('checks if the device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      //act
      await ordersRepositoryImpl.fetchOrder(orderId: orderModel.orderId);

      verify(() => mockNetworkInfo.isConnected).called(1);
      verifyNoMoreInteractions(mockNetworkInfo);
    });

    runOfflineTest(() {
      test(
        'should return Left(InternetConnectionFailure) when device is offline',
        () async {
          //act
          final result = await ordersRepositoryImpl.fetchOrder(
            orderId: orderModel.orderId,
          );

          //assert
          expect(result, isA<Left<Failure, OrderEntity>>());
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
      test('should return Right(true) when call is successful', () async {
        //arrange
        when(
          () => mockOrdersRemoteDatabaseService.fetchOrder(
            orderId: orderModel.orderId,
          ),
        ).thenAnswer((_) async => orderModel);

        //act
        final result = await ordersRepositoryImpl.fetchOrder(
          orderId: orderModel.orderId,
        );

        //assert
        expect(result, isA<Right<Failure, OrderEntity>>());
        expect(result.right, equals(orderModel.toOrderEntity()));
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(
          () => mockOrdersRemoteDatabaseService.fetchOrder(
            orderId: orderModel.orderId,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockOrdersRemoteDatabaseService);
      });

      test(
        'should return Left(SupabaseDatabaseFailure) when SupabaseDatabaseException is thrown',
        () async {
          //arrange
          when(
            () => mockOrdersRemoteDatabaseService.fetchOrder(
              orderId: orderModel.orderId,
            ),
          ).thenThrow(
            SupabaseDatabaseException(message: 'Failed to fetch order'),
          );

          //act
          final result = await ordersRepositoryImpl.fetchOrder(
            orderId: orderModel.orderId,
          );

          //assert
          expect(result, isA<Left<Failure, OrderEntity>>());
          expect(
            result.left,
            equals(SupabaseDatabaseFailure(message: 'Failed to fetch order')),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () =>
                mockOrdersRemoteDatabaseService.fetchOrder(orderId: orderModel.orderId),
          ).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
          verifyNoMoreInteractions(mockOrdersRemoteDatabaseService);
        },
      );
    });
  });

   group('fetchOrders', () {
    test('checks if the device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      //act
      await ordersRepositoryImpl.fetchOrders();

      verify(() => mockNetworkInfo.isConnected).called(1);
      verifyNoMoreInteractions(mockNetworkInfo);
    });

    runOfflineTest(() {
      test(
        'should return Left(InternetConnectionFailure) when device is offline',
        () async {
          //act
          final result = await ordersRepositoryImpl.fetchOrders();

          //assert
          expect(result, isA<Left<Failure, List<OrderEntity>>>());
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
      test('should return Right(true) when call is successful', () async {
        //arrange
        when(
          () => mockOrdersRemoteDatabaseService.fetchOrders(),
        ).thenAnswer((_) async => [orderModel]);

        //act
        final result = await ordersRepositoryImpl.fetchOrders();

        //assert
        expect(result, isA<Right<Failure, List<OrderEntity>>>());
        expect(result.right, equals([orderModel.toOrderEntity()]));
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(
          () => mockOrdersRemoteDatabaseService.fetchOrders(),
        ).called(1);
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockOrdersRemoteDatabaseService);
      });

      test(
        'should return Left(SupabaseDatabaseFailure) when SupabaseDatabaseException is thrown',
        () async {
          //arrange
          when(
            () => mockOrdersRemoteDatabaseService.fetchOrders(),
          ).thenThrow(
            SupabaseDatabaseException(message: 'No orders found'),
          );

          //act
          final result = await ordersRepositoryImpl.fetchOrders();

          //assert
          expect(result, isA<Left<Failure, List<OrderEntity>>>());
          expect(
            result.left,
            equals(SupabaseDatabaseFailure(message: 'No orders found')),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () =>
                mockOrdersRemoteDatabaseService.fetchOrders(),
          ).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
          verifyNoMoreInteractions(mockOrdersRemoteDatabaseService);
        },
      );

      test(
        'should return Left(OtherFailure) when OtherExceptions is thrown',
        () async {
          //arrange
          when(
            () => mockOrdersRemoteDatabaseService.fetchOrders(),
          ).thenThrow(
            OtherExceptions(message: 'Unexpected error'),
          );

          //act
          final result = await ordersRepositoryImpl.fetchOrders();

          //assert
          expect(result, isA<Left<Failure, List<OrderEntity>>>());
          expect(
            result.left,
            equals(OtherFailure(message: 'Unexpected error')),
          );
          verify(() => mockNetworkInfo.isConnected).called(1);
          verify(
            () =>
                mockOrdersRemoteDatabaseService.fetchOrders(),
          ).called(1);
          verifyNoMoreInteractions(mockNetworkInfo);
          verifyNoMoreInteractions(mockOrdersRemoteDatabaseService);
        },
      );
    });
  });
}
