import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../bloc/cart_bloc.dart';
import '../widgets/display_cart_widgets.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<CartItemEntity> cartItems = CartItemEntity.mockCartItems;
  late double totalShoesPrice = 0.00;
  late double totalCost = 0.00;
  late int numberOfItems = 0;
 bool isLoading = true;

  @override
  void initState() {
    BlocProvider.of<CartBloc>(context).add(FetchCartItemsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: buildAppBar(),
      body: buildBody(context: context),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      title: Text('Cart', style: Theme.of(context).textTheme.titleLarge),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            BlocProvider.of<CartBloc>(context).add(DeleteCartItemsEvent());
          },
          icon: Icon(
            CupertinoIcons.trash,
            color: Theme.of(context).colorScheme.secondary,
            size: 28,
          ),
        ),
      ],
    );
  }

  Widget buildBody({required BuildContext context}) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16,
              right: 12,
              left: 12,
              bottom: 0,
            ),
            child: BlocConsumer<CartBloc, CartState>(
              listener: (context, state) {
                if (state.cartItemsStatus == CartItemsStatus.cartItemsDeleted) {
                  BlocProvider.of<CartBloc>(context).add(FetchCartItemsEvent());
                }
                if (state.cartItemsStatus == CartItemsStatus.cartItemDeleted) {
                  BlocProvider.of<CartBloc>(context).add(FetchCartItemsEvent());
                }
                if (state.cartItemsStatus ==
                    CartItemsStatus.cartItemQuantityUpdated) {
                  BlocProvider.of<CartBloc>(context).add(FetchCartItemsEvent());
                }

                if (state.cartItemsStatus == CartItemsStatus.cartItemsFetched) {
                  setState(() {
                    cartItems = state.cartItems!;
                    totalShoesPrice = state.totalShoesPrice!;
                    totalCost = state.totalCost!;
                    numberOfItems = state.numberOfItems!;
                    isLoading = false;
                  });
                }
              },
              builder: (context, state) {
                if (state.cartItemsStatus ==
                    CartItemsStatus.fetchCartItemsError) {
                  return ErrorStateWidget(message: state.message!);
                }

                return DisplayCartWidgets(
                  cartItems: cartItems,
                  totalShoesPrice: totalShoesPrice,
                  totalCost: totalCost,
                  deliveryCharge: deliveryCharge,
                  numberOfItems: numberOfItems,
                  isLoading: isLoading,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
