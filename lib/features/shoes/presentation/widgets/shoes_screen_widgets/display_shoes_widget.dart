import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../bloc/shoes_bloc.dart';
import 'display_latest_shoes_widget.dart';
import 'display_other_shoes_widget.dart';
import 'display_popular_shoes_widget.dart';

class DisplayShoesWidget extends StatefulWidget {
  const DisplayShoesWidget({super.key});

  @override
  State<DisplayShoesWidget> createState() => _DisplayShoesWidgetState();
}

class _DisplayShoesWidgetState extends State<DisplayShoesWidget> {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoesBloc, ShoesState>(
      builder: (context, state) {

        if(state.shoesStatus == ShoesStatus.loading){
          return Center(
            child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary,),
          );
        }
        if(state.shoesStatus == ShoesStatus.shoesFetched){
          return Column(
            children: [
              state.latestShoesByBrand!.isNotEmpty ? DisplayLatestShoesWidget(latestShoes: state.latestShoesByBrand!,) : const SizedBox(),
              const SizedBox(height: 16,),
              state.popularShoesByBrand!.isNotEmpty ? DisplayPopularShoesWidget(popularShoes: state.popularShoesByBrand!,) : const SizedBox(),
              const SizedBox(height: 16,),
              state.otherShoesByBrand!.isNotEmpty ? DisplayOtherShoesWidget(otherShoes: state.otherShoesByBrand!,) : const SizedBox(),
            ],
          );
        }

        if(state.shoesStatus == ShoesStatus.fetchShoesError){
          return ErrorStateWidget(
            message: state.errorMessage!,
          );
        }
        return Container();
      },
    );
  }
}
