import 'package:shoes_app/core/core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/delivery_destination_model.dart';

abstract class DeliveryDestinationRemoteDatabaseService {
  Future<List<DeliveryDestinationModel>> fetchDeliveryDestinations();

  Future<void> addDeliveryDestination({
    required DeliveryDestinationModel deliveryDestination,
  });

  Future<void> updateDeliveryDestination({
    required DeliveryDestinationModel deliveryDestination,
  });

  Future<void> deleteDeliveryDestination({required int deliveryDestinationId});
}

class DeliveryDestinationRemoteDatabaseServiceImpl
    implements DeliveryDestinationRemoteDatabaseService {
  DeliveryDestinationRemoteDatabaseServiceImpl({required this.supabaseClient});

  final SupabaseClient supabaseClient;

  @override
  Future<void> addDeliveryDestination({
    required DeliveryDestinationModel deliveryDestination,
  }) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;

      await supabaseClient.from('delivery_destination').insert({
        'user_id': userId,
        'country': deliveryDestination.country,
        'city': deliveryDestination.city,
        'name': deliveryDestination.name,
        'contact_number': deliveryDestination.contactNumber,
        'google_plus_code': deliveryDestination.googlePlusCode,
        'created_at': deliveryDestination.createdAt?.toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw SupabaseDatabaseException(message: e.toString());
    }
  }

  @override
  Future<void> deleteDeliveryDestination({
    required int deliveryDestinationId,
  }) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;

      await supabaseClient
          .from('delivery_destination')
          .delete()
          .filter('user_id', 'eq', userId)
          .eq('id', deliveryDestinationId);
    } catch (e) {
      throw SupabaseDatabaseException(message: e.toString());
    }
  }

  @override
  Future<List<DeliveryDestinationModel>> fetchDeliveryDestinations() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;

      final results = await supabaseClient
          .from('delivery_destination')
          .select()
          .filter('user_id', 'eq', userId);

      if (results.isEmpty) {
        throw SupabaseDatabaseException(
          message: 'No delivery destinations found',
        );
      }

      final deliveryDestinations =
          results.map((e) => DeliveryDestinationModel.fromJson(e)).toList();

      return deliveryDestinations;
    } catch (e) {
      if (e is SupabaseDatabaseException) {
        rethrow;
      }
      throw OtherExceptions(message: e.toString());
    }
  }

  @override
  Future<void> updateDeliveryDestination({
    required DeliveryDestinationModel deliveryDestination,
  }) async {
    try {
      await supabaseClient
          .from('delivery_destination')
          .update(
            deliveryDestination
                .copyWith(
                  id: deliveryDestination.id,
                  country: deliveryDestination.country,
                  name: deliveryDestination.name,
                  city: deliveryDestination.city,
                  googlePlusCode: deliveryDestination.googlePlusCode,
                  contactNumber: deliveryDestination.contactNumber,
                  updatedAt: DateTime.now(),
                  createdAt: deliveryDestination.createdAt
                )
                .toJson(),
          )
          .eq('id', deliveryDestination.id!);
    } catch (e) {
      throw SupabaseDatabaseException(message: e.toString());
    }
  }
}
