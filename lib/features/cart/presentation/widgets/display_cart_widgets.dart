import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/core.dart';
import '../../domain/entities/cart_item_entity.dart';
import 'cart_item_card_widget.dart';
import 'delete_cart_item_alert_dialog_widget.dart';

class DisplayCartWidgets extends StatelessWidget {
  const DisplayCartWidgets({
    super.key,
    required this.cartItems,
    required this.totalShoesPrice,
    required this.totalCost,
    required this.deliveryCharge,
    required this.numberOfItems,
    required this.isLoading,
  });

  final List<CartItemEntity> cartItems;
  final double totalShoesPrice;
  final double totalCost;
  final double deliveryCharge;
  final int numberOfItems;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      enableSwitchAnimation: true,
      effect: ShimmerEffect(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        duration: Duration(seconds: 1),
      ),
      child: Column(
        children: [
          cartItemsListView(context: context),
          const SizedBox(height: 10),
          totalPriceAndDeliveryChargeWidget(context: context),
        ],
      ),
    );
  }

  Widget cartItemsListView({required BuildContext context}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = cartItems[index];

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
            child: CartItemCardWidget(cartItem: cartItems[index]),
          );
        },
        separatorBuilder:
            (BuildContext context, int index) => const SizedBox(height: 10),
      ),
    );
  }

  Widget totalPriceAndDeliveryChargeWidget({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ItemCountAndTotalShoesPriceRowWidget(
            numberOfItems: numberOfItems,
            totalShoesPrice: totalShoesPrice.toInt(),
            textColor: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 10),
          DeliveryChargeRowWidget(
            deliveryCharge: deliveryCharge.toInt(),
            textColor: Theme.of(context).colorScheme.secondary,
          ),
          Divider(color: Theme.of(context).colorScheme.secondary),
          TotalCostRowWidget(
            totalCost: totalCost.toInt(),
            textColor: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 10),
          proceedToCheckoutButton(context: context),
        ],
      ),
    );
  }

  Widget proceedToCheckoutButton({required BuildContext context}) {
    return Skeleton.leaf(
      child: ElevatedButtonWidget(
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
            "cartItems": cartItems,
            "totalCost": totalCost,
          });
        },
      ),
    );
  }
}
