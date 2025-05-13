import 'package:either_dart/either.dart';
import '../../../../core/core.dart';
import '../entities/cart_item_entity.dart';
import '../repositories/cart_repository.dart';

class FetchCartItems{
  final CartRepository cartRepository;

  FetchCartItems({required this.cartRepository});

  Future<Either<Failure, List<CartItemEntity>>> call()
  async => await cartRepository.fetchCartItems();
}