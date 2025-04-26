import 'package:either_dart/either.dart';
import '../../../../core/core.dart';
import '../entities/shoe_entity.dart';
import '../repositories/shoes_repository.dart';

class FetchLatestShoesByBrand{

  final ShoesRepository shoesRepository;

  FetchLatestShoesByBrand({required this.shoesRepository});

  Future<Either<Failure, List<ShoeEntity>>> call({required String brand})
  async => await shoesRepository.fetchLatestShoesByBrand(brand: brand);

}