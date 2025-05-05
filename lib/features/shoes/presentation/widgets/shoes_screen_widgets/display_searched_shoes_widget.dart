import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../bloc/shoes_bloc.dart';

class DisplaySearchedShoesWidget extends StatelessWidget {
  const DisplaySearchedShoesWidget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(top: 16, left: 12, right: 12),
          child: BlocBuilder<ShoesBloc, ShoesState>(
            builder: (context, state) {
              if (state.shoesStatus == ShoesStatus.loading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              }

              if (state.shoesStatus == ShoesStatus.searchedShoesFetched) {
                return ShoesGridViewWidget(
                  shoes: state.searchedShoes!,
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                );
              }

              if (state.shoesStatus == ShoesStatus.error) {
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
