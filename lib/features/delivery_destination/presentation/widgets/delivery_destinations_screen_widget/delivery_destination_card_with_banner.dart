

import 'package:flutter/material.dart';

import '../../../domain/entities/delivery_destination_entity.dart';
import 'delivery_destination_card_widget.dart';

class DeliveryDestinationCardWithBanner extends StatelessWidget {
  const DeliveryDestinationCardWithBanner({super.key, required this.deliveryDestination, required this.isSelected, required this.isSelectDestination});

  final DeliveryDestinationEntity deliveryDestination;
  final bool isSelected;
  final bool isSelectDestination;

  @override
  Widget build(BuildContext context) {
     return ClipRect(
      child: Banner(
        message: 'Default',
        location: BannerLocation.bottomEnd,
        color: isSelected ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.primary,
        textStyle: (Theme.of(context).textTheme.bodySmall)!.copyWith(fontSize: 14,
        fontWeight: FontWeight.w600,
        color: isSelected ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.surface
        ),
        child: DeliveryDestinationCardWidget(
           deliveryDestination: deliveryDestination,
          isSelected: isSelected,
          isSelectDestination: isSelectDestination,
        ),
      ),
    );
  }
}