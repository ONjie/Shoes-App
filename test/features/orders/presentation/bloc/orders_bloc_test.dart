import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/orders/domain/entities/order_entity.dart';
import 'package:shoes_app/features/orders/domain/entities/ordered_item_entity.dart';
import 'package:shoes_app/features/orders/domain/use_cases/create_order.dart';
import 'package:shoes_app/features/orders/domain/use_cases/delete_order.dart';
import 'package:shoes_app/features/orders/domain/use_cases/fetch_order.dart';
import 'package:shoes_app/features/orders/domain/use_cases/fetch_orders.dart';
import 'package:shoes_app/features/orders/presentation/bloc/orders_bloc.dart';

class MockCreateOrder extends Mock implements CreateOrder {}

class MockFetchOrders extends Mock implements FetchOrders {}

class MockFetchOrder extends Mock implements FetchOrder {}

class MockDeleteOrder extends Mock implements DeleteOrder {}

void main() {
  late OrdersBloc ordersBloc;
  late MockCreateOrder mockCreateOrder;
  late MockFetchOrders mockFetchOrders;
  late MockFetchOrder mockFetchOrder;
  late MockDeleteOrder mockDeleteOrder;

  setUp(() {
    mockCreateOrder = MockCreateOrder();
    mockFetchOrders = MockFetchOrders();
    mockFetchOrder = MockFetchOrder();
    mockDeleteOrder = MockDeleteOrder();

    ordersBloc = OrdersBloc(
      createOrder: mockCreateOrder,
      fetchOrders: mockFetchOrders,
      fetchOrder: mockFetchOrder,
      deleteOrder: mockDeleteOrder,
    );
  });

  const orderedItem = OrderedItemEntity(
    title: 'title',
    image: 'image',
    color: 'color',
    price: 100,
    size: 10,
    quantity: 1,
  );

  final order = OrderEntity(
    orderId: 1234,
    estimatedDeliveryDate: DateTime.parse('2025-05-22T00:00:00.000'),
    orderStatus: 'orderStatus',
    paymentMethod: 'paymentMethod',
    deliveryDestination: 'deliveryDestination',
    totalCost: 120,
    orderedItems: [orderedItem],
  );

  const tNumberOfItems = 2;

  group('_onCreateOrder', () {
    blocTest(
      'should emit [OrdersStatus.loading, OrdersStatus.createOrderError] when call is unsuccessful',
      setUp: () {
        when(() => mockCreateOrder.call(order: order)).thenAnswer(
          (_) async =>
              Left(SupabaseDatabaseFailure(message: 'Failed to create order')),
        );
      },
      build: () => ordersBloc,
      act: (bloc) => ordersBloc.add(CreateOrderEvent(order: order)),
      expect:
          () => <OrdersState>[
            OrdersState(ordersStatus: OrdersStatus.loading),
            OrdersState(
              ordersStatus: OrdersStatus.createOrderError,
              message: 'Failed to create order',
            ),
          ],
    );
    blocTest(
      'should emit [OrdersStatus.loading, OrdersStatus.orderCreated] when call is successful',
      setUp: () {
        when(
          () => mockCreateOrder.call(order: order),
        ).thenAnswer((_) async => Right(true));
      },
      build: () => ordersBloc,
      act: (bloc) => ordersBloc.add(CreateOrderEvent(order: order)),
      expect:
          () => <OrdersState>[
            OrdersState(ordersStatus: OrdersStatus.loading),
            OrdersState(
              ordersStatus: OrdersStatus.orderCreated,
              message: orderCreatedMessage,
            ),
          ],
    );
  });

  group('_onFetchOrders', () {
    blocTest(
      'should emit [OrdersStatus.loading, OrdersStatus.fetchOrdersError] when call is unsuccessful',
      setUp: () {
        when(() => mockFetchOrders.call()).thenAnswer(
          (_) async =>
              Left(SupabaseDatabaseFailure(message: 'Failed to fetch orders')),
        );
      },
      build: () => ordersBloc,
      act: (bloc) => ordersBloc.add(FetchOrdersEvent()),
      expect:
          () => <OrdersState>[
            OrdersState(
              ordersStatus: OrdersStatus.loading
            ),
            OrdersState(
              ordersStatus: OrdersStatus.fetchOrdersError,
              message: 'Failed to fetch orders',
            ),
          ],
    );
    blocTest(
      'should emit [OrdersStatus.loading, OrdersStatus.ordersFetched] when call is successful',
      setUp: () {
        when(
          () => mockFetchOrders.call(),
        ).thenAnswer((_) async => Right([order]));
      },
      build: () => ordersBloc,
      act: (bloc) => ordersBloc.add(FetchOrdersEvent()),
      expect:
          () => <OrdersState>[
            OrdersState(
              ordersStatus: OrdersStatus.loading
            ),
            OrdersState(
              ordersStatus: OrdersStatus.ordersFetched,
              orders: [order],
            ),
          ],
    );
  });

  group('_onFetchOrder', () {
    blocTest(
      'should emit [OrdersStatus.loading, OrdersStatus.fetchOrderError] when call is unsuccessful',
      setUp: () {
        when(() => mockFetchOrder.call(orderId: order.orderId)).thenAnswer(
          (_) async =>
              Left(SupabaseDatabaseFailure(message: 'Failed to fetch order')),
        );
      },
      build: () => ordersBloc,
      act: (bloc) => ordersBloc.add(FetchOrderEvent(orderId: order.orderId)),
      expect:
          () => <OrdersState>[
            OrdersState(
              ordersStatus: OrdersStatus.loading
            ),
            OrdersState(
              ordersStatus: OrdersStatus.fetchOrderError,
              message: 'Failed to fetch order',
            ),
          ],
    );
    blocTest(
      'should emit [OrdersStatus.loading, OrdersStatus.orderFetched] when call is successful',
      setUp: () {
        when(
          () => mockFetchOrder.call(orderId: order.orderId),
        ).thenAnswer((_) async => Right(order));
      },
      build: () => ordersBloc,
      act: (bloc) => ordersBloc.add(FetchOrderEvent(orderId: order.orderId)),
      expect:
          () => <OrdersState>[
            OrdersState(
              ordersStatus: OrdersStatus.loading
            ),
            OrdersState(
              ordersStatus: OrdersStatus.orderFetched,
              order: order,
              numberOfItems: tNumberOfItems,
            ),
          ],
    );
  });

  group('_onDeleteOrder', () {
    blocTest(
      'should emit[OrdersStatus.deleteOrderError] when call is unsuccessful',
      setUp: () {
        when(() => mockDeleteOrder.call(orderId: order.orderId)).thenAnswer(
          (_) async =>
              Left(SupabaseDatabaseFailure(message: 'Failed to delete order')),
        );
      },
      build: () => ordersBloc,
      act: (bloc) => ordersBloc.add(DeleteOrderEvent(orderId: order.orderId)),
      expect:
          () => <OrdersState>[
            OrdersState(
              ordersStatus: OrdersStatus.deleteOrderError,
              message: 'Failed to delete order',
            ),
          ],
    );
    blocTest(
      'should emit [OrdersStatus.orderDeleted] when call is successful',
      setUp: () {
        when(
          () => mockDeleteOrder.call(orderId: order.orderId),
        ).thenAnswer((_) async => Right(true));
      },
      build: () => ordersBloc,
      act: (bloc) => ordersBloc.add(DeleteOrderEvent(orderId: order.orderId)),
      expect:
          () => <OrdersState>[
            OrdersState(ordersStatus: OrdersStatus.orderDeleted),
          ],
    );
  });
}
