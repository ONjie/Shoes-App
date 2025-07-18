import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

class SupabaseFailure extends Failure {
  const SupabaseFailure({required super.message});
}

class OtherFailure extends Failure {
  const OtherFailure({required super.message});
}

class RedisCacheFailure extends Failure {
  const RedisCacheFailure({required super.message});
}
