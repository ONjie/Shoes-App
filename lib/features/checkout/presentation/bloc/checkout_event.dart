part of 'checkout_bloc.dart';

sealed class CheckoutEvent extends Equatable {
  const CheckoutEvent();
}

class MakePaymentEvent extends CheckoutEvent {
  final int totalCost;

  const MakePaymentEvent({required this.totalCost});
  
  @override
  List<Object?> get props => [totalCost];


  
}
