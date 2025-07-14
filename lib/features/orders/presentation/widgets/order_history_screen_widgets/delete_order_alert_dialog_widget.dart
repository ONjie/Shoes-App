import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/order_entity.dart';
import '../../bloc/orders_bloc.dart';

Future<dynamic> deleteOrderAlertDialogWidget({
  required OrderEntity order,
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        content: Text(
          'Are you sure you want to delete order id#${order.orderId}?',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: 18),
            ),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<OrdersBloc>(
                context,
              ).add(DeleteOrderEvent(orderId: order.orderId));
              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ],
      );
    },
  );
}
