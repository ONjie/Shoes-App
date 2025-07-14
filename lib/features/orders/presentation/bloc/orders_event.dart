part of 'orders_bloc.dart';

sealed class OrdersEvent extends Equatable {
  const OrdersEvent();
}

class CreateOrderEvent extends OrdersEvent{
  final OrderEntity order;

  const CreateOrderEvent({required this.order});

  @override
  List<Object?> get props => [order];
}

class FetchOrdersEvent extends OrdersEvent{
  @override
  List<Object?> get props => [];

}

class FetchOrderEvent extends OrdersEvent{
  final int orderId;

  const FetchOrderEvent({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

class DeleteOrderEvent extends OrdersEvent{
  final int orderId;

  const DeleteOrderEvent({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}