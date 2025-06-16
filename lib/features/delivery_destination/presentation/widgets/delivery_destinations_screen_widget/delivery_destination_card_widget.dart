import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/delivery_destination/domain/entities/delivery_destination_entity.dart';

import '../../bloc/delivery_destination_bloc.dart';

class DeliveryDestinationCardWidget extends StatelessWidget {
  const DeliveryDestinationCardWidget({
    super.key,
    required this.deliveryDestination,
    required this.isSelected,
    required this.isSelectDestination,
  });

  final DeliveryDestinationEntity deliveryDestination;
  final bool isSelected;
  final bool isSelectDestination;

  @override
  Widget build(BuildContext context) {
    return Card(
      color:
          isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
      surfaceTintColor:
          isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
      shadowColor:
          isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: isSelected ? 10 : 3,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildNameAndDeleteIconWidget(context: context),
            SizedBox(height: 10),
            Text(
              '${deliveryDestination.googlePlusCode}, ${deliveryDestination.city}, ${deliveryDestination.country}.',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color:
                    isSelected
                        ? Theme.of(context).colorScheme.surface
                        : Theme.of(context).colorScheme.secondary,
              ),
            ),
            SizedBox(height: 10),
            Text(
              deliveryDestination.contactNumber,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color:
                    isSelected
                        ? Theme.of(context).colorScheme.surface
                        : Theme.of(context).colorScheme.secondary,
              ),
            ),
            isSelected && isSelectDestination == false
                ? buildEditButtonWidget(context: context)
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget buildNameAndDeleteIconWidget({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          deliveryDestination.name,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color:
                isSelected
                    ? Theme.of(context).colorScheme.surface
                    : Theme.of(context).colorScheme.secondary,
          ),
        ),
        isSelected && isSelectDestination == false
            ? IconButton(
              icon: Icon(CupertinoIcons.delete),
              color: Theme.of(context).colorScheme.error,
              onPressed: () {
                BlocProvider.of<DeliveryDestinationBloc>(context).add(
                  DeleteDeliveryDestinationEvent(
                    deliveryDestinationId: deliveryDestination.id!,
                  ),
                );
              },
            )
            : SizedBox(),
      ],
    );
  }

  Widget buildEditButtonWidget({required BuildContext context}) {
    return ElevatedButtonWidget(
      buttonText: 'Edit',
      textColor: Theme.of(context).colorScheme.primary,
      textFontSize: 16,
      buttonWidth: 100,
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      radius: 5,
      borderSideColor: Theme.of(context).colorScheme.surface,
      borderSideWidth: 1,
      padding: EdgeInsets.zero,
      onPressed: () {
        context.go('/edit_delivery_destination', extra: deliveryDestination);
      },
    );
  }
}
