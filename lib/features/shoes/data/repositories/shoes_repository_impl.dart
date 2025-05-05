import 'package:either_dart/either.dart';
import 'package:shoes_app/features/shoes/data/data_sources/remote_data/shoes_api_service.dart';

import 'package:shoes_app/features/shoes/domain/entities/favorite_shoe_entity.dart';

import 'package:shoes_app/features/shoes/domain/entities/shoe_entity.dart';

import '../../../../core/core.dart';
import '../../domain/repositories/shoes_repository.dart';
import '../models/shoe_model.dart';

typedef _FunctionChooser = Future<List<ShoeModel>> Function();

class ShoesRepositoryImpl implements ShoesRepository {
  ShoesRepositoryImpl({
    required this.networkInfo,
    required this.shoesApiService,
  });
  final NetworkInfo networkInfo;
  final ShoesApiService shoesApiService;

  Future<FailureOrShoeEntityList> _fetchShoes({
    required _FunctionChooser functionChooser,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(
        InternetConnectionFailure(message: noInternetConnectionMessage),
      );
    }

    try {
      final fetchedShoes = await functionChooser();

      final shoes =
          fetchedShoes.map((shoe) {
            return ShoeModel(
              id: shoe.id,
              title: shoe.title,
              description: shoe.description,
              images: shoe.images,
              price: shoe.price,
              brand: shoe.brand,
              colors: shoe.colors,
              sizes: shoe.sizes,
              isPopular: shoe.isPopular,
              isNew: shoe.isNew,
              ratings: shoe.ratings,
              category: shoe.category,
              isFavorite: false,
            ).toShoeEntity();
          }).toList();

      return Right(shoes);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, FavoriteShoeEntity>> addShoeToFavoriteShoes({
    required ShoeEntity shoe,
  }) {
    // TODO: implement addShoeToFavoriteShoes
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deleteShoeFromFavoriteShoes({
    required int shoeId,
  }) {
    // TODO: implement deleteShoeFromFavoriteShoes
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<FavoriteShoeEntity>>> fetchFavoriteShoes() {
    // TODO: implement fetchFavoriteShoes
    throw UnimplementedError();
  }

  @override
  Future<FailureOrShoeEntityList> fetchLatestShoes() async {
    return await _fetchShoes(
      functionChooser: () => shoesApiService.fetchLatestShoes(),
    );
  }

  @override
  Future<FailureOrShoeEntityList> fetchLatestShoesByBrand({
    required String brand,
  }) async {
    return await _fetchShoes(
      functionChooser:
          () => shoesApiService.fetchLatestShoesByBrand(brand: brand),
    );
  }

  @override
  Future<FailureOrShoeEntityList> fetchOtherShoes() async {
    return await _fetchShoes(
      functionChooser: () => shoesApiService.fetchOtherShoes(),
    );
  }

  @override
  Future<FailureOrShoeEntityList> fetchOtherShoesByBrand({
    required String brand,
  }) async {
    return await _fetchShoes(
      functionChooser:
          () => shoesApiService.fetchOtherShoesByBrand(brand: brand),
    );
  }

  @override
  Future<FailureOrShoeEntityList> fetchPopularShoes() async {
    return await _fetchShoes(
      functionChooser: () => shoesApiService.fetchPopularShoes(),
    );
  }

  @override
  Future<FailureOrShoeEntityList> fetchPopularShoesByBrand({
    required String brand,
  }) async {
    return await _fetchShoes(
      functionChooser:
          () => shoesApiService.fetchPopularShoesByBrand(brand: brand),
    );
  }

  @override
  Future<Either<Failure, ShoeEntity>> fetchShoe({required int shoeId}) async {
    if (!await networkInfo.isConnected) {
      return Left(
        InternetConnectionFailure(message: noInternetConnectionMessage),
      );
    }

    try {
      final fetchedShoe = await shoesApiService.fetchShoe(shoeId: shoeId);

      return Right(fetchedShoe.toShoeEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<FailureOrShoeEntityList> fetchShoesByBrand({
    required String brand,
  }) async {
    return await _fetchShoes(
      functionChooser: () => shoesApiService.fetchShoesByBrand(brand: brand),
    );
  }

  @override
  Future<FailureOrShoeEntityList> fetchShoesByCategory({
    required String category,
    required String brand,
  }) async {
    return await _fetchShoes(
      functionChooser:
          () => shoesApiService.fetchShoesByCategory(
            category: category,
            brand: brand,
          ),
    );
  }

  @override
  Future<FailureOrShoeEntityList> fetchShoesSuggestions({
    required shoeTitle,
  }) async {
    return await _fetchShoes(
      functionChooser:
          () => shoesApiService.fetchShoesSuggestions(shoeTitle: shoeTitle),
    );
  }
}
