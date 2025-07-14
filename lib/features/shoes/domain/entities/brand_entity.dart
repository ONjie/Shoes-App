import 'package:equatable/equatable.dart';

class BrandEntity extends Equatable {
  const BrandEntity({required this.brand, required this.logo});
  final String brand;
  final String logo;

  @override
  List<Object?> get props => [brand, logo];

  static final brands = [
    BrandEntity(brand: 'Nike', logo: 'assets/icons/nike_logo.png'),
    BrandEntity(brand: 'Adidas', logo: 'assets/icons/adidas_logo.png'),
    BrandEntity(brand: 'Puma', logo: 'assets/icons/puma_logo.png'),
    BrandEntity(brand: 'Reebok', logo: 'assets/icons/reebok_logo.png'),
  ];
}
