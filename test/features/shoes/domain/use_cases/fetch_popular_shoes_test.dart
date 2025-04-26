import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/features/shoes/domain/entities/shoe_entity.dart';
import 'package:shoes_app/features/shoes/domain/repositories/shoes_repository.dart';
import 'package:shoes_app/features/shoes/domain/use_cases/use_cases.dart';

class MockShoesRepository extends Mock implements ShoesRepository {}

void main() {
  late FetchPopularShoes fetchPopularShoes;
  late MockShoesRepository mockShoesRepository;

  setUp(() {
    mockShoesRepository = MockShoesRepository();

    fetchPopularShoes = FetchPopularShoes(shoesRepository: mockShoesRepository);
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

  final tShoeEntityList = [tShoeEntity];

  test('should return Right(List<ShoeEntity>) from ShoesRepository', () async {
    //arrange
    when(
      () => mockShoesRepository.fetchPopularShoes(),
    ).thenAnswer((_) async => Right(tShoeEntityList));

    //act
    final result = await fetchPopularShoes.call();

    //assert
    expect(result, Right(tShoeEntityList));
    verify(() => mockShoesRepository.fetchPopularShoes()).called(1);
    verifyNoMoreInteractions(mockShoesRepository);
  });
}
