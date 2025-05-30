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

  Future<DeliveryDestinationModel> fetchDeliveryDestination({
    required int deliveryDestinationId,
  });
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
        'created_at': DateTime.now(),
        'updated_at': DateTime.now(),
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
  Future<DeliveryDestinationModel> fetchDeliveryDestination({
    required int deliveryDestinationId,
  }) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;

      final result =
          await supabaseClient
              .from('delivery_destination')
              .select()
              .filter('user_id', 'eq', userId)
              .eq('id', deliveryDestinationId)
              .single();

      return DeliveryDestinationModel.fromJson(result);
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

      final deliveryDestinations =
          results.map((e) => DeliveryDestinationModel.fromJson(e)).toList();

      return deliveryDestinations;
    } catch (e) {
      throw SupabaseDatabaseException(message: e.toString());
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
                )
                .toJson(),
          )
          .eq('id', deliveryDestination.id!);
    } catch (e) {
      throw SupabaseDatabaseException(message: e.toString());
    }
  }
}
