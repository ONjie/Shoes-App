import 'package:flutter/material.dart';

class PaymentMethodListTileWidget extends StatelessWidget {
  const PaymentMethodListTileWidget({
    super.key,
    required this.label,
    required this.assetPath,
    required this.isSelected,
    required this.onTap,
    
  });

  final String label;
  final String assetPath;
  final Function() onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      tileColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color:
              isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.tertiary,
          width: 2,
        ),
      ),
      onTap: onTap,
      leading: Container(
        decoration: const BoxDecoration(shape: BoxShape.circle),
        clipBehavior: Clip.hardEdge,
        child: Image.asset(
          assetPath,
          height: 50,
          width: 50,
        ),
      ),
      title: Text(label, style: Theme.of(context).textTheme.bodyMedium),
      trailing: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.tertiary,
          border: Border.all(
            color:
                isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.tertiary,
            width: 2,
          ),
        ),
        child:
            isSelected
                ? Icon(Icons.check, size: 16, color: Colors.white)
                : Icon(Icons.check, size: 16, color: Colors.white),
      ),
    );
  }
}
