import 'package:either_dart/either.dart';

import '../../../../core/core.dart';
import '../entities/shoe_entity.dart';
import '../repositories/shoes_repository.dart';


class FetchShoesByBrand{

  final ShoesRepository shoesRepository;

  FetchShoesByBrand({required this.shoesRepository});

  Future<Either<Failure, List<ShoeEntity>>> call({required String brand})
  async => await shoesRepository.fetchShoesByBrand(brand: brand);

}