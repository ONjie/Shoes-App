import 'package:either_dart/either.dart';
import '../../../../core/core.dart';
import '../entities/shoe_entity.dart';
import '../repositories/shoes_repository.dart';

class FetchLatestShoes{

  final ShoesRepository shoesRepository;

  FetchLatestShoes({required this.shoesRepository});

  Future<Either<Failure, List<ShoeEntity>>> call()
  async => await shoesRepository.fetchLatestShoes();

}