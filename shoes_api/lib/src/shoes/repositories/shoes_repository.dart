import 'package:either_dart/either.dart';
import 'package:shoes_api/core/exceptions/exceptions.dart';
import 'package:shoes_api/core/failures/failures.dart';
import 'package:shoes_api/src/shoes/data_sources/remote_data/redis_cache_service.dart';
import 'package:shoes_api/src/shoes/models/shoe.dart';

typedef EitherShoeListOrFailure = Either<Failure, List<Shoe>>;
typedef FetchFunction = Future<List<Shoe>> Function();

abstract class ShoesRepository {
  Future<EitherShoeListOrFailure> fetchShoes();

  Future<EitherShoeListOrFailure> fetchShoesSuggestions({
    required String title,
  });

  Future<Either<Failure, Shoe>> fetchShoeById({required int id});

  Future<EitherShoeListOrFailure> fetchShoesByBrand({required String brand});

  Future<EitherShoeListOrFailure> fetchShoesByCategoryAndBrand({
    required String category,
    required String brand,
  });

  Future<EitherShoeListOrFailure> fetchLatestShoes();

  Future<EitherShoeListOrFailure> fetchPopularShoes();

  Future<EitherShoeListOrFailure> fetchOtherShoes();

  Future<EitherShoeListOrFailure> fetchLatestShoesByBrand({
    required String brand,
  });

  Future<EitherShoeListOrFailure> fetchPopularShoesByBrand({
    required String brand,
  });

  Future<EitherShoeListOrFailure> fetchOtherShoesByBrand({
    required String brand,
  });
}

class ShoesRepositoryImpl implements ShoesRepository {
  ShoesRepositoryImpl({
    required this.redisService,
  });
  final RedisCacheService redisService;

  Future<EitherShoeListOrFailure> _fetchShoes({
    required FetchFunction fetchFunction,
  }) async {
    try {
      final shoes = await fetchFunction();

      return Right(shoes);
    } on RedisCacheException catch (e) {
      return Left(RedisCacheFailure(message: e.message));
    } on OtherException catch (e) {
      return Left(OtherFailure(message: e.message));
    }
  }

  @override
  Future<EitherShoeListOrFailure> fetchLatestShoes() async {
    return _fetchShoes(fetchFunction: redisService.fetchLatestShoes);
  }

  @override
  Future<EitherShoeListOrFailure> fetchLatestShoesByBrand({
    required String brand,
  }) async {
    return _fetchShoes(
      fetchFunction: () => redisService.fetchLatestShoesByBrand(brand: brand),
    );
  }

  @override
  Future<EitherShoeListOrFailure> fetchOtherShoes() async {
    return _fetchShoes(fetchFunction: redisService.fetchOtherShoes);
  }

  @override
  Future<EitherShoeListOrFailure> fetchOtherShoesByBrand({
    required String brand,
  }) async {
    return _fetchShoes(
      fetchFunction: () => redisService.fetchOtherShoesByBrand(brand: brand),
    );
  }

  @override
  Future<EitherShoeListOrFailure> fetchPopularShoes() async {
    return _fetchShoes(
      fetchFunction: redisService.fetchPopularShoes,
    );
  }

  @override
  Future<EitherShoeListOrFailure> fetchPopularShoesByBrand({
    required String brand,
  }) async {
    return _fetchShoes(
      fetchFunction: () => redisService.fetchPopularShoesByBrand(brand: brand),
    );
  }

  @override
  Future<Either<Failure, Shoe>> fetchShoeById({required int id}) async {
    try {
      final shoe = await redisService.fetchShoeById(id: id);

      return Right(shoe);
    } on RedisCacheException catch (e) {
      return Left(RedisCacheFailure(message: e.message));
    } on OtherException catch (e) {
      return Left(OtherFailure(message: e.message));
    }
  }

  @override
  Future<EitherShoeListOrFailure> fetchShoes() async {
    return _fetchShoes(fetchFunction: redisService.fetchShoes);
  }

  @override
  Future<EitherShoeListOrFailure> fetchShoesByBrand({
    required String brand,
  }) async {
    return _fetchShoes(
      fetchFunction: () => redisService.fetchShoesByBrand(brand: brand),
    );
  }

  @override
  Future<EitherShoeListOrFailure> fetchShoesByCategoryAndBrand({
    required String category,
    required String brand,
  }) async {
    return _fetchShoes(
      fetchFunction: () => redisService.fetchShoesByCategoryAndBrand(
        category: category,
        brand: brand,
      ),
    );
  }

  @override
  Future<EitherShoeListOrFailure> fetchShoesSuggestions({
    required String title,
  }) async {
    return _fetchShoes(
      fetchFunction: () => redisService.fetchShoesSuggestions(title: title),
    );
  }
}
