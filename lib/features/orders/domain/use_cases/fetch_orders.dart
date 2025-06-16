import 'package:either_dart/either.dart';

import '../../../../core/core.dart';
import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';

class FetchOrders{

  FetchOrders({required this.ordersRepository});

  final OrdersRepository ordersRepository;

  Future<Either<Failure, List<OrderEntity>>> call()
  async => await ordersRepository.fetchOrders();
}