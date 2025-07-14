import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_app/features/shoes/domain/entities/shoe_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/core.dart';
import '../bloc/shoes_bloc.dart';
import '../widgets/shoe_details_screen_widgets/app_bar_widget.dart';
import '../widgets/shoe_details_screen_widgets/body_widget.dart';

class ShoeDetailsScreen extends StatefulWidget {
  const ShoeDetailsScreen({super.key, required this.shoeId});

  final int shoeId;

  @override
  State<ShoeDetailsScreen> createState() => _ShoeDetailsScreenState();
}

class _ShoeDetailsScreenState extends State<ShoeDetailsScreen> {
  bool isLoading = true;
  late ShoeEntity shoe = ShoeEntity.mockShoes[0];
  @override
  void initState() {
    BlocProvider.of<ShoesBloc>(
      context,
    ).add(FetchShoeEvent(shoeId: widget.shoeId));
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
        context.go('/home/0');
      },
      child: BlocConsumer<ShoesBloc, ShoesState>(
        listener: (context, state) {
          if (state.shoesStatus == ShoesStatus.shoeFetched) {
            setState(() {
              shoe = state.shoe!;
              isLoading = false;
            });
          }
        },
        builder: (context, state) {
          if (state.shoesStatus == ShoesStatus.fetchShoeError) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                child: ErrorStateWidget(message: state.errorMessage!),
              ),
            );
          }

          return Skeletonizer(
            enabled: isLoading,
            enableSwitchAnimation: true,
            effect: ShimmerEffect(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              duration: Duration(seconds: 1),
            ),
            child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              appBar: appBarWidget(
                shoeTitle: shoe.title,
                isFavorite: shoe.isFavorite,
                context: context,
                isLoading: isLoading,
              ),
              body: BodyWidget(shoe: shoe),
            ),
          );
        },
      ),
    );
  }
}
