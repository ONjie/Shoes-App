import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_app/core/core.dart';

import '../bloc/orders_bloc.dart';

Future<dynamic> orderStatusAlertDialogWidget({required BuildContext context}) {
  return showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: EdgeInsets.all(12),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.4,
            child: BlocBuilder<OrdersBloc, OrdersState>(
              builder: (context, state) {
                if (state.ordersStatus == OrdersStatus.loading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                }
                if (state.ordersStatus == OrdersStatus.orderCreated) {
                 return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: Theme.of(context).colorScheme.primary,
                        size: 64,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Order Created!',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        orderCreatedMessage,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            context.go('/home/0');
                          },
                          child: Text('OK'),
                        ),
                      ),
                    ],
                  );
                }
                if (state.ordersStatus == OrdersStatus.createOrderError) {
                  return ErrorStateWidget(message: state.message!);
                }

                return Container();
              },
            ),
          ),
        ),
  );
}
