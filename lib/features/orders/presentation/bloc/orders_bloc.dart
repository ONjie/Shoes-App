import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/use_cases/create_order.dart';
import '../../domain/use_cases/delete_order.dart';
import '../../domain/use_cases/fetch_order.dart';
import '../../domain/use_cases/fetch_orders.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final CreateOrder createOrder;
  final FetchOrders fetchOrders;
  final FetchOrder fetchOrder;
  final DeleteOrder deleteOrder;
  OrdersBloc({
    required this.createOrder,
    required this.fetchOrders,
    required this.fetchOrder,
    required this.deleteOrder,
  }) : super(const OrdersState(ordersStatus: OrdersStatus.initial)) {
    on<CreateOrderEvent>(_onCreateOrder);
    on<FetchOrdersEvent>(_onFetchOrders);
    on<FetchOrderEvent>(_onFetchOrder);
    on<DeleteOrderEvent>(_onDeleteOrder);
  }

  _onCreateOrder(CreateOrderEvent event, Emitter<OrdersState> emit) async {
    emit(OrdersState(ordersStatus: OrdersStatus.loading));

    final isCreatedOrFailure = await createOrder.call(order: event.order);

    isCreatedOrFailure.fold(
      (failure) {
        emit(
          OrdersState(
            ordersStatus: OrdersStatus.createOrderError,
            message: failure.message,
          ),
        );
      },

      (isCreated) {
        emit(
          OrdersState(
            ordersStatus: OrdersStatus.orderCreated,
            message: orderCreatedMessage,
          ),
        );
      },
    );
  }

  _onFetchOrders(FetchOrdersEvent event, Emitter<OrdersState> emit) async {
    emit(OrdersState(ordersStatus: OrdersStatus.loading));

    final ordersOrFailure = await fetchOrders.call();

    ordersOrFailure.fold(
      (failure) {
        emit(
          OrdersState(
            ordersStatus: OrdersStatus.fetchOrdersError,
            message: failure.message,
          ),
        );
      },
      (orders) {
        emit(
          OrdersState(ordersStatus: OrdersStatus.ordersFetched, orders: orders),
        );
      },
    );
  }

  _onFetchOrder(FetchOrderEvent event, Emitter<OrdersState> emit) async {
    late int numberOfItems = 0;

    emit(OrdersState(ordersStatus: OrdersStatus.loading));

    final orderOrFailure = await fetchOrder.call(orderId: event.orderId);

    orderOrFailure.fold(
      (failure) {
        emit(
          OrdersState(
            ordersStatus: OrdersStatus.fetchOrderError,
            message: failure.message,
          ),
        );
      },
      (order) {
        for (var orderedItem in order.orderedItems) {
          numberOfItems += (orderedItem.quantity);
        }
        emit(
          OrdersState(
            ordersStatus: OrdersStatus.orderFetched,
            order: order,
            numberOfItems: numberOfItems,
          ),
        );
      },
    );
  }

  _onDeleteOrder(DeleteOrderEvent event, Emitter<OrdersState> emit) async {
    final resultOrFailure = await deleteOrder.call(orderId: event.orderId);

    resultOrFailure.fold(
      (failure) {
        emit(
          OrdersState(
            ordersStatus: OrdersStatus.deleteOrderError,
            message: failure.message,
          ),
        );
      },
      (result) {
        emit(const OrdersState(ordersStatus: OrdersStatus.orderDeleted));
      },
    );
  }
}
