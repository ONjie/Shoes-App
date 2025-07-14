import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_app/features/orders/domain/entities/order_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/core.dart';
import '../bloc/orders_bloc.dart';
import '../widgets/order_history_screen_widgets/delete_order_alert_dialog_widget.dart';
import '../widgets/order_history_screen_widgets/order_card_widget.dart';

class OrdersHistoryScreen extends StatefulWidget {
  const OrdersHistoryScreen({super.key});

  @override
  State<OrdersHistoryScreen> createState() => _OrdersHistoryScreenState();
}

class _OrdersHistoryScreenState extends State<OrdersHistoryScreen> {
  bool isLoading = false;
  late List<OrderEntity> orders = OrderEntity.mockOrdersList;

  @override
  void initState() {
    BlocProvider.of<OrdersBloc>(context).add(FetchOrdersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.go('/home/3');
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: buildAppBar(),
        body: buildBody(context: context),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.primary,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      leading: IconButton(
        onPressed: () {
          context.go('/home/3');
        },
        icon: Icon(
          CupertinoIcons.back,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      title: Text(
        'Order History',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
    );
  }

  Widget buildBody({required BuildContext context}) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: EdgeInsets.fromLTRB(12, 16, 12, 0),
          child: BlocConsumer<OrdersBloc, OrdersState>(
            listener: (context, state) {
              if (state.ordersStatus == OrdersStatus.loading) {
                  setState(() {
                    isLoading = true;
                  });
                }
              if (state.ordersStatus == OrdersStatus.ordersFetched) {
                setState(() {
                  orders = state.orders!;
                  isLoading = false;
                });
              }
              if (state.ordersStatus == OrdersStatus.orderDeleted) {
                setState(() {
                  orders = OrderEntity.mockOrdersList;
                  isLoading = true;
                });
                BlocProvider.of<OrdersBloc>(context).add(FetchOrdersEvent());
              }
            },
            builder: (context, state) {
              if (state.ordersStatus == OrdersStatus.fetchOrdersError) {
                return ErrorStateWidget(message: state.message!);
              }
              if (state.ordersStatus == OrdersStatus.deleteOrderError) {
                return ErrorStateWidget(message: state.message!);
              }
              return displayOrders(height: screenHeight);
            },
          ),
        ),
      ),
    );
  }

  Widget displayOrders({required double height}) {
    return Skeletonizer(
      enabled: isLoading,
      enableSwitchAnimation: true,
      effect: ShimmerEffect(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        duration: Duration(seconds: 1),
      ),
      child: SizedBox(
        height: height,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: orders.length,
          itemBuilder: (context, index) {
            orders.sort(
              (a, b) =>
                  b.createdAt!.compareTo(a.createdAt!),
            );
            final order = orders[index];

            return Dismissible(
              key: Key(order.toString()),
              background: const DismissibleBackgroundWidget(),
              confirmDismiss: (direction) async {
                final result = await deleteOrderAlertDialogWidget(
                  order: order,
                  context: context,
                );
                return result;
              },
              child: OrderCardWidget(order: order),
            );
          },
          separatorBuilder:
              (BuildContext context, index) => const SizedBox(height: 10),
        ),
      ),
    );
  }
}
