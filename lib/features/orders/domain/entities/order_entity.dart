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
    this.createdAt
  });

  final int? id;
  final int orderId;
  final DateTime estimatedDeliveryDate;
  final String orderStatus;
  final String paymentMethod;
  final String deliveryDestination;
  final double totalCost;
  final List<OrderedItemEntity> orderedItems;
  final DateTime? createdAt;

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
    createdAt
  ];

  static final mockOrdersList = [
    OrderEntity(
      id: 1,
      orderId: 1234,
      estimatedDeliveryDate: DateTime.parse('2025-05-22T00:00:00.000'),
      orderStatus: 'orderStatus',
      paymentMethod: 'paymentMethod',
      deliveryDestination: 'deliveryDestination',
      totalCost: 120.00,
      orderedItems: [
        OrderedItemEntity(
          title: 'title',
          image: 'image',
          color: 'ffffff',
          price: 100,
          size: 10,
          quantity: 1,
        ),
        OrderedItemEntity(
          title: 'title',
          image: 'image',
          color: 'ffffff',
          price: 100,
          size: 10,
          quantity: 1,
        ),
        OrderedItemEntity(
          title: 'title',
          image: 'image',
          color: 'ffffff',
          price: 100,
          size: 10,
          quantity: 1,
        ),
      ],
      createdAt: DateTime.parse('2025-05-22T00:00:00.000'),
    ),
    OrderEntity(
      id: 2,
      orderId: 56798,
      estimatedDeliveryDate: DateTime.parse('2025-05-22T00:01:00.000'),
      orderStatus: 'orderStatus',
      paymentMethod: 'paymentMethod',
      deliveryDestination: 'deliveryDestination',
      totalCost: 120.00,
      orderedItems: [
        OrderedItemEntity(
          title: 'title',
          image: 'image',
          color: 'ffffff',
          price: 100,
          size: 10,
          quantity: 1,
        ),
        OrderedItemEntity(
          title: 'title',
          image: 'image',
          color: 'ffffff',
          price: 100,
          size: 10,
          quantity: 1,
        ),
        OrderedItemEntity(
          title: 'title',
          image: 'image',
          color: 'ffffff',
          price: 100,
          size: 10,
          quantity: 1,
        ),
      ],
      createdAt: DateTime.parse('2025-05-22T00:00:00.000'),
    ),
    OrderEntity(
      id: 3,
      orderId: 1234,
      estimatedDeliveryDate: DateTime.parse('2025-05-22T00:03:00.000'),
      orderStatus: 'orderStatus',
      paymentMethod: 'paymentMethod',
      deliveryDestination: 'deliveryDestination',
      totalCost: 120.00,
      orderedItems: [
        OrderedItemEntity(
          title: 'title',
          image: 'image',
          color: 'ffffff',
          price: 100,
          size: 10,
          quantity: 1,
        ),
        OrderedItemEntity(
          title: 'title',
          image: 'image',
          color: 'ffffff',
          price: 100,
          size: 10,
          quantity: 1,
        ),
        OrderedItemEntity(
          title: 'title',
          image: 'image',
          color: 'ffffff',
          price: 100,
          size: 10,
          quantity: 1,
        ),
      ],
      createdAt: DateTime.parse('2025-05-22T00:00:00.000'),
    ),
  ];
}
