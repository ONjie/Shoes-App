import 'package:either_dart/either.dart';
import '../../../../core/core.dart';
import '../entities/shoe_entity.dart';
import '../repositories/shoes_repository.dart';

class FetchPopularShoes{
  final ShoesRepository shoesRepository;

  FetchPopularShoes({required this.shoesRepository});

  Future<Either<Failure, List<ShoeEntity>>> call()
  async => await shoesRepository.fetchPopularShoes();

}