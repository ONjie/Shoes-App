import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/core.dart';
import '../../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../domain/entities/shoe_entity.dart';
import 'on_validate.dart';
import 'price_and_rating_widget.dart';
import 'shoe_description_widget.dart';

class DisplayShoeInfoWidget extends StatefulWidget {
  const DisplayShoeInfoWidget({super.key, required this.shoe});

  final ShoeEntity shoe;

  @override
  State<DisplayShoeInfoWidget> createState() => _DisplayShoeInfoWidgetState();
}

class _DisplayShoeInfoWidgetState extends State<DisplayShoeInfoWidget> {
  late int currentSizeIndex = -1;
  late int quantity = 1;
  late int shoeSize = 0;
  late String shoeColor = '';

  void onColorSelected(String value) {
    setState(() {
      shoeColor == value ? shoeColor = '' : shoeColor = value;
    });
  }

  void onSizeSelected(int index) {
    setState(() {
      if (currentSizeIndex == index) {
        currentSizeIndex = -1;
        shoeSize = 0;
      } else {
        currentSizeIndex = index;
        shoeSize = widget.shoe.sizes[index];
      }
    });
  }

  void _delayedNavigation() async {
    await Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      if (!mounted) return;
      context.go('/home/2');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
       if (state.cartItemsStatus == CartItemsStatus.cartItemAdded) {
            snackBarWidget(
              message: state.successMessage!,
              bgColor: Theme.of(context).colorScheme.primary,
              duration: 2, context: context,
            );
          _delayedNavigation();
        }
        if (state.cartItemsStatus == CartItemsStatus.fetchCartItemsError) {
            snackBarWidget(
              message: state.errorMessage!,
              bgColor: Theme.of(context).colorScheme.error,
              duration: 2, context: context,
            );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 12,
          right: 12,
          left: 12,
          bottom: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PriceAndRatingWidget(
              price: widget.shoe.price.toInt(),
              ratings: widget.shoe.ratings,
            ),
            const SizedBox(height: 8),
            ShoeDescriptionWidget(shoeDescription: widget.shoe.description),
            const SizedBox(height: 8),
            sizeColorWidget(),
            const SizedBox(height: 40),
            addToCartBuyNowWidgets(),
          ],
        ),
      ),
    );
  }

  Widget sizeColorWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Size', style: Theme.of(context).textTheme.labelLarge),
            colorsWidget(),
          ],
        ),
        sizesButtonListView(),
      ],
    );
  }

  Widget sizesButtonListView() {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.shoe.sizes.length,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        itemBuilder: (context, index) {
          return sizesButton(index: index);
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(),
      ),
    );
  }

  Widget sizesButton({required int index}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1.5,
          ),
        ),
        backgroundColor:
            currentSizeIndex == index
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.surface,
        surfaceTintColor:
            currentSizeIndex == index
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.surface,
      ),
      onPressed: () {
        onSizeSelected(index);
        if (currentSizeIndex == index) {
          shoeSize = widget.shoe.sizes[index];
        }
      },
      child: Text(
        '${widget.shoe.sizes[index]}',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 18,
          color:
              currentSizeIndex == index
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget colorsWidget() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: Row(
        children: [
          Text('Color', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(width: 10),
          colorDropDownWidget(),
        ],
      ),
    );
  }

  Widget colorDropDownWidget() {
    return SizedBox(
      height: 20,
      child: DropdownButton(
        hint: CircleAvatar(
          radius: 10,
          backgroundColor: shoeColorConverterWidget(colorValue: shoeColor),
        ),
        elevation: 0,
        underline: Container(color: Theme.of(context).colorScheme.surface),
        icon: const Icon(Icons.arrow_drop_down),
        items:
            widget.shoe.colors.map((String value) {
              return DropdownMenuItem(
                onTap: () {
                  onColorSelected(value);
                },
                value: shoeColor,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: shoeColorConverterWidget(colorValue: value),
                ),
              );
            }).toList(),
        onChanged: (String? value) {},
      ),
    );
  }

  Widget addToCartBuyNowWidgets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.all(1),
          child: IconButton(
            onPressed: () {
              onValidate(
                shoeTitle: widget.shoe.title,
                shoeImage: widget.shoe.images[0],
                shoePrice: widget.shoe.price,
                shoeSize: shoeSize,
                shoeColor: shoeColor,
                quantity: quantity,
                context: context,
                isBuyNow: false,
              );
            },
            icon: ImageIcon(
              const AssetImage('assets/icons/add_to_cart_icon.png'),
              size: 40,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
        ),
        ElevatedButtonWidget(
          buttonText: 'Buy Now',
          textColor: Theme.of(context).colorScheme.primary,
          textFontSize: 19,
          buttonWidth: MediaQuery.of(context).size.width * 0.4,
          backgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Theme.of(context).colorScheme.surface,
          radius: 5,
          borderSideColor: Theme.of(context).colorScheme.primary,
          borderSideWidth: 1,
          padding: const EdgeInsets.only(
            top: 12,
            bottom: 12,
            left: 10,
            right: 10,
          ),
          onPressed: () {
            onValidate(
              shoeTitle: widget.shoe.title,
              shoeImage: widget.shoe.images[0],
              shoePrice: widget.shoe.price,
              shoeSize: shoeSize,
              shoeColor: shoeColor,
              quantity: quantity,
              context: context,
              isBuyNow: true,
            );
          },
        ),
      ],
    );
  }
}
