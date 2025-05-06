import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../domain/entities/favorite_shoe_entity.dart';
import '../../domain/entities/shoe_entity.dart';
import '../../domain/use_cases/use_cases.dart';

part 'shoes_event.dart';
part 'shoes_state.dart';

class ShoesBloc extends Bloc<ShoesEvent, ShoesState> {
  final FetchLatestShoes fetchLatestShoes;
  final FetchPopularShoes fetchPopularShoes;
  final FetchOtherShoes fetchOtherShoes;
  final FetchLatestShoesByBrand fetchLatestShoesByBrand;
  final FetchPopularShoesByBrand fetchPopularShoesByBrand;
  final FetchOtherShoesByBrand fetchOtherShoesByBrand;
  final FetchShoesSuggestions fetchShoesSuggestions;
  final FetchShoesByBrand fetchShoesByBrand;
  final FetchShoesByCategory fetchShoesByCategory;
  final FetchShoe fetchShoe;
  final FetchFavoriteShoes fetchFavoriteShoes;
  final AddShoeToFavoriteShoes addShoeToFavoriteShoes;
  final DeleteShoeFromFavoriteShoes deleteShoeFromFavoriteShoes;
  ShoesBloc({
    required this.fetchLatestShoes,
    required this.fetchPopularShoes,
    required this.fetchOtherShoes,
    required this.fetchLatestShoesByBrand,
    required this.fetchPopularShoesByBrand,
    required this.fetchOtherShoesByBrand,
    required this.fetchShoesSuggestions,
    required this.fetchShoesByBrand,
    required this.fetchShoesByCategory,
    required this.fetchShoe,
    required this.fetchFavoriteShoes,
    required this.addShoeToFavoriteShoes,
    required this.deleteShoeFromFavoriteShoes,
  }) : super(const ShoesState(shoesStatus: ShoesStatus.initial)) {
    on<FetchShoesByBrandWithFilterEvent>(_onFetchShoesByBrandWithFilter);
    on<FetchSearchedShoesEvent>(_onFetchSearchedShoes);
    on<FetchShoesByBrandEvent>(_onFetchShoesByBrand);
    on<FetchShoesByCategoryEvent>(_onFetchShoesByCategory);
    on<FetchShoeEvent>(_onFetchShoe);
    on<FetchFavoriteShoesEvent>(_onFetchFavoriteShoes);
    on<AddShoeToFavoriteShoesEvent>(_onAddShoeToFavoriteShoes);
    on<DeleteShoeFromFavoriteShoesEvent>(_onDeleteShoeFromFavoriteShoes);
  }

  _onFetchShoesByBrandWithFilter(
    FetchShoesByBrandWithFilterEvent event,
    Emitter<ShoesState> emit,
  ) async {
    late List<ShoeEntity> latestShoesByBrand = [];
    late List<ShoeEntity> popularShoesByBrand = [];
    late List<ShoeEntity> otherShoesByBrand = [];

    late String errorMessage = '';

    emit(const ShoesState(shoesStatus: ShoesStatus.loading));

    void handleSuccessAndFailure(Either<Failure, List<ShoeEntity>> result, Function(List<ShoeEntity>) onSuccess,) {
      result.fold((failure) => errorMessage = mapFailureToMessage(failure: failure), onSuccess,);
    }

    final latestShoesOrFailure = await fetchLatestShoesByBrand.call(brand: event.brand);
    handleSuccessAndFailure(latestShoesOrFailure, (shoes) => latestShoesByBrand = shoes);

    final popularShoesOrFailure = await fetchPopularShoesByBrand.call(brand: event.brand);
    handleSuccessAndFailure(popularShoesOrFailure, (shoes) => popularShoesByBrand = shoes);

    final otherShoesOrFailure = await fetchOtherShoesByBrand.call(brand: event.brand);
    handleSuccessAndFailure(otherShoesOrFailure, (shoes) => otherShoesByBrand = shoes);

    if (latestShoesOrFailure.isRight || popularShoesOrFailure.isRight || otherShoesOrFailure.isRight) {
      emit(ShoesState(
        shoesStatus: ShoesStatus.shoesFetched,
        latestShoesByBrand: latestShoesByBrand,
        popularShoesByBrand: popularShoesByBrand,
        otherShoesByBrand: otherShoesByBrand,
      ));
    }
    else {
      emit(ShoesState(
        shoesStatus: ShoesStatus.fetchShoesError,
        errorMessage: errorMessage,
      ));
    }
  }

  _onFetchSearchedShoes(
    FetchSearchedShoesEvent event,
    Emitter<ShoesState> emit,
  ) async {
    emit(const ShoesState(shoesStatus: ShoesStatus.loading));

    final searchedShoesOrFailure = await fetchShoesSuggestions.call(
      shoeTitle: event.shoeTitle,
    );

    searchedShoesOrFailure.fold(
      (failure) {
        emit(
          ShoesState(
            shoesStatus: ShoesStatus.fetchSearchShoesError,
            errorMessage: mapFailureToMessage(failure: failure),
          ),
        );
      },
      (searchedShoes) {
        emit(
          ShoesState(
            shoesStatus: ShoesStatus.searchedShoesFetched,
            searchedShoes: searchedShoes,
          ),
        );
      },
    );
  }

  _onFetchShoesByBrand(
    FetchShoesByBrandEvent event,
    Emitter<ShoesState> emit,
  ) async {
    emit(const ShoesState(shoesStatus: ShoesStatus.loading));

    final shoesOrFailure = await fetchShoesByBrand.call(brand: event.brand);

    shoesOrFailure.fold(
      (failure) {
        emit(
          ShoesState(
            shoesStatus: ShoesStatus.fetchShoesByBrandError,
            errorMessage: mapFailureToMessage(failure: failure),
          ),
        );
      },
      (shoes) {
        emit(
          ShoesState(
            shoesStatus: ShoesStatus.shoesByBrandFetched,
            shoesByBrand: shoes,
          ),
        );
      },
    );
  }

  _onFetchShoesByCategory(
    FetchShoesByCategoryEvent event,
    Emitter<ShoesState> emit,
  ) async {
    emit(const ShoesState(shoesStatus: ShoesStatus.loading));

    final fetchedShoesOrFailure = await fetchShoesByCategory.call(
      category: event.category,
      brand: event.brand,
    );

    fetchedShoesOrFailure.fold(
      (failure) {
        emit(
          ShoesState(
            shoesStatus: ShoesStatus.fetchShoesByCategoryError,
            errorMessage: mapFailureToMessage(failure: failure),
          ),
        );
      },

      (fetchedShoes) {
        emit(
          ShoesState(
            shoesStatus: ShoesStatus.shoesByCategoryFetched,
            shoesByCategory: fetchedShoes,
          ),
        );
      },
    );
  }

  _onFetchShoe(FetchShoeEvent event, Emitter<ShoesState> emit) async {
    emit(const ShoesState(shoesStatus: ShoesStatus.loading));

    final shoeOrFailure = await fetchShoe.call(shoeId: event.shoeId);

    shoeOrFailure.fold(
      (failure) {
        emit(
          ShoesState(
            shoesStatus: ShoesStatus.fetchShoeError,
            errorMessage: mapFailureToMessage(failure: failure),
          ),
        );
      },
      (shoe) {
        emit(ShoesState(shoesStatus: ShoesStatus.shoeFetched, shoe: shoe));
      },
    );
  }

  _onFetchFavoriteShoes(FetchFavoriteShoesEvent event, Emitter<ShoesState> emit) async {
    emit(const ShoesState(shoesStatus: ShoesStatus.loading));

    final favoriteShoesOrFailure = await fetchFavoriteShoes.call();

    favoriteShoesOrFailure.fold(
            (failure) {
              emit(ShoesState(
                  shoesStatus: ShoesStatus.fetchFavoriteShoesError,
                  errorMessage: mapFailureToMessage(failure: failure,),
                ),
              );
            },
            (favoriteShoes) {
              emit(ShoesState(
                  shoesStatus: ShoesStatus.favoriteShoesFetched,
                  favoriteShoes: favoriteShoes,),);
            }
    );
  }

  _onAddShoeToFavoriteShoes(AddShoeToFavoriteShoesEvent event, Emitter<ShoesState> emit)async{

    final favoriteShoeOrFailure = await addShoeToFavoriteShoes.call(shoe: event.shoe);

    favoriteShoeOrFailure.fold(
            (failure) {
              emit(ShoesState(
                  shoesStatus: ShoesStatus.addShoeToFavoriteShoesError,
                  errorMessage: mapFailureToMessage(failure: failure,),
              ),);
            },
            (right) => null,
    );
  }

  _onDeleteShoeFromFavoriteShoes(DeleteShoeFromFavoriteShoesEvent event, Emitter<ShoesState> emit) async {

    final trueOrFailure = await deleteShoeFromFavoriteShoes.call(shoeId: event.shoeId);

    trueOrFailure.fold(
          (failure) {
            emit(ShoesState(
                shoesStatus: ShoesStatus.deleteShoeFromFavoriteShoesError,
                errorMessage: mapFailureToMessage(failure: failure,),
            ),);
          },
          (right)  => null,
    );
  }


  
  }
