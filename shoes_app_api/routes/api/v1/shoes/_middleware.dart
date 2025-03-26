import 'package:dart_frog/dart_frog.dart';
import 'package:shoes_api/env/env.dart';
import 'package:shoes_api/src/shoes/data_sources/remote_data/supabase_database.dart';
import 'package:shoes_api/src/shoes/repositories/shoes_repository.dart';
import 'package:supabase/supabase.dart';

final _supabaseClient = SupabaseClient(
  Env.supabaseUrl,
  Env.supabaseKey,
);
final _supabaseDatabase = SupabaseDatabaseImpl(supabaseClient: _supabaseClient);
final _shoesRepository = ShoesRepositoryImpl(
  supabaseDatabase: _supabaseDatabase,
);

Handler middleware(Handler handler) {
  return handler
      .use(provider<ShoesRepository>((_) => _shoesRepository))
      .use(provider<SupabaseDatabase>((_) => _supabaseDatabase));
}
