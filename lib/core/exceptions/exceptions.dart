
class ServerException implements Exception{
  final String message;

  ServerException({required this.message});
}

class LocalDatabaseException implements Exception{
  final String message;

  LocalDatabaseException({required this.message});
}

class OtherExceptions implements Exception{
  final String message;

  OtherExceptions({required this.message});
}

class StripePaymentException implements Exception{
  final String message;

  StripePaymentException({required this.message});
}

class SupabaseAuthException implements Exception{
  final String message;

  SupabaseAuthException({required this.message});
}