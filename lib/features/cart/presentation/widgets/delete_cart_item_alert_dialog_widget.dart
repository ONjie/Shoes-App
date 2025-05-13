import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc.dart';
import '../../domain/entities/cart_item_entity.dart';


Future<dynamic> deleteCartItemAlertDialogWidget({
  required CartItemEntity cartItem,
  required BuildContext context,
}){
  return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Theme.of(context).colorScheme.surface,
          content: Text(
            'Are you sure you want to delete "${cartItem.shoeTitle}" from Cart?',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: (){
                BlocProvider.of<CartBloc>(context).add(
                 DeleteCartItemEvent(cartItemId: cartItem.id!)
                );
                Navigator.pop(context);
              },
              child: Text(
                'Delete',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18, color: Theme.of(context).colorScheme.error),
              ),
            )
          ],
        );
      }
  );
}