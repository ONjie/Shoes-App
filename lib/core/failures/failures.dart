
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];

}

class OtherFailure extends Failure{
  const OtherFailure({required super.message});
}

class SupabaseAuthFailure extends Failure{
  const SupabaseAuthFailure({required super.message});

}

class InternetConnectionFailure extends Failure{
  const InternetConnectionFailure({required super.message});
}

class ServerFailure extends Failure{
  const ServerFailure({required super.message});
}

class DatabaseFailure extends Failure{
  const DatabaseFailure({required super.message});
}

class StripePaymentFailure extends Failure{
  const StripePaymentFailure({required super.message});
}