import 'package:equatable/equatable.dart';

class DeliveryDestinationEntity extends Equatable {
  const DeliveryDestinationEntity({
    this.id,
    required this.country,
    required this.city,
    required this.name,
    required this.contactNumber,
    required this.googlePlusCode,
    this.createdAt
  });

  final int? id;
  final String country;
  final String name;
  final String city;
  final String googlePlusCode;
  final String contactNumber;
  final DateTime? createdAt;

  @override
  List<Object?> get props => [
    id,
    country,
    name,
    city,
    googlePlusCode,
    contactNumber,
    createdAt
  ];

  static List<DeliveryDestinationEntity> mockDeliveryDestinations = [
    DeliveryDestinationEntity(
      country: 'country',
      city: 'city',
      name: 'name',
      contactNumber: 'contactNumber',
      googlePlusCode: 'googlePlusCode',
      createdAt: DateTime.parse('2025-06-04T18:42:46.032373')
    ),
    DeliveryDestinationEntity(
      country: 'country',
      city: 'city',
      name: 'name',
      contactNumber: 'contactNumber',
      googlePlusCode: 'googlePlusCode',
      createdAt: DateTime.parse('2025-06-04T18:43:46.032373')
    ),
    DeliveryDestinationEntity(
      country: 'country',
      city: 'city',
      name: 'name',
      contactNumber: 'contactNumber',
      googlePlusCode: 'googlePlusCode',
      createdAt: DateTime.parse('2025-06-04T18:45:46.032373')
    ),
  ];
}
