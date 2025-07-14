import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../cart/domain/entities/cart_item_entity.dart';
import '../../../../cart/presentation/bloc/cart_bloc.dart';

onValidate({
  required String shoeTitle,
  required String shoeImage,
  required double shoePrice,
  required int shoeSize,
  required String shoeColor,
  required int quantity,
  required BuildContext context,
}) {
  if (shoeSize == 0 && shoeColor.isNotEmpty) {
    snackBarWidget(
      message: 'Please select a size',
      bgColor: Theme.of(context).colorScheme.error,
      duration: 2,
      context: context,
    );
  } else if (shoeSize != 0 && shoeColor.isEmpty) {
    snackBarWidget(
      message: 'Please select a color',
      bgColor: Theme.of(context).colorScheme.error,
      duration: 2,
      context: context,
    );
  } else if (shoeSize == 0 && shoeColor.isEmpty) {
    snackBarWidget(
      message: 'Please select a size and color',
      bgColor: Theme.of(context).colorScheme.error,
      duration: 2,
      context: context,
    );
  } else {
    BlocProvider.of<CartBloc>(context).add(
      AddCartItemToCartItemsEvent(
        cartItem: CartItemEntity(
          shoeTitle: shoeTitle,
          image: shoeImage,
          color: shoeColor,
          price: shoePrice,
          shoeSize: shoeSize,
          quantity: quantity,
        ),
      ),
    );
  }
}
