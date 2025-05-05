import 'package:flutter/material.dart';


class ShoeTitleAndPriceWidget extends StatelessWidget {
  const ShoeTitleAndPriceWidget({
    super.key,
    required this.shoeTitle,
    required this.shoePrice,
  });

  final String shoeTitle;
  final double shoePrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
      ),

      child: Padding(
        padding: const EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 2),
        child: buildShoeTitleAndPriceWidget(context: context),
      ),
    );
  }


  Widget buildShoeTitleAndPriceWidget({required BuildContext context}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            shoeTitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Text(
          "\$${shoePrice.toInt()}",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
