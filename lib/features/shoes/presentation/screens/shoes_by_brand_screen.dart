import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';
import '../bloc/shoes_bloc.dart';

class ShoesByBrandScreen extends StatefulWidget {
  const ShoesByBrandScreen({super.key, required this.brand});
  final String brand;

  @override
  State<ShoesByBrandScreen> createState() => _ShoesByBrandScreenState();
}

class _ShoesByBrandScreenState extends State<ShoesByBrandScreen> {
  late String category = '';

  final categories = ['All', 'Men', 'Women', 'Kid'];

  @override
  void initState() {
    BlocProvider.of<ShoesBloc>(
      context,
    ).add(FetchShoesByBrandEvent(brand: widget.brand));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        context.go('/brands');
      },
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: buildAppBar(),
          body: buildBody(context: context),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      leading: IconButton(
        onPressed: () {
          context.go('/brands');
        },
        icon: Icon(
          CupertinoIcons.back,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      title: Text(widget.brand, style: Theme.of(context).textTheme.titleLarge),
      centerTitle: true,
      bottom: TabBar(
        onTap: (index) {
          if (index == 0) {
            BlocProvider.of<ShoesBloc>(
              context,
            ).add(FetchShoesByBrandEvent(brand: widget.brand));
          } else {
            setState(() => category = categories[index]);
            BlocProvider.of<ShoesBloc>(context).add(
              FetchShoesByCategoryEvent(
                brand: widget.brand,
                category: category,
              ),
            );
          }
        },
        dividerColor: Theme.of(context).colorScheme.primary,
        indicatorColor: Theme.of(context).colorScheme.secondary,
        labelColor: Theme.of(context).colorScheme.secondary,
        labelStyle: Theme.of(context).textTheme.titleMedium,
        unselectedLabelColor: Theme.of(context).colorScheme.surface,
        unselectedLabelStyle: Theme.of(context).textTheme.titleMedium,
        tabs: [Text('All'), Text('Men'), Text('Women'), Text('Kid')],
      ),
    );
  }

  Widget buildBody({required BuildContext context}) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
          child: BlocBuilder<ShoesBloc, ShoesState>(
            builder: (context, state) {
              if (state.shoesStatus == ShoesStatus.loading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              }

              if (state.shoesStatus == ShoesStatus.shoesByBrandFetched) {
                return ShoesGridViewWidget(
                  shoes: state.shoesByBrand!,
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                );
              }

              if (state.shoesStatus == ShoesStatus.shoesByCategoryFetched) {
                return ShoesGridViewWidget(
                  shoes: state.shoesByCategory!,
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                );
              }

              if (state.shoesStatus == ShoesStatus.fetchShoesByBrandError) {
                return ErrorStateWidget(message: state.errorMessage!);
              }

              if (state.shoesStatus == ShoesStatus.fetchShoesByCategoryError) {
                return ErrorStateWidget(message: state.errorMessage!);
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
