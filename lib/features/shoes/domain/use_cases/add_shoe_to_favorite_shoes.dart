import 'package:either_dart/either.dart';
import 'package:shoes_app/features/shoes/domain/repositories/shoes_repository.dart';
import '../../../../core/core.dart';
import '../entities/favorite_shoe_entity.dart';
import '../entities/shoe_entity.dart';

class AddShoeToFavoriteShoes{

  final ShoesRepository shoesRepository;

  AddShoeToFavoriteShoes({required this.shoesRepository});

  Future<Either<Failure, FavoriteShoeEntity>> call({required ShoeEntity shoe}) async
  => await shoesRepository.addShoeToFavoriteShoes(shoe: shoe);
}