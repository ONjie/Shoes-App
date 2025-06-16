import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core.dart';
import '../../domain/entities/cart_item_entity.dart';
import 'cart_item_card_widget.dart';
import 'delete_cart_item_alert_dialog_widget.dart';

class DisplayCartWidgets extends StatefulWidget {
  const DisplayCartWidgets({
    super.key,
    required this.cartItems,
    required this.totalShoesPrice,
    required this.totalCost,
    required this.deliveryCharge,
    required this.numberOfItems,
  });

  final List<CartItemEntity> cartItems;
  final double totalShoesPrice;
  final double totalCost;
  final double deliveryCharge;
  final int numberOfItems;

  @override
  State<DisplayCartWidgets> createState() => _DisplayCartWidgetsState();
}

class _DisplayCartWidgetsState extends State<DisplayCartWidgets> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        cartItemsListView(),
        const SizedBox(height: 10),
        totalPriceAndDeliveryChargeWidget(),
      ],
    );
  }

  Widget cartItemsListView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = widget.cartItems[index];

          return Dismissible(
            key: Key(cartItem.toString()),
            background: const DismissibleBackgroundWidget(),
            confirmDismiss: (direction) async {
              final results = await deleteCartItemAlertDialogWidget(
                cartItem: cartItem,
                context: context,
              );

              return results;
            },
            child: CartItemCardWidget(cartItem: widget.cartItems[index]),
          );
        },
        separatorBuilder:
            (BuildContext context, int index) => const SizedBox(height: 10),
      ),
    );
  }

  Widget totalPriceAndDeliveryChargeWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ItemCountAndTotalShoesPriceRowWidget(
            numberOfItems: widget.numberOfItems,
            totalShoesPrice: widget.totalShoesPrice.toInt(),
            textColor: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 10),
          DeliveryChargeRowWidget(
            deliveryCharge: widget.deliveryCharge.toInt(),
            textColor: Theme.of(context).colorScheme.secondary,
          ),
          Divider(color: Theme.of(context).colorScheme.secondary),
          TotalCostRowWidget(
            totalCost: widget.totalCost.toInt(),
            textColor: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 10),
          proceedToCheckoutButton(),
        ],
      ),
    );
  }

  Widget proceedToCheckoutButton() {
    return ElevatedButtonWidget(
      buttonText: 'Proceed To Checkout',
      textColor: Theme.of(context).colorScheme.surface,
      textFontSize: 20,
      buttonWidth: double.infinity,
      backgroundColor: Theme.of(context).colorScheme.primary,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      radius: 10,
      borderSideColor: Theme.of(context).colorScheme.primary,
      borderSideWidth: 1,
      padding: const EdgeInsets.all(12),
      onPressed: () {
        context.go('/select_delivery_destination', extra: {
          "cartItems": widget.cartItems,
          "totalCost": widget.totalCost,
        });
      },
    );
  }
}
