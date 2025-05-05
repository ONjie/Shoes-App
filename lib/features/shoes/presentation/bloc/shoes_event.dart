part of 'shoes_bloc.dart';

sealed class ShoesEvent extends Equatable {
  const ShoesEvent();
}


class FetchShoeEvent extends ShoesEvent{
  final int shoeId;

  const FetchShoeEvent({required this.shoeId});

  @override
  List<Object?> get props => [shoeId];
}

class FetchShoesByCategoryEvent extends ShoesEvent{
  final String category;
  final String brand;

  const FetchShoesByCategoryEvent({required this.brand, required this.category});

  @override
  List<Object?> get props =>[brand, category];


}

class FetchShoesByBrandWithFilterEvent extends ShoesEvent{
  final String brand;

  const FetchShoesByBrandWithFilterEvent({required this.brand});

  @override
  List<Object?> get props => [brand];
}

class FetchShoesByBrandEvent extends ShoesEvent{
  final String brand;

  const FetchShoesByBrandEvent({required this.brand});

  @override
  List<Object?> get props => [brand];

}

class FetchSearchedShoesEvent extends ShoesEvent{
  final String shoeTitle;

  const FetchSearchedShoesEvent({required this.shoeTitle});

  @override
  List<Object?> get props => [shoeTitle];
}

class AddShoeToFavoriteShoesEvent extends ShoesEvent{
  final ShoeEntity shoe;

  const AddShoeToFavoriteShoesEvent({required this.shoe});

  @override
  List<Object?> get props => [shoe];
}

class DeleteShoeFromFavoriteShoesEvent extends ShoesEvent{
  final int shoeId;

  const DeleteShoeFromFavoriteShoesEvent({required this.shoeId});

  @override
  List<Object?> get props => [shoeId];
}

class FetchFavoriteShoesEvent extends ShoesEvent{
  @override
  List<Object?> get props => [];

}

