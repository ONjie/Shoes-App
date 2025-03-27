class SupabaseException implements Exception {

  SupabaseException({required this.message});
  final String message;
}

class OtherException implements Exception {
  OtherException({required this.message});
  final String message;
}
