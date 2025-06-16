part of 'checkout_bloc.dart';

enum CheckoutStatus { initial, loading, paymentSuccessful, paymentFailed}

class CheckoutState extends Equatable {
  final CheckoutStatus checkoutStatus;
  final String? message;
  const CheckoutState({required this.checkoutStatus, this.message});

  @override
  List<Object?> get props => [
    checkoutStatus,
    message
  ];
}
