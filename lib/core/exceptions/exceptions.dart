
class ServerException implements Exception{
  final String message;

  ServerException({required this.message});
}

class DatabaseException implements Exception{
  final String message;

  DatabaseException({required this.message});
}

class OtherExceptions implements Exception{
  final String message;

  OtherExceptions({required this.message});
}

class StripePaymentException implements Exception{
  final String message;

  StripePaymentException({required this.message});
}