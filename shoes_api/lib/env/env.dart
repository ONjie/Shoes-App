import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'SUPABASE_URL')
  static String supabaseUrl = _Env.supabaseUrl;

  @EnviedField(varName: 'SUPABASE_KEY')
  static String supabaseKey = _Env.supabaseKey;

  @EnviedField(varName: 'STRIPE_SECRET_KEY')
  static String stripeSecretKey = _Env.stripeSecretKey;

  @EnviedField(varName: 'STRIPE_PUBLISHABLE_KEY')
  static String stripePublishableKey = _Env.stripePublishableKey;

  @EnviedField(varName: 'REDIS_HOST')
  static String redisHost = _Env.redisHost;

  @EnviedField(varName: 'REDIS_PORT')
  static String redisPort = _Env.redisPort;

   @EnviedField(varName: 'REDIS_USERNAME')
  static String redisUsername = _Env.redisUsername;

  @EnviedField(varName: 'REDIS_PASSWORD')
  static String redisPassword = _Env.redisPassword;

  @EnviedField(varName: 'CACHE_KEY')
  static String cacheKey = _Env.cacheKey;
}
