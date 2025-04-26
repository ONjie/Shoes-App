import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/features/shoes/domain/entities/shoe_entity.dart';
import 'package:shoes_app/features/shoes/domain/repositories/shoes_repository.dart';
import 'package:shoes_app/features/shoes/domain/use_cases/fetch_shoes_suggestions.dart';

class MockShoesRepository extends Mock implements ShoesRepository {}

void main() {
  late FetchShoesSuggestions fetchShoesSuggestions;
  late MockShoesRepository mockShoesRepository;

  setUp(() {
    mockShoesRepository = MockShoesRepository();
    fetchShoesSuggestions = FetchShoesSuggestions(
      shoesRepository: mockShoesRepository,
    );
  });

  const tShoeTitle = 'title';

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
    isNew: true,
    category: 'category',
    ratings: 1.5,
    isFavorite: false,
  );

  final tShoeEntityList = [tShoeEntity];

  test('should return Right(List<ShoeEntity>) from ShoesRepository', () async {
    //arrange
    when(
      () => mockShoesRepository.fetchShoesSuggestions(
        shoeTitle: any(named: 'shoeTitle'),
      ),
    ).thenAnswer((_) async => Right(tShoeEntityList));

    //act
    final result = await fetchShoesSuggestions.call(shoeTitle: tShoeTitle);

    //assert
    expect(result, Right(tShoeEntityList));
    verify(
      () => mockShoesRepository.fetchShoesSuggestions(
        shoeTitle: any(named: 'shoeTitle'),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockShoesRepository);
  });
}
