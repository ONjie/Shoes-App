part of 'shoes_bloc.dart';

enum ShoesStatus {
  initial,
  loading,
  shoesFetched,
  shoeFetched,
  favoriteShoesFetched,
  searchedShoesFetched,
  shoesByBrandFetched,
  shoesByCategoryFetched,
  fetchShoesError,
  fetchShoeError,
  fetchFavoriteShoesError,
  fetchSearchShoesError,
  fetchShoesByBrandError,
  fetchShoesByCategoryError,
  addShoeToFavoriteShoesError,
  deleteShoeFromFavoriteShoesError,
  error,
}

class ShoesState extends Equatable {
  const ShoesState({
    required this.shoesStatus,
    this.latestShoesByBrand,
    this.popularShoesByBrand,
    this.otherShoesByBrand,
    this.searchedShoes,
    this.shoesByBrand,
    this.shoesByCategory,
    this.favoriteShoes,
    this.shoe,
    this.successMessage,
    this.errorMessage,
  });

  final ShoesStatus shoesStatus;
  final List<ShoeEntity>? latestShoesByBrand;
  final List<ShoeEntity>? popularShoesByBrand;
  final List<ShoeEntity>? otherShoesByBrand;
  final List<ShoeEntity>? searchedShoes;
  final List<ShoeEntity>? shoesByBrand;
  final List<ShoeEntity>? shoesByCategory;
  final List<FavoriteShoeEntity>? favoriteShoes;
  final ShoeEntity? shoe;
  final String? successMessage;
  final String? errorMessage;

  @override
  List<Object?> get props => [
    shoesStatus,
    latestShoesByBrand,
    popularShoesByBrand,
    otherShoesByBrand,
    searchedShoes,
    shoesByBrand,
    shoesByCategory,
    favoriteShoes,
    shoe,
    successMessage,
    errorMessage,
  ];
}
