import 'package:equatable/equatable.dart';

import 'ordered_item_entity.dart';

class OrderEntity extends Equatable {
  const OrderEntity({
    this.id,
    required this.orderId,
    required this.estimatedDeliveryDate,
    required this.orderStatus,
    required this.paymentMethod,
    required this.deliveryDestination,
    required this.totalCost,
    required this.orderedItems,
  });

  final int? id;
  final int orderId;
  final DateTime estimatedDeliveryDate;
  final String orderStatus;
  final String paymentMethod;
  final String deliveryDestination;
  final double totalCost;
  final List<OrderedItemEntity> orderedItems;

  @override
  List<Object?> get props => [
    id,
    orderId,
    estimatedDeliveryDate,
    orderStatus,
    paymentMethod,
    deliveryDestination,
    totalCost,
    orderedItems,
  ];
}
