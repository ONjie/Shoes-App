import 'package:shoes_app/core/core.dart';
import 'package:shoes_app/features/orders/data/models/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class OrdersRemoteDatabaseService {
  Future<bool> createOrder({required OrderModel order});

  Future<List<OrderModel>> fetchOrders();

  Future<OrderModel> fetchOrder({required int orderId});

  Future<bool> deleteOrder({required int orderId});
}

class OrdersRemoteDatabaseServiceImpl implements OrdersRemoteDatabaseService {
  OrdersRemoteDatabaseServiceImpl({required this.supabaseClient});

  final SupabaseClient supabaseClient;

  @override
  Future<bool> createOrder({required OrderModel order}) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      await supabaseClient.from('orders').insert({
        "order_id": order.orderId,
        "estimated_delivery_date":
            order.estimatedDeliveryDate.toIso8601String(),
        "order_status": order.orderStatus,
        "payment_method": order.paymentMethod,
        "delivery_destination": order.deliveryDestination,
        "ordered_items":
            order.orderedItems
                .map((orderedItem) => orderedItem.toJson())
                .toList(),
        "total_cost": order.totalCost,
        "user_id": userId,
        "created_at": DateTime.now().toIso8601String(),
      });
      return true;
    } catch (e) {
      throw SupabaseDatabaseException(message: e.toString());
    }
  }

  @override
  Future<bool> deleteOrder({required int orderId}) async {
    try {
      await supabaseClient.from('orders').delete().eq('order_id', orderId);
      return true;
    } catch (e) {
      throw SupabaseDatabaseException(message: e.toString());
    }
  }

  @override
  Future<OrderModel> fetchOrder({required int orderId}) async {
    try {
      final order =
          await supabaseClient
              .from('orders')
              .select()
              .eq('order_id', orderId)
              .single();
      return OrderModel.fromJson(order);
    } catch (e) {
      throw SupabaseDatabaseException(message: e.toString());
    }
  }

  @override
  Future<List<OrderModel>> fetchOrders() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      final results = await supabaseClient
          .from('orders')
          .select()
          .eq('user_id', userId!);

      if (results.isEmpty) {
        throw SupabaseDatabaseException(message: 'No orders founds');
      }
      final orders =
          results.map((result) => OrderModel.fromJson(result)).toList();
      return orders;
    } catch (e) {
      if (e is SupabaseDatabaseException) {
        rethrow;
      }
      throw OtherExceptions(message: e.toString());
    }
  }
}
