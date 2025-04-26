import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/features/shoes/domain/entities/shoe_entity.dart';

import 'package:shoes_app/features/shoes/domain/repositories/shoes_repository.dart';
import 'package:shoes_app/features/shoes/domain/use_cases/use_cases.dart';

class MockShoesRepository extends Mock implements ShoesRepository {}

void main() {
  late FetchLatestShoesByBrand fetchLatestShoesByBrand;
  late MockShoesRepository mockShoesRepository;

  setUp(() {
    mockShoesRepository = MockShoesRepository();

    fetchLatestShoesByBrand = FetchLatestShoesByBrand(
      shoesRepository: mockShoesRepository,
    );
  });

  const testShoeEntity = ShoeEntity(
    id: 1,
    title: 'Title',
    description: 'Description',
    images: ['image1', 'image2', 'image3'],
    price: 100,
    brand: 'Shoe',
    colors: ['color1', 'color2', 'color3'],
    sizes: [1, 2, 3, 4, 5],
    isPopular: false,
    isNew: true,
    category: 'Men',
    ratings: 1.5,
    isFavorite: false,
  );

  const testBrand = 'Nike';

  final testShoeEntities = [testShoeEntity];

  test('should return Right(List<ShoeEntity>) from ShoesRepository', () async {
    //arrange
    when(
      () => mockShoesRepository.fetchLatestShoesByBrand(
        brand: any(named: 'brand'),
      ),
    ).thenAnswer((_) async => Right(testShoeEntities));

    //act
    final result = await fetchLatestShoesByBrand.call(brand: testBrand);

    //assert
    expect(result, Right(testShoeEntities));
    verify(
      () => mockShoesRepository.fetchLatestShoesByBrand(
        brand: any(named: 'brand'),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockShoesRepository);
  });
}
