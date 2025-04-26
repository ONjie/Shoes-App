import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/features/shoes/domain/entities/shoe_entity.dart';
import 'package:shoes_app/features/shoes/domain/repositories/shoes_repository.dart';
import 'package:shoes_app/features/shoes/domain/use_cases/use_cases.dart';

class MockShoesRepository extends Mock implements ShoesRepository {}

void main() {
  late FetchShoe fetchShoe;
  late MockShoesRepository mockShoesRepository;

  setUp(() {
    mockShoesRepository = MockShoesRepository();

    fetchShoe = FetchShoe(shoesRepository: mockShoesRepository);
  });

  const tShoeEntity = ShoeEntity(
    id: 1,
    title: 'title',
    description: 'description',
    images: ['image1', 'image2', 'image3'],
    price: 100,
    brand: 'brand',
    colors: ['color1', 'color2', 'color3'],
    sizes: [1, 2, 3, 4, 5],
    isPopular: false,
    isNew: true,
    category: 'category',
    ratings: 1.5,
    isFavorite: false,
  );

  const tShoeId = 1;

  test('should return Right(ShoeEntity) from ShoesRepository', () async {
    //arrange
    when(
      () => mockShoesRepository.fetchShoe(shoeId: any(named: 'shoeId')),
    ).thenAnswer((_) async => const Right(tShoeEntity));

    //act
    final result = await fetchShoe.call(shoeId: tShoeId);

    //assert
    expect(result, const Right(tShoeEntity));
    verify(
      () => mockShoesRepository.fetchShoe(shoeId: any(named: 'shoeId')),
    ).called(1);
    verifyNoMoreInteractions(mockShoesRepository);
  });
}
