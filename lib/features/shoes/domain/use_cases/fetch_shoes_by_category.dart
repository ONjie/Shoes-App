import 'package:either_dart/either.dart';
import '../../../../core/core.dart';
import '../entities/shoe_entity.dart';
import '../repositories/shoes_repository.dart';


class FetchShoesByCategory{

  final ShoesRepository shoesRepository;

  FetchShoesByCategory({required this.shoesRepository});

  Future<Either<Failure, List<ShoeEntity>>> call({required String category})
  async => await shoesRepository.fetchShoesByCategory(category: category);

}