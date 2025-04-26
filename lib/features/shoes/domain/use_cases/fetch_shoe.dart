import 'package:either_dart/either.dart';

import '../../../../core/core.dart';
import '../entities/shoe_entity.dart';
import '../repositories/shoes_repository.dart';

class FetchShoe{

  final ShoesRepository shoesRepository;

  FetchShoe({required this.shoesRepository});

  Future<Either<Failure, ShoeEntity>> call({required int shoeId})
  async => await shoesRepository.fetchShoe(shoeId: shoeId);

}
