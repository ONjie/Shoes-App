import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
      child: BlocBuilder<ShoesBloc, ShoesState>(
        builder: (context, state) {
          if (state.shoesStatus == ShoesStatus.loading) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Theme.of(context).colorScheme.surface,
              child: Center(
                child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
              ),
            );
          }

          if (state.shoesStatus == ShoesStatus.shoeFetched) {
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              appBar: appBarWidget(
                shoeTitle: state.shoe!.title,
                isFavorite: state.shoe!.isFavorite,
                context: context,
              ),
              body: BodyWidget(shoe: state.shoe!,),
            );
          }

          if (state.shoesStatus == ShoesStatus.fetchShoeError) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                child: ErrorStateWidget(
                  message: state.errorMessage!,
                ),
              ),
            );
          }

          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(color: Theme.of(context).colorScheme.surface),
          );
        },
      ),
    );
  }
}
