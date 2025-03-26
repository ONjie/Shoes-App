import 'package:either_dart/either.dart';
import 'package:shoes_api/core/exceptions/exceptions.dart';
import 'package:shoes_api/core/failures/failures.dart';
import 'package:shoes_api/src/shoes/data_sources/remote_data/supabase_database.dart';
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

  Future<EitherShoeListOrFailure> fetchShoesByCategory({
    required String category,
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
  ShoesRepositoryImpl({required this.supabaseDatabase});
  final SupabaseDatabase supabaseDatabase;

  Future<EitherShoeListOrFailure> _fetchShoes({
    required FetchFunction fetchFunction,
  }) async {
    try {
      final shoes = await fetchFunction();

      return Right(shoes);
    } on SupabaseException catch (e) {
      return Left(SupabaseFailure(message: e.message));
    } on OtherException catch (e) {
      return Left(OtherFailure(message: e.message));
    }
  }

  @override
  Future<EitherShoeListOrFailure> fetchLatestShoes() async {
    return _fetchShoes(fetchFunction: supabaseDatabase.fetchLatestShoes);
  }

  @override
  Future<EitherShoeListOrFailure> fetchLatestShoesByBrand({
    required String brand,
  }) async {
    return _fetchShoes(
      fetchFunction: () =>
          supabaseDatabase.fetchLatestShoesByBrand(brand: brand),
    );
  }

  @override
  Future<EitherShoeListOrFailure> fetchOtherShoes() async {
    return _fetchShoes(fetchFunction: supabaseDatabase.fetchOtherShoes);
  }

  @override
  Future<EitherShoeListOrFailure> fetchOtherShoesByBrand({
    required String brand,
  }) async {
    return _fetchShoes(
      fetchFunction: () =>
          supabaseDatabase.fetchOtherShoesByBrand(brand: brand),
    );
  }

  @override
  Future<EitherShoeListOrFailure> fetchPopularShoes() async {
    return _fetchShoes(fetchFunction: supabaseDatabase.fetchPopularShoes);
  }

  @override
  Future<EitherShoeListOrFailure> fetchPopularShoesByBrand({
    required String brand,
  }) async {
    return _fetchShoes(
      fetchFunction: () =>
          supabaseDatabase.fetchPopularShoesByBrand(brand: brand),
    );
  }

  @override
  Future<Either<Failure, Shoe>> fetchShoeById({required int id}) async {
    try {
      final shoe = await supabaseDatabase.fetchShoeById(id: id);

      return Right(shoe);
    } on SupabaseException catch (e) {
      return Left(SupabaseFailure(message: e.message));
    } on OtherException catch (e) {
      return Left(OtherFailure(message: e.message)) ;
    }
  }

  @override
  Future<EitherShoeListOrFailure> fetchShoes() async {
    return _fetchShoes(fetchFunction: supabaseDatabase.fetchShoes);
  }

  @override
  Future<EitherShoeListOrFailure> fetchShoesByBrand({required String brand}) async {
    return _fetchShoes(
      fetchFunction: () => supabaseDatabase.fetchShoesByBrand(brand: brand),
    );
  }

  @override
  Future<EitherShoeListOrFailure> fetchShoesByCategory(
      {required String category,}) async {
    return _fetchShoes(
      fetchFunction: () => supabaseDatabase.fetchShoesByCategory(category: category),
    );
  }

  @override
  Future<EitherShoeListOrFailure> fetchShoesSuggestions(
      {required String title,}) async {
    return _fetchShoes(
      fetchFunction: () => supabaseDatabase.fetchShoesSuggestions(title: title),
    );
  }
}
