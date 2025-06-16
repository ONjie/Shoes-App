import 'package:equatable/equatable.dart';

import '../../domain/entities/order_entity.dart';
import 'ordered_item_model.dart';

typedef MapJson = Map<String, dynamic>;

class OrderModel extends Equatable {
  const OrderModel({
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
  final List<OrderedItemModel> orderedItems;

  static OrderModel fromJson(MapJson json) => OrderModel(
    id: json['id'] as int,
    orderId: json['order_id'] as int,
    estimatedDeliveryDate: DateTime.parse(json['estimated_delivery_date']),
    orderStatus: json['order_status'] as String,
    paymentMethod: json['payment_method'] as String,
    deliveryDestination: json['delivery_destination'] as String,
    totalCost: json['total_cost'] as double,
    orderedItems:
        (json['ordered_items'] as List<dynamic>)
            .map((orderedItem) => OrderedItemModel.fromJson(orderedItem))
            .toList(),
  );

  MapJson toJson() => {
    "id": id,
    "order_id": orderId,
    "estimated_delivery_date": estimatedDeliveryDate.toIso8601String(),
    "order_status": orderStatus,
    "payment_method": paymentMethod,
    "delivery_destination": deliveryDestination,
    "ordered_items":
        orderedItems.map((orderedItem) => orderedItem.toJson()).toList(),
    "total_cost": totalCost,
  };

  static OrderModel fromOrderEntity(OrderEntity orderEntity) => OrderModel(
    id: orderEntity.id,
    orderId: orderEntity.orderId,
    estimatedDeliveryDate: orderEntity.estimatedDeliveryDate,
    orderStatus: orderEntity.orderStatus,
    paymentMethod: orderEntity.paymentMethod,
    deliveryDestination: orderEntity.deliveryDestination,
    totalCost: orderEntity.totalCost,
    orderedItems:
        orderEntity.orderedItems
            .map(
              (orderedItem) =>
                  OrderedItemModel.fromOrderedItemEntity(orderedItem),
            )
            .toList(),
  );

  OrderEntity toOrderEntity() => OrderEntity(
    id: id,
    orderId: orderId,
    estimatedDeliveryDate: estimatedDeliveryDate,
    orderStatus: orderStatus,
    paymentMethod: paymentMethod,
    deliveryDestination: deliveryDestination,
    totalCost: totalCost,
    orderedItems:
        orderedItems
            .map((orderedItem) => orderedItem.toOrderedItemEntity())
            .toList(),
  );

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
