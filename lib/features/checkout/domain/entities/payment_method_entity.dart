import 'package:equatable/equatable.dart';

class PaymentMethodEntity extends Equatable {
  const PaymentMethodEntity({required this.label, required this.assetPath});

  final String label;
  final String assetPath;
  
  @override
  List<Object?> get props => [label, assetPath];


 
}
 final paymentMethod = PaymentMethodEntity(label: 'Stripe', assetPath: 'assets/icons/stripe_logo.jpeg');
