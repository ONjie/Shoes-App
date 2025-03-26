
import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_api/src/shoes/data_sources/remote_data/supabase_database.dart';
import 'package:shoes_api/src/shoes/repositories/shoes_repository.dart';
import 'package:test/test.dart';

import '../../../../../routes/api/v1/shoes/_middleware.dart';

class _MockRequestContext extends Mock implements RequestContext {}

class MockSupabaseDatabase extends Mock implements SupabaseDatabase {}

void main() {
  late MockSupabaseDatabase mockSupabaseDatabase;

  setUp(() {
    mockSupabaseDatabase = MockSupabaseDatabase();
  });

  test('should provide both ShoesRepository and SupabaseDatabase instances', () async {
    //arrange
    late ShoesRepository shoesRepository;
    late SupabaseDatabase supabaseDatabase;

    final shoesRepositoryImpl = ShoesRepositoryImpl(
      supabaseDatabase: mockSupabaseDatabase,
    );

    final handler = middleware((context) {
      when(() => context.read<ShoesRepository>())
          .thenReturn(shoesRepositoryImpl);
      when(() => context.read<SupabaseDatabase>())
          .thenReturn(mockSupabaseDatabase);

      shoesRepository = context.read<ShoesRepository>();
      supabaseDatabase = context.read<SupabaseDatabase>();

      return Response.json();
    });

    final request = Request.get(Uri.parse('http://localhost/'));
    final context = _MockRequestContext();

    when(() => context.request).thenReturn(request);
    when(() => context.provide<ShoesRepository>(any())).thenReturn(context);
    when(() => context.provide<SupabaseDatabase>(any())).thenReturn(context);

    //act
    await handler(context);

    //assert
    expect(shoesRepository, isA<ShoesRepository>());
    expect(supabaseDatabase, isA<SupabaseDatabase>());

    verify(() => context.read<ShoesRepository>()).called(1);
    verify(() => context.read<SupabaseDatabase>()).called(1);

    verify(() => context.provide<ShoesRepository>(captureAny())).captured.single
        as ShoesRepository Function();
    verify(() => context.provide<SupabaseDatabase>(captureAny()))
        .captured
        .single as SupabaseDatabase Function();
  });
}
