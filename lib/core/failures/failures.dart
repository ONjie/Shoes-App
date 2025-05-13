import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class OtherFailure extends Failure {
  const OtherFailure({required super.message});
}

class SupabaseAuthFailure extends Failure {
  const SupabaseAuthFailure({required super.message});
}

class InternetConnectionFailure extends Failure {
  const InternetConnectionFailure({required super.message});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

class LocalDatabaseFailure extends Failure {
  const LocalDatabaseFailure({required super.message});
}

class SupabaseDatabaseFailure extends Failure {
  const SupabaseDatabaseFailure({required super.message});
}

class SupabaseStorageFailure extends Failure {
  const SupabaseStorageFailure({required super.message});
}

class StripePaymentFailure extends Failure {
  const StripePaymentFailure({required super.message});
}
