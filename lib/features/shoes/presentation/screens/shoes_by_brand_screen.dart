import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_app/features/shoes/domain/entities/shoe_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

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

  late List<ShoeEntity> shoes = ShoeEntity.mockShoes;

  bool isLoading = true;

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
        labelStyle: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontSize: 18),
        unselectedLabelColor: Theme.of(context).colorScheme.surface,
        unselectedLabelStyle: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontSize: 18),
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
          child: BlocConsumer<ShoesBloc, ShoesState>(
            listener: (context, state) {
              if (state.shoesStatus == ShoesStatus.loading) {
                setState(() {
                  shoes = ShoeEntity.mockShoes;
                  isLoading = true;
                });
              }
              if (state.shoesStatus == ShoesStatus.shoesByBrandFetched) {
                setState(() {
                  shoes = state.shoesByBrand!;
                  isLoading = false;
                });
              }

              if (state.shoesStatus == ShoesStatus.shoesByCategoryFetched) {
                setState(() {
                  shoes = state.shoesByCategory!;
                  isLoading = false;
                });
              }
            },
            builder: (context, state) {
              if (state.shoesStatus == ShoesStatus.fetchShoesByBrandError) {
                return ErrorStateWidget(message: state.errorMessage!);
              }

              if (state.shoesStatus == ShoesStatus.fetchShoesByCategoryError) {
                return ErrorStateWidget(message: state.errorMessage!);
              }

              return Skeletonizer(
                enabled: isLoading,
                enableSwitchAnimation: true,
                effect: ShimmerEffect(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  duration: Duration(seconds: 1),
                ),
                child: ShoesGridViewWidget(shoes: shoes),
              );
            },
          ),
        ),
      ),
    );
  }
}
