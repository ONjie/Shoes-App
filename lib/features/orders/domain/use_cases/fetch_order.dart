import 'package:either_dart/either.dart';
import '../../../../core/core.dart';
import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';


class FetchOrder{

  FetchOrder({required this.ordersRepository});

  final OrdersRepository ordersRepository;

  Future<Either<Failure, OrderEntity>> call({required int orderId})
  async => await ordersRepository.fetchOrder(orderId: orderId);
}