import 'package:either_dart/either.dart';
import '../../../../core/core.dart';
import '../entities/order_entity.dart';

abstract class OrdersRepository {
  Future<Either<Failure, bool>> createOrder({required OrderEntity order});

  Future<Either<Failure, List<OrderEntity>>> fetchOrders();

  Future<Either<Failure, OrderEntity>> fetchOrder({required int orderId});

  Future<Either<Failure, bool>> deleteOrder({required int orderId});
}
