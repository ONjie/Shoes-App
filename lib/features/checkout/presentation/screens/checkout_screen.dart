import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:shoes_app/features/delivery_destination/domain/entities/delivery_destination_entity.dart';

import '../../../orders/domain/entities/order_entity.dart';
import '../../../orders/domain/entities/ordered_item_entity.dart';
import '../../../orders/presentation/bloc/orders_bloc.dart';
import '../../../orders/presentation/widgets/order_status_alert_dialog_widget.dart';
import '../../domain/entities/payment_method_entity.dart';
import '../bloc/checkout_bloc.dart';
import '../widgets/payment_method_list_tile_widget.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.totalCost,
    required this.deliveryDestination,
  });

  final List<CartItemEntity> cartItems;
  final double totalCost;
  final DeliveryDestinationEntity deliveryDestination;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late List<OrderedItemEntity> orderedItems = [];
  late bool isSelected;

  @override
  void initState() {
    orderedItems =
        widget.cartItems
            .map(
              (cartItem) => OrderedItemEntity(
                title: cartItem.shoeTitle,
                image: cartItem.image,
                color: cartItem.color,
                price: cartItem.price,
                size: cartItem.shoeSize,
                quantity: cartItem.quantity,
              ),
            )
            .toList();
    isSelected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.go(
          '/select_delivery_destination',
          extra: {"cartItems": <CartItemEntity>[], "totalCost": 0.00},
        );
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
          context.go(
            '/select_delivery_destination',
            extra: {"cartItems": <CartItemEntity>[], "totalCost": 0.00},
          );
        },
        icon: Icon(
          CupertinoIcons.back,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      title: Text('Checkout', style: Theme.of(context).textTheme.titleLarge),
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
          padding: const EdgeInsets.only(
            top: 16,
            right: 12,
            left: 12,
            bottom: 0,
          ),
          child: BlocListener<CheckoutBloc, CheckoutState>(
            listener: (context, state) {
              if (state.checkoutStatus == CheckoutStatus.paymentSuccessful) {
                BlocProvider.of<OrdersBloc>(context).add(
                  CreateOrderEvent(
                    order: OrderEntity(
                      orderId: generateOrderId(),
                      estimatedDeliveryDate: estimateDeliveryDateTime(
                        DateTime.now(),
                      ),
                      orderStatus: 'Pending',
                      paymentMethod: paymentMethod.label,
                      deliveryDestination:
                          '${widget.deliveryDestination.googlePlusCode}, ${widget.deliveryDestination.city}, ${widget.deliveryDestination.country}',
                      totalCost: widget.totalCost,
                      orderedItems: orderedItems,
                      createdAt: DateTime.now()
                    ),
                  ),
                );

                orderStatusAlertDialogWidget(context: context);
              }
              if (state.checkoutStatus == CheckoutStatus.paymentFailed) {
                snackBarWidget(
                  context: context,
                  message: state.message!,
                  bgColor: Theme.of(context).colorScheme.error,
                  duration: 5,
                );
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Payment Method',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                PaymentMethodListTileWidget(
                  label: paymentMethod.label,
                  assetPath: paymentMethod.assetPath,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() => isSelected = true);
                    BlocProvider.of<CheckoutBloc>(context).add(
                      MakePaymentEvent(totalCost: widget.totalCost.toInt()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
