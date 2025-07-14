import 'package:dart_frog/dart_frog.dart';
import 'package:redis/redis.dart';
import 'package:shoes_api/src/shoes/data_sources/remote_data/redis_cache_service.dart';
import 'package:shoes_api/src/shoes/repositories/shoes_repository.dart';


final _redisCacheServiceImpl =
    RedisCacheServiceImpl(connection: RedisConnection());
final _shoesRepository = ShoesRepositoryImpl(
  redisService: _redisCacheServiceImpl,
);

Handler middleware(Handler handler) {
  _redisCacheServiceImpl.init();
  return handler.use(provider<ShoesRepository>((_) => _shoesRepository)).use(
    provider<RedisCacheService>((_) => _redisCacheServiceImpl),
  );
}
