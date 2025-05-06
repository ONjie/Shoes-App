import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

AppBar appBarWidget({
  required String shoeTitle,
  required bool isFavorite,
  required BuildContext context,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    backgroundColor: Theme.of(context).colorScheme.primary,
    surfaceTintColor: Theme.of(context).colorScheme.primary,
    leading: IconButton(
      onPressed: () {
        context.go('/home/0');
      },
      icon: Icon(
        CupertinoIcons.back,
        color: Theme.of(context).colorScheme.surface,
      ),
    ),
    title: Text(shoeTitle, style: Theme.of(context).textTheme.titleLarge?.copyWith(
      color: Theme.of(context).colorScheme.surface
    )),
    centerTitle: true,
    actions: [
      Icon(
        isFavorite == true
            ? Icons.favorite_rounded
            : Icons.favorite_border_rounded,
        size: 30,
        color: Theme.of(context).colorScheme.surface,
      ),
    ],
  );
}
