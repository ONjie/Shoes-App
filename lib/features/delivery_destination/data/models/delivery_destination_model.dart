import 'package:equatable/equatable.dart';
import 'package:shoes_app/features/delivery_destination/domain/entities/delivery_destination_entity.dart';

typedef MapJson = Map<String, dynamic>;

class DeliveryDestinationModel extends Equatable {
  const DeliveryDestinationModel({
    this.id,
    required this.country,
    required this.city,
    required this.name,
    required this.contactNumber,
    required this.googlePlusCode,
    this.updatedAt,
    this.createdAt
  });

  final int? id;
  final String country;
  final String name;
  final String city;
  final String googlePlusCode;
  final String contactNumber;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  DeliveryDestinationModel copyWith({
    final int? id,
    final String? country,
    final String? name,
    final String? city,
    final String? googlePlusCode,
    final String? contactNumber,
    final DateTime? updatedAt,
    final DateTime? createdAt
  }) => DeliveryDestinationModel(
    id: id ?? this.id,
    country: country ?? this.city,
    city: city ?? this.city,
    name: name ?? this.name,
    contactNumber: contactNumber ?? this.contactNumber,
    googlePlusCode: googlePlusCode ?? this.googlePlusCode,
    updatedAt: updatedAt ?? this.updatedAt,
    createdAt: createdAt ?? this.createdAt
  );

  static DeliveryDestinationModel fromJson(MapJson json) =>
      DeliveryDestinationModel(
        id: json['id'] as int?,
        country: json['country'] as String,
        city: json['city'] as String,
        name: json['name'] as String,
        contactNumber: json['contact_number'] as String,
        googlePlusCode: json['google_plus_code'] as String,
        updatedAt: DateTime.parse(json['updated_at']),
        createdAt: DateTime.parse(json['created_at'])
      );

  MapJson toJson() {
    return {
      'id': id,
      'country': country,
      'city': city,
      'name': name,
      'contact_number': contactNumber,
      'google_plus_code': googlePlusCode,
      'updated_at': updatedAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String()
    };
  }

  DeliveryDestinationEntity toDeliveryDestinationEntity() =>
      DeliveryDestinationEntity(
        id: id,
        country: country,
        city: city,
        name: name,
        contactNumber: contactNumber,
        googlePlusCode: googlePlusCode,
        createdAt: createdAt
      );

  @override
  List<Object?> get props => [
    id,
    name,
    city,
    contactNumber,
    country,
    googlePlusCode,
    updatedAt,
    createdAt
  ];
}
