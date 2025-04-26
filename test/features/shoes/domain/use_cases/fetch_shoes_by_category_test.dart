import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/features/shoes/domain/entities/shoe_entity.dart';
import 'package:shoes_app/features/shoes/domain/repositories/shoes_repository.dart';
import 'package:shoes_app/features/shoes/domain/use_cases/fetch_shoes_by_category.dart';

class MockShoesRepository extends Mock implements ShoesRepository {}

void main() {
  late FetchShoesByCategory fetchShoesByCategory;
  late MockShoesRepository mockShoesRepository;

  setUp(() {
    mockShoesRepository = MockShoesRepository();

    fetchShoesByCategory = FetchShoesByCategory(
      shoesRepository: mockShoesRepository,
    );
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
    isPopular: true,
    isNew: false,
    category: 'category',
    ratings: 1.5,
    isFavorite: false,
  );

  const tCategory = 'Men';

  final tShoeEntityList = [tShoeEntity];

  test('should return Right(List<ShoeEntity>) from ShoesRepository', () async {
    //arrange
    when(
      () => mockShoesRepository.fetchShoesByCategory(
        category: any(named: 'category'),
      ),
    ).thenAnswer((_) async => Right(tShoeEntityList));

    //act
    final result = await fetchShoesByCategory.call(category: tCategory);

    //assert
    expect(result, Right(tShoeEntityList));
    verify(
      () => mockShoesRepository.fetchShoesByCategory(
        category: any(named: 'category'),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockShoesRepository);
  });
}
