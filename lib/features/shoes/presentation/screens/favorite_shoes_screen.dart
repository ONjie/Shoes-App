import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../bloc/shoes_bloc.dart';
import '../widgets/favorite_shoes_screen_widgets/favorite_shoes_grid_view_widget.dart';


class FavoriteShoesScreen extends StatefulWidget {
  const FavoriteShoesScreen({super.key});

  @override
  State<FavoriteShoesScreen> createState() => _FavoriteShoesScreenState();
}

class _FavoriteShoesScreenState extends State<FavoriteShoesScreen> {

  @override
  void initState() {
    BlocProvider.of<ShoesBloc>(context).add(FetchFavoriteShoesEvent());
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

  AppBar buildAppBar(){
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      title: Text(
        'Favorite',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.secondary),
      ),
      centerTitle: true,
    );
  }

  Widget buildBody({required BuildContext context}){
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, right: 12, left: 12, bottom: 0),
          child: BlocBuilder<ShoesBloc, ShoesState>(
              builder: (context, state){

                if(state.shoesStatus == ShoesStatus.loading){
                  return Center(
                    child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary,),
                  );
                }

                if(state.shoesStatus == ShoesStatus.favoriteShoesFetched){
                  return FavoriteShoesGridViewWidget(
                    favoriteShoes: state.favoriteShoes!,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                  );
                }

                if(state.shoesStatus == ShoesStatus.fetchFavoriteShoesError){
                  return ErrorStateWidget(
                    message: state.errorMessage!,
                  );
                }

                return Container();
              }
          ),
        ),
      ),
    );
  }
}
