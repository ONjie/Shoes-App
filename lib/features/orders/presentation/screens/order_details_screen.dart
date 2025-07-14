import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/orders/presentation/widgets/order_details_screen_widgets.dart/order_payment_method_widget.dart';
import 'package:shoes_app/features/orders/presentation/widgets/order_details_screen_widgets.dart/ordered_items_list_view_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../domain/entities/order_entity.dart';
import '../bloc/orders_bloc.dart';
import '../widgets/order_details_screen_widgets.dart/order_delivery_destination_widget.dart';
import '../widgets/order_details_screen_widgets.dart/order_id_estimated_delivery_date_and_order_status_widget.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required this.orderId});
  final int orderId;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool isLoading = false;
  late int numberOfItems = 0;
  late OrderEntity order = OrderEntity.mockOrdersList[0];

  @override
  void initState() {
    BlocProvider.of<OrdersBloc>(context).add(FetchOrderEvent(orderId: widget.orderId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.go('/orders_history');
      },
      child: Scaffold(appBar: buildAppBar(), body: buildBody(context: context)),
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
          context.go('/orders_history');
        },
        icon: Icon(
          CupertinoIcons.back,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      title: Text(
        'Order Details',
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 16, bottom: 0),
            child: BlocConsumer<OrdersBloc, OrdersState>(
              builder: (context, state) {
                if (state.ordersStatus == OrdersStatus.fetchOrderError) {
                  return ErrorStateWidget(message: state.message!);
                }
                return displayOrderDetails();
              },
              listener: (context, state) {
                if (state.ordersStatus == OrdersStatus.loading) {
                  setState(() {
                    isLoading = true;
                  });
                }
                if (state.ordersStatus == OrdersStatus.orderFetched) {
                  setState(() {
                    order = state.order!;
                    numberOfItems = state.numberOfItems!;
                    isLoading = false;
                  });
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget displayOrderDetails() {
    return Skeletonizer(
      enabled: isLoading,
      enableSwitchAnimation: true,
      effect: ShimmerEffect(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        duration: Duration(seconds: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderIdEstimatedDeliveryDateAndOrderStatusWidget(order: order),
          const SizedBox(height: 10),
          OrderDeliveryDestinationWidget(order: order),
          const SizedBox(height: 10),
          OrderPaymentMethodWidget(paymentMethod: order.paymentMethod),
          const SizedBox(height: 10),
          Divider(color: Theme.of(context).colorScheme.tertiary),
          OrderedItemsListViewWidget(orderedItems: order.orderedItems),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: isLoading ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.only(
              top: 12,
              right: 12,
              left: 12,
              bottom: 8,
            ),
            child: Column(
              children: [
                ItemCountAndTotalShoesPriceRowWidget(
                  totalShoesPrice: (order.totalCost - deliveryCharge).toInt(),
                  textColor: Theme.of(context).colorScheme.surface,
                  numberOfItems: numberOfItems,
                ),
                const SizedBox(height: 8),
                DeliveryChargeRowWidget(
                  deliveryCharge: deliveryCharge.toInt(),
                  textColor: Theme.of(context).colorScheme.surface,
                ),
                Divider(color: Theme.of(context).colorScheme.tertiary),
                TotalCostRowWidget(
                  totalCost: order.totalCost.toInt(),
                  textColor: Theme.of(context).colorScheme.surface,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
