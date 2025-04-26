import 'package:either_dart/either.dart';
import '../../../../core/core.dart';
import '../entities/favorite_shoe_entity.dart';
import '../repositories/shoes_repository.dart';

class FetchFavoriteShoes{
  final ShoesRepository shoesRepository;

  FetchFavoriteShoes({required this.shoesRepository});

  Future<Either<Failure, List<FavoriteShoeEntity>>> call() async
  => await shoesRepository.fetchFavoriteShoes();
}