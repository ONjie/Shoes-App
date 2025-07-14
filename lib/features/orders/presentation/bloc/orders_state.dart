part of 'orders_bloc.dart';

enum OrdersStatus {
  initial,
  loading,
  ordersFetched,
  orderFetched,
  orderCreated,
  orderDeleted,
  createOrderError,
  fetchOrdersError,
  fetchOrderError,
  deleteOrderError,
}

class OrdersState extends Equatable {
  const OrdersState({
    required this.ordersStatus,
    this.orders,
    this.order,
    this.message,
    this.numberOfItems
  });

  final OrdersStatus ordersStatus;
  final List<OrderEntity>? orders;
  final OrderEntity? order;
  final String? message;
  final int? numberOfItems;

  @override
  List<Object?> get props => [ordersStatus, orders, order, message];
}
