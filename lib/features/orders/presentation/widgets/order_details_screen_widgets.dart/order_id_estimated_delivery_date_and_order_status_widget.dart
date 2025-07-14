import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../domain/entities/order_entity.dart';

class OrderIdEstimatedDeliveryDateAndOrderStatusWidget extends StatelessWidget {
  const OrderIdEstimatedDeliveryDateAndOrderStatusWidget({
    super.key,
    required this.order,
  });

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID: ${order.orderId}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Text(
                DateFormat.yMd().format(order.estimatedDeliveryDate),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          Skeleton.leaf(
            child: Container(
              decoration: BoxDecoration(
                color:
                    order.orderStatus == 'Pending'
                        ? Colors.grey
                        : Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(6),
              child: Text(
                order.orderStatus,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
