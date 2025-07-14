import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_app/features/shoes/domain/entities/brand_entity.dart';
import '../../bloc/shoes_bloc.dart';

class ShoesBrandsWidget extends StatefulWidget {
  const ShoesBrandsWidget({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  State<ShoesBrandsWidget> createState() => _ShoesBrandsWidgetState();
}

class _ShoesBrandsWidgetState extends State<ShoesBrandsWidget> {
  late int index = widget.currentIndex;

  final List<BrandEntity> brands = BrandEntity.brands;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildBrands(),
        const SizedBox(height: 5),
        buildBrandsListView(),
      ],
    );
  }

  Widget buildBrands() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Brands', style: Theme.of(context).textTheme.labelLarge),
        TextButton(
          onPressed: () {
            context.go('/brands');
          },
          child: Text(
            'See all',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBrandsListView() {
    return SizedBox(
      height: 70,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: brands.length,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        itemBuilder: (context, buttonIndex) {
          return buildBrandLogoButton(buttonIndex: buttonIndex);
        },
        separatorBuilder:
            (BuildContext context, int index) => const SizedBox(width: 10),
      ),
    );
  }

  Widget buildBrandLogoButton({required int buttonIndex}) {
    return InkWell(
      onTap: () {
        setState(() {
          index = buttonIndex;
        });
        BlocProvider.of<ShoesBloc>(context).add(
          FetchShoesByBrandWithFilterEvent(brand: brands[buttonIndex].brand),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color:
              index == buttonIndex
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child:
            index == buttonIndex
                ? Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(1),
                      child: Image.asset(
                        brands[buttonIndex].logo,
                        color: Theme.of(context).colorScheme.secondary,
                        height: 50,
                        width: 50,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      brands[buttonIndex].brand,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ],
                )
                : Image.asset(
                  brands[buttonIndex].logo,
                  color: Theme.of(context).colorScheme.secondary,
                  height: 63,
                  width: 63,
                ),
      ),
    );
  }
}
