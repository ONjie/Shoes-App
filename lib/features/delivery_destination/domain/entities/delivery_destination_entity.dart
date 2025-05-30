import 'package:equatable/equatable.dart';

class DeliveryDestinationEntity extends Equatable {
  const DeliveryDestinationEntity({
    this.id,
    required this.country,
    required this.city,
    required this.name,
    required this.contactNumber,
    required this.googlePlusCode,
  });

  final int? id;
  final String country;
  final String name;
  final String city;
  final String googlePlusCode;
  final String contactNumber;

  @override
  List<Object?> get props => [
    id,
    country,
    name,
    city,
    googlePlusCode,
    contactNumber,
  ];
}
