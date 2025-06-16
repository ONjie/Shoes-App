import 'package:either_dart/either.dart';
import 'package:shoes_app/core/exceptions/exceptions.dart';
import 'package:shoes_app/core/failures/failures.dart';
import 'package:shoes_app/core/network/network_info.dart';
import 'package:shoes_app/core/utils/text/error_messages.dart';
import 'package:shoes_app/features/orders/data/data_sources/remote_data/orders_remote_database_service.dart';
import 'package:shoes_app/features/orders/data/models/order_model.dart';
import 'package:shoes_app/features/orders/domain/entities/order_entity.dart';
import 'package:shoes_app/features/orders/domain/repositories/orders_repository.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  OrdersRepositoryImpl({
    required this.networkInfo,
    required this.ordersRemoteDatabaseService,
  });

  final NetworkInfo networkInfo;
  final OrdersRemoteDatabaseService ordersRemoteDatabaseService;

  @override
  Future<Either<Failure, bool>> createOrder({
    required OrderEntity order,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(
        InternetConnectionFailure(message: noInternetConnectionMessage),
      );
    }

    try {
      final orderModel = OrderModel.fromOrderEntity(order);

      final result = await ordersRemoteDatabaseService.createOrder(
        order: orderModel,
      );

      return Right(result);
    } on SupabaseDatabaseException catch (e) {
      return Left(SupabaseDatabaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteOrder({required int orderId}) async {
    if (!await networkInfo.isConnected) {
      return Left(
        InternetConnectionFailure(message: noInternetConnectionMessage),
      );
    }

    try {
      final result = await ordersRemoteDatabaseService.deleteOrder(
        orderId: orderId,
      );
      return Right(result);
    } on SupabaseDatabaseException catch (e) {
      return Left(SupabaseDatabaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, OrderEntity>> fetchOrder({
    required int orderId,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(
        InternetConnectionFailure(message: noInternetConnectionMessage),
      );
    }

    try {
      final result = await ordersRemoteDatabaseService.fetchOrder(
        orderId: orderId,
      );

      return Right(result.toOrderEntity());
    } on SupabaseDatabaseException catch (e) {
      return Left(SupabaseDatabaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> fetchOrders() async {
    if (!await networkInfo.isConnected) {
      return Left(
        InternetConnectionFailure(message: noInternetConnectionMessage),
      );
    }

    try {
      final results = await ordersRemoteDatabaseService.fetchOrders();

      final orders = results.map((result) => result.toOrderEntity()).toList();

      return Right(orders);
    } on SupabaseDatabaseException catch (e) {
      return Left(SupabaseDatabaseFailure(message: e.message));
    } on OtherExceptions catch (e) {
      return Left(OtherFailure(message: e.message));
    }
  }
}
