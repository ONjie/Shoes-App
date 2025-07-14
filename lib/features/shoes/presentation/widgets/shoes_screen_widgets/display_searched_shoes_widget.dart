import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoes_app/features/shoes/domain/entities/shoe_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/core.dart';
import '../../bloc/shoes_bloc.dart';

class DisplaySearchedShoesWidget extends StatefulWidget {
  const DisplaySearchedShoesWidget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  State<DisplaySearchedShoesWidget> createState() =>
      _DisplaySearchedShoesWidgetState();
}

class _DisplaySearchedShoesWidgetState
    extends State<DisplaySearchedShoesWidget> {
  bool isLoading = true;
  late List<ShoeEntity> shoes = ShoeEntity.mockShoes;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: widget.screenHeight,
        width: widget.screenWidth,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
          child: BlocConsumer<ShoesBloc, ShoesState>(
            listener: (context, state) {
              if (state.shoesStatus == ShoesStatus.loading) {
                setState(() {
                  shoes = ShoeEntity.mockShoes;
                  isLoading = true;
                });
              }
              if (state.shoesStatus == ShoesStatus.searchedShoesFetched) {
                setState(() {
                  shoes = state.searchedShoes!;
                  isLoading = false;
                });
              }
            },
            builder: (context, state) {
              if (state.shoesStatus == ShoesStatus.error) {
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
