import 'package:either_dart/either.dart';

import '../../../../core/core.dart';
import '../entities/favorite_shoe_entity.dart';
import '../entities/shoe_entity.dart';

typedef FailureOrShoeEntityList = Either<Failure, List<ShoeEntity>>;
typedef FailureOrFavoriteShoeEntityList =
    Either<Failure, List<FavoriteShoeEntity>>;

abstract class ShoesRepository {
  Future<FailureOrShoeEntityList> fetchLatestShoes();

  Future<FailureOrShoeEntityList> fetchLatestShoesByBrand({
    required String brand,
  });

  Future<FailureOrShoeEntityList> fetchPopularShoes();

  Future<FailureOrShoeEntityList> fetchPopularShoesByBrand({
    required String brand,
  });

  Future<FailureOrShoeEntityList> fetchOtherShoes();

  Future<FailureOrShoeEntityList> fetchOtherShoesByBrand({
    required String brand,
  });

  Future<FailureOrShoeEntityList> fetchShoesByBrand({required String brand});

  Future<FailureOrShoeEntityList> fetchShoesByCategory({
    required String category,
  });

  Future<Either<Failure, ShoeEntity>> fetchShoe({required int shoeId});

  Future<FailureOrShoeEntityList> fetchShoesSuggestions({required shoeTitle});

  Future<Either<Failure, FavoriteShoeEntity>> addShoeToFavoriteShoes({
    required ShoeEntity shoe,
  });

  Future<Either<Failure, bool>> deleteShoeFromFavoriteShoes({
    required int shoeId,
  });

  Future<Either<Failure, List<FavoriteShoeEntity>>> fetchFavoriteShoes();
}
