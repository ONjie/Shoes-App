import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/core.dart';
import '../../domain/entities/favorite_shoe_entity.dart';
import '../bloc/shoes_bloc.dart';
import '../widgets/favorite_shoes_screen_widgets/favorite_shoes_grid_view_widget.dart';

class FavoriteShoesScreen extends StatefulWidget {
  const FavoriteShoesScreen({super.key});

  @override
  State<FavoriteShoesScreen> createState() => _FavoriteShoesScreenState();
}

class _FavoriteShoesScreenState extends State<FavoriteShoesScreen> {
  bool isLoading = true;

  late List<FavoriteShoeEntity> favoriteShoes = FavoriteShoeEntity.mockFavoriteShoes;

  @override
  void initState() {
    BlocProvider.of<ShoesBloc>(context).add(FetchFavoriteShoesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: buildBody(context: context),
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
          padding: const EdgeInsets.only(
            top: 16,
            right: 12,
            left: 12,
            bottom: 0,
          ),
          child: BlocConsumer<ShoesBloc, ShoesState>(
            listener: (context, state) {
              if (state.shoesStatus == ShoesStatus.favoriteShoesFetched) {
      
                setState(() {
                  favoriteShoes = state.favoriteShoes!;
                  isLoading = false;
                });
              }
            },
            builder: (context, state) {
              if (state.shoesStatus == ShoesStatus.fetchFavoriteShoesError) {
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
                child: FavoriteShoesGridViewWidget(
                  favoriteShoes: favoriteShoes,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
