import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';


class ShoeDescriptionWidget extends StatelessWidget {
  const ShoeDescriptionWidget({super.key, required this.shoeDescription});

  final String shoeDescription;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      shoeDescription,
      trimLines: 3,
      colorClickableText: Theme.of(context).colorScheme.primary,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'Read More',
      trimExpandedText: 'Read Less',
      moreStyle:Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.primary),
      lessStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.primary),
      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w100),
    );
  }
}
