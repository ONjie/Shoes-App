import 'package:flutter/material.dart';

import '../../../../../core/core.dart';


const deliveryCharge = 20;

onValidate({
  required String shoeTitle,
  required String shoeImage,
  required double shoePrice,
  required int shoeSize,
  required String shoeColor,
  required int quantity,
  required BuildContext context,
  required bool isBuyNow,
}) {
  if (shoeSize == 0 && shoeColor.isNotEmpty) {
    snackBarWidget(
      message: 'Please select a size',
      bgColor: Theme.of(context).colorScheme.error,
      duration: 2, context: context,
    );
  }
  else if (shoeSize != 0 && shoeColor.isEmpty) {
    snackBarWidget(
      message: 'Please select a color',
      bgColor: Theme.of(context).colorScheme.error,
      duration: 2, context: context,
    );
  }
  else if (shoeSize == 0 && shoeColor.isEmpty) {
    snackBarWidget(
      message: 'Please select a size and color',
      bgColor: Theme.of(context).colorScheme.error,
      duration: 2, context: context,
    );
  }
  else {
   /* !isBuyNow ?
    BlocProvider.of<CartBloc>(context).add(AddCartItemToCartItemsEvent(
      cartItem: CartItemEntity(
        shoeTitle: shoeTitle,
        image: shoeImage,
        color: shoeColor,
        price: shoePrice,
        shoeSize: shoeSize,
        quantity: quantity,
      ),
    ),)
        :
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => SelectDeliveryDestinationScreen(
        cartItems: [
          CartItemEntity(
            shoeTitle: shoeTitle,
            image: shoeImage,
            color: shoeColor,
            price: shoePrice,
            shoeSize: shoeSize,
            quantity: quantity,
          ),
        ],
        totalCost: shoePrice + deliveryCharge,
      ),
      ),
    );*/
  }
}