import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoes_app/features/shoes/domain/entities/favorite_shoe_entity.dart';
import 'package:shoes_app/features/shoes/domain/entities/shoe_entity.dart';
import 'package:shoes_app/features/shoes/domain/repositories/shoes_repository.dart';
import 'package:shoes_app/features/shoes/domain/use_cases/use_cases.dart';

class MockShoesRepository extends Mock implements ShoesRepository {}

void main() {
  late AddShoeToFavoriteShoes addShoeToFavoriteShoes;
  late MockShoesRepository mockShoesRepository;

  setUp(() {
    mockShoesRepository = MockShoesRepository();
    addShoeToFavoriteShoes = AddShoeToFavoriteShoes(
      shoesRepository: mockShoesRepository,
    );
  });

  const tShoeEntity = ShoeEntity(
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
    isFavorite: true,
  );
  const tFavoriteShoeEntity = FavoriteShoeEntity(
    id: 1,
    shoeId: 1,
    title: 'title',
    image: 'image1',
    price: 100,
    ratings: 2.5,
    isFavorite: true,
  );

  test('should return Right(true) from ShoesRepository', () async {
    //arrange
    when(
      () =>
          mockShoesRepository.addShoeToFavoriteShoes(shoe: tShoeEntity),
    ).thenAnswer((_) async => const Right(tFavoriteShoeEntity));

    //act
    final result = await addShoeToFavoriteShoes.call(shoe: tShoeEntity);

    //assert
    expect(result, const Right(tFavoriteShoeEntity));
    verify(
      () =>
          mockShoesRepository.addShoeToFavoriteShoes(shoe: tShoeEntity),
    ).called(1);
    verifyNoMoreInteractions(mockShoesRepository);
  });
}
