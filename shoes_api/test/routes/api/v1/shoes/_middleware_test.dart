import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_api/src/shoes/data_sources/remote_data/redis_cache_service.dart';
import 'package:shoes_api/src/shoes/repositories/shoes_repository.dart';
import 'package:test/test.dart';

import '../../../../../routes/api/v1/shoes/_middleware.dart';

class _MockRequestContext extends Mock implements RequestContext {}

class MockRedisCacheService extends Mock implements RedisCacheService {}

void main() {
  late MockRedisCacheService mockRedisCacheService;

  setUp(() {
    mockRedisCacheService = MockRedisCacheService();
  });

  test('should provide ShoesRepository, RedisCacheService and SupabaseDatabaseService instances',
      () async {
    //arrange
    late ShoesRepository shoesRepository;
    late RedisCacheService redisCacheService;

    final shoesRepositoryImpl = ShoesRepositoryImpl(
      redisService: mockRedisCacheService,
    );

    final handler = middleware((context) {
      when(() => context.read<ShoesRepository>())
          .thenReturn(shoesRepositoryImpl);
      when(() => context.read<RedisCacheService>())
          .thenReturn(mockRedisCacheService);

      shoesRepository = context.read<ShoesRepository>();
      redisCacheService = context.read<RedisCacheService>();

      return Response.json();
    });

    final request = Request.get(Uri.parse('http://localhost/'));
    final context = _MockRequestContext();

    when(() => context.request).thenReturn(request);
    when(() => context.provide<ShoesRepository>(any())).thenReturn(context);
    when(() => context.provide<RedisCacheService>(any())).thenReturn(context);
    

    //act
    await handler(context);

    //assert
    expect(shoesRepository, isA<ShoesRepository>());
    expect(redisCacheService, isA<RedisCacheService>());
   

    verify(() => context.read<ShoesRepository>()).called(1);
    verify(() => context.read<RedisCacheService>()).called(1);
  

    verify(() => context.provide<ShoesRepository>(captureAny())).captured.single
        as ShoesRepository Function();
    verify(() => context.provide<RedisCacheService>(captureAny()))
        .captured
        .single as RedisCacheService Function();
  });
}
