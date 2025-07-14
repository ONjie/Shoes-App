import 'package:flutter/material.dart';

import '../../../domain/entities/order_entity.dart';

class OrderDeliveryDestinationWidget extends StatelessWidget {
  const OrderDeliveryDestinationWidget({super.key, required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            order.orderStatus == 'Pending' ? 'Delivery To' : 'Delivered To',
            style: Theme.of(context).textTheme.bodyMedium
          ),
          Text(
            order.deliveryDestination,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)
          ),
        ],
      ),
    );
  }
}
