import 'package:either_dart/either.dart';
import '../../../../core/core.dart';
import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';

class CreateOrder {
  CreateOrder({required this.ordersRepository});

  final OrdersRepository ordersRepository;

  Future<Either<Failure, bool>> call({required OrderEntity order}) async =>
      await ordersRepository.createOrder(order: order);
}
