import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/core.dart';
import '../../../domain/entities/order_entity.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({super.key, required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go('/order_details/${order.orderId}');
      },
      child: Card(
        elevation: 5,
        color: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
                 ShoeImageWidget(
                    imageUrl: order.orderedItems[0].image,
                    width: 80,
                    height: 80,
                    topRightRadius: 4,
                    topLeftRadius: 4,
                    bottomRightRadius: 4,
                    bottomLeftRadius: 4,
                  ),
              const SizedBox(width: 20),
              Expanded(
                child: buildOrderDetailsWidget(order: order, context: context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOrderDetailsWidget({
    required OrderEntity order,
    required BuildContext context,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildOrderIdAndEstimatedDDeliveryDateWidget(
          orderId: order.orderId,
          estimatedDeliveryDate: order.estimatedDeliveryDate,
          context: context,
        ),
        Skeleton.leaf(
          child: Container(
            decoration: BoxDecoration(
              color:
                  order.orderStatus == 'Pending'
                      ? Colors.grey
                      : Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(5),
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
    );
  }

  Widget buildOrderIdAndEstimatedDDeliveryDateWidget({
    required int orderId,
    required DateTime estimatedDeliveryDate,
    required BuildContext context,
  }) {
    return Column(
      children: [
        Text(
          'ID: $orderId',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          DateFormat.yMd().format(estimatedDeliveryDate),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 17,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
