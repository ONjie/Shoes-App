import 'package:either_dart/either.dart';

import '../../../../core/core.dart';
import '../repositories/shoes_repository.dart';

class DeleteShoeFromFavoriteShoes{
  final ShoesRepository shoesRepository;

  DeleteShoeFromFavoriteShoes({required this.shoesRepository});

  Future<Either<Failure, bool>> call({required int shoeId}) async
  => await shoesRepository.deleteShoeFromFavoriteShoes(shoeId: shoeId);
}