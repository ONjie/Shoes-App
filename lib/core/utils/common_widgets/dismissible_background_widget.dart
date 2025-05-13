import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DismissibleBackgroundWidget extends StatelessWidget {
  const DismissibleBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(CupertinoIcons.trash, color: Theme.of(context).colorScheme.surface, size: 40,)
          ],
        ),
      ),
    );
  }
}
