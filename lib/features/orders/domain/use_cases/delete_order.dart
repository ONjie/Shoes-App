import 'package:either_dart/either.dart';

import '../../../../core/core.dart';
import '../repositories/orders_repository.dart';


class DeleteOrder{

  DeleteOrder({required this.ordersRepository});

  final OrdersRepository ordersRepository;

  Future<Either<Failure, bool>> call({required int orderId})
  async => await ordersRepository.deleteOrder(orderId: orderId);
}