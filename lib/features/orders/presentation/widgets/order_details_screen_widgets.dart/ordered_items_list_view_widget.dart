import 'package:flutter/material.dart';

import '../../../domain/entities/ordered_item_entity.dart';
import 'ordered_item_card_widget.dart';

class OrderedItemsListViewWidget extends StatelessWidget {
  const OrderedItemsListViewWidget({super.key, required this.orderedItems});

   final List<OrderedItemEntity> orderedItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.42,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: orderedItems.length,
          itemBuilder: (context, index) {
            return OrderedItemCardWidget(orderedItem: orderedItems[index]);
          },
        ),
      ),
    );
  }
}